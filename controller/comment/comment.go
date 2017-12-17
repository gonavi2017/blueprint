// Package comment provides a simple CRUD application in a web page.
package comment

import (
	"net/http"

	"github.com/gonavi2017/blueprint/lib/flight"
	"github.com/gonavi2017/blueprint/middleware/acl"
	"github.com/gonavi2017/blueprint/model/comment"

	"github.com/blue-jay/core/pagination"
	"github.com/blue-jay/core/router"
	"strconv"
)

var (
	parentURI = "/note"
	uri       = "/comment"
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

	comments, _, err := comment.ByNoteIDPaginate(c.DB, c.Param("id"), p.PerPage, p.Offset)
	if err != nil {
		c.FlashErrorGeneric(err)
		comments = []comment.Item{}
	}

	count, err := comment.ByNoteIDCount(c.DB, c.Param("id"))
	if err != nil {
		c.FlashErrorGeneric(err)
	}

	// Calculate the number of pages.
	p.CalculatePages(count)

	v := c.View.New("comment/index")
	v.Vars["comments"] = comments
	v.Vars["pagination"] = p
	v.Render(w, r)
}

// Create displays the create form.
func Create(w http.ResponseWriter, r *http.Request) {
	c := flight.Context(w, r)

	v := c.View.New("comment/create")
	c.Repopulate(v.Vars, "name")
	v.Render(w, r)
}

// Store handles the create form submission.
func Store(w http.ResponseWriter, r *http.Request) {
	c := flight.Context(w, r)

	if !c.FormValid("name") {
		Create(w, r)
		return
	}
	noteID := c.Param("id")
	_, err := comment.Create(c.DB, r.FormValue("name"), c.Param("id"), c.UserID)
	if err != nil {
		c.FlashErrorGeneric(err)
		Create(w, r)
		return
	}

	c.FlashSuccess("you comment added successfully.")
	c.Redirect(parentURI + "/view/" + noteID)
}

// Show displays a single item.
func Show(w http.ResponseWriter, r *http.Request) {
	c := flight.Context(w, r)

	// Create a pagination instance with a max of 10 results.
	p := pagination.New(r, 10)

	item, _, err := comment.ByID(c.DB, c.Param("id"), c.UserID)
	if err != nil {
		c.FlashErrorGeneric(err)
		c.Redirect(uri)
		return
	}

	items, _, err := comment.ByNoteIDPaginate(c.DB, c.Param("id"), p.PerPage, p.Offset)
	if err != nil {
		c.FlashErrorGeneric(err)
		items = []comment.Item{}
	}

	v := c.View.New("comment/show")
	v.Vars["item"] = item

	v.Vars["items"] = items
	v.Vars["pagination"] = p
	v.Render(w, r)

}

// Edit displays the edit form.
func Edit(w http.ResponseWriter, r *http.Request) {
	c := flight.Context(w, r)

	item, _, err := comment.ByID(c.DB, c.Param("id"), c.UserID)
	if err != nil {
		c.FlashErrorGeneric(err)
		c.Redirect(uri)
		return
	}

	v := c.View.New("comment/edit")
	c.Repopulate(v.Vars, "name")
	v.Vars["item"] = item
	v.Render(w, r)
}

// Update handles the edit form submission.
func Update(w http.ResponseWriter, r *http.Request) {
	c := flight.Context(w, r)

	if !c.FormValid("name") {
		Edit(w, r)
		return
	}
	item, _, err := comment.ByID(c.DB, c.Param("id"), c.UserID)
	if err != nil {
		c.FlashErrorGeneric(err)
		c.Redirect(uri)
		return
	}

	_, err = comment.Update(c.DB, r.FormValue("name"), c.Param("id"), c.UserID)
	if err != nil {
		c.FlashErrorGeneric(err)
		Edit(w, r)
		return
	}
	c.FlashSuccess("you comment updated successfully.")
	c.Redirect(parentURI + "/view/" + strconv.FormatUint(uint64(item.NoteID), 10))
}

// Destroy handles the delete form submission.
func Destroy(w http.ResponseWriter, r *http.Request) {
	c := flight.Context(w, r)

	item, _, err := comment.ByID(c.DB, c.Param("id"), c.UserID)
	if err != nil {
		c.FlashErrorGeneric(err)
		c.Redirect(uri)
		return
	}

	_, err = comment.DeleteSoft(c.DB, c.Param("id"), c.UserID)
	if err != nil {
		c.FlashErrorGeneric(err)
	} else {
		c.FlashSuccess("you comment deleted successfully.")
	}

	c.Redirect(parentURI + "/view/" + strconv.FormatUint(uint64(item.NoteID), 10))
}
