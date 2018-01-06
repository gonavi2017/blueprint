// Package login handles the user login.
package login

import (
	"errors"
	"net/http"
	"strings"

	"github.com/gonavi2017/blueprint/lib/flight"
	"github.com/gonavi2017/blueprint/lib/recaptcha"
	"github.com/gonavi2017/blueprint/middleware/acl"
	"github.com/gonavi2017/blueprint/model/user"

	"github.com/gonavi2017/core/flash"
	"github.com/gonavi2017/core/form"
	"github.com/gonavi2017/core/passhash"
	"github.com/gonavi2017/core/router"
	"github.com/gonavi2017/core/session"
)

//var _SiteKey string = "6Ld0Yz0UAAAAABmOy1l6J01GyJAP5K7V0-kUCPR-"

// Load the routes.
func Load() {
	router.Get("/login", Index, acl.DisallowAuth)
	router.Post("/login", Store, acl.DisallowAuth)
	router.Get("/logout", Logout)
}

// Index displays the login page.
func Index(w http.ResponseWriter, r *http.Request) {
	c := flight.Context(w, r)

	v := c.View.New("login/index")
	form.Repopulate(r.Form, v.Vars, "email")
	v.Render(w, r)
}

// Store handles the login form submission.
func Store(w http.ResponseWriter, r *http.Request) {
	c := flight.Context(w, r)

	// Validate with required fields
	if !c.FormValid("email", "password") {
		Index(w, r)
		return
	}
	SecretKey := "6Ld0Yz0UAAAAAJcV9fwXAQGO0AMi00K4ZxOCScJQ"
	re := recaptcha.Recaptcha{
		Secret: SecretKey,
	}
	isValid, errs := re.Verify(*r)
	if !isValid {
		c.FlashError(errors.New(strings.Join(errs, ",")))
		Index(w, r)
		return
	}

	// Form values
	email := r.FormValue("email")
	password := r.FormValue("password")

	// Get database result
	result, noRows, err := user.ByEmail(c.DB, email)

	// Determine if user exists
	if noRows {
		c.FlashWarning("Password is incorrect")
	} else if err != nil {
		// Display error message
		c.FlashErrorGeneric(err)
	} else if passhash.MatchString(result.Password, password) {
		if result.StatusID != 1 {
			// User inactive and display inactive message
			c.FlashNotice("Account is inactive so login is disabled.")
		} else {
			// Login successfully
			session.Empty(c.Sess)
			c.Sess.AddFlash(flash.Info{"Login successful!", flash.Success})
			c.Sess.Values["id"] = result.ID
			c.Sess.Values["email"] = email
			c.Sess.Values["first_name"] = result.FirstName
			c.Sess.Save(r, w)
			http.Redirect(w, r, "/", http.StatusFound)
			return
		}
	} else {
		c.FlashWarning("Password is incorrect")
	}

	// Show the login page again
	Index(w, r)
}

// Logout clears the session and logs the user out.
func Logout(w http.ResponseWriter, r *http.Request) {
	c := flight.Context(w, r)

	// If user is authenticated
	if c.Sess.Values["id"] != nil {
		session.Empty(c.Sess)
		c.FlashNotice("Goodbye!")
	}

	http.Redirect(w, r, "/", http.StatusFound)
}
