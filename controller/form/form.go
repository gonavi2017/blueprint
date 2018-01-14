// Package form provides a simple CRUD application in a web page.
package form

import (
	"github.com/gonavi2017/blueprint/lib/flight"
	"github.com/gonavi2017/blueprint/middleware/acl"
	"github.com/gonavi2017/blueprint/model/form"
	"github.com/gonavi2017/core/pagination"
	"github.com/gonavi2017/core/router"
	"net/http"
)

var (
	uri = "/form"
)

// Load the routes.
func Load() {
	c := router.Chain(acl.DisallowAnon)
	router.Get(uri, Index, c...)
	router.Get(uri+"/create/:id", Create, c...)
	router.Post(uri+"/create/:id", Store, c...)
	router.Get(uri+"/view/:id", Show, c...)
	router.Get(uri+"/edit/:id", Edit, c...)
	router.Patch(uri+"/edit/:id", Update, c...)
	router.Delete(uri+"/:id", Destroy, c...)
}

// Index displays the items.
func Index(w http.ResponseWriter, r *http.Request) {
	c := flight.Context(w, r)

	// Create a pagination instance with a max of 10 results.
	p := pagination.New(r, 10)

	forms, _, err := form.ByDescriptionPaginate(c.DB, "These")
	if err != nil {
		c.FlashErrorGeneric(err)
		forms = []form.Item{}
	}

	count, err := form.ByDescriptionCount(c.DB, "These")
	if err != nil {
		c.FlashErrorGeneric(err)
	}

	// Calculate the number of pages.
	p.CalculatePages(count)

	v := c.View.New("form/index")
	v.Vars["forms"] = forms
	v.Vars["pagination"] = p
	v.Render(w, r)
}

// Create displays the create form.
func Create(w http.ResponseWriter, r *http.Request) {
	c := flight.Context(w, r)
	v := c.View.New("lot/create")
	c.Repopulate(v.Vars, "name")
	v.Render(w, r)
}

// Store handles the create form submission.
func Store(w http.ResponseWriter, r *http.Request) {
	//admin only
}

// Show displays a single item.
func Show(w http.ResponseWriter, r *http.Request) {
	c := flight.Context(w, r)
	v := c.View.New("form/index")
	c.Repopulate(v.Vars, "name")
	v.Render(w, r)

}

// Edit displays the edit form.
func Edit(w http.ResponseWriter, r *http.Request) {
	//admin only
}

// Update handles the edit form submission.
func Update(w http.ResponseWriter, r *http.Request) {
	//admin only
}

// Destroy handles the delete form submission.
func Destroy(w http.ResponseWriter, r *http.Request) {
	//admin only
}
