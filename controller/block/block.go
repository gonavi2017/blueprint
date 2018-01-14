// Package block provides a simple CRUD application in a web page.
package block

import (
	"net/http"
	"strconv"

	"github.com/gonavi2017/blueprint/lib/flight"
	"github.com/gonavi2017/blueprint/middleware/acl"
	"github.com/gonavi2017/blueprint/model/block"
	"github.com/gonavi2017/blueprint/model/form"
	"github.com/gonavi2017/blueprint/model/lot"

	"github.com/gonavi2017/core/pagination"
	"github.com/gonavi2017/core/router"
)

var (
	uri = "/block"
)

// Load the routes.
func Load() {
	c := router.Chain(acl.DisallowAnon)
	router.Get(uri, Index, c...)
	router.Get(uri+"/create", Create, c...)
	router.Post(uri+"/create", Store, c...)
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

	items, _, err := block.ByUserIDPaginate(c.DB, c.UserID, p.PerPage, p.Offset)
	if err != nil {
		c.FlashErrorGeneric(err)
		items = []block.Item{}
	}

	count, err := block.ByUserIDCount(c.DB, c.UserID)
	if err != nil {
		c.FlashErrorGeneric(err)
	}

	// Calculate the number of pages.
	p.CalculatePages(count)

	v := c.View.New("block/index")

	//add fields to the form
	forms, _ := form.GetForms(c.DB)
	formID := 0
	for idx := range forms {
		if c.Param("id") == strconv.FormatUint(uint64(forms[idx].ID), 10) {
			formID = idx
			forms[idx].StatusID = 1
			forms[idx].Fields, _ = form.GetFields(c.DB)
			forms[idx].FieldTypes, _ = form.GetFieldTypes(c.DB)
		} else {
			forms[idx].StatusID = 0
		}
	}
	v.Vars["forms"] = forms
	for fld := range forms[formID].Fields {
		v.Vars[forms[formID].Fields[fld].Name] = ""
	}

	v.Vars["items"] = items
	v.Vars["pagination"] = p
	v.Render(w, r)
}

// Create displays the create form.
func Create(w http.ResponseWriter, r *http.Request) {
	c := flight.Context(w, r)

	v := c.View.New("block/create")
	//add fields to the form
	forms, _ := form.GetForms(c.DB)
	formID := 0
	for idx := range forms {
		if c.Param("id") == strconv.FormatUint(uint64(forms[idx].ID), 10) {
			formID = idx
			forms[idx].StatusID = 1
			forms[idx].Fields, _ = form.GetFields(c.DB)
			forms[idx].FieldTypes, _ = form.GetFieldTypes(c.DB)
		} else {
			forms[idx].StatusID = 0
		}
	}
	v.Vars["forms"] = forms
	for fld := range forms[formID].Fields {
		v.Vars[forms[formID].Fields[fld].Name] = ""
	}
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

	_, err := block.Create(c.DB, r.FormValue("name"), c.UserID)
	if err != nil {
		c.FlashErrorGeneric(err)
		Create(w, r)
		return
	}

	c.FlashSuccess("Item added.")
	c.Redirect(uri)
}

// Show displays a single item.
func Show(w http.ResponseWriter, r *http.Request) {
	c := flight.Context(w, r)

	// Create a pagination instance with a max of 10 results.
	p := pagination.New(r, 10)

	item, _, err := block.ByID(c.DB, c.Param("id"), c.UserID)
	if err != nil {
		c.FlashErrorGeneric(err)
		c.Redirect(uri)
		return
	}

	items, _, err := block.ByUserIDPaginate(c.DB, c.UserID, p.PerPage, p.Offset)
	if err != nil {
		c.FlashErrorGeneric(err)
		items = []block.Item{}
	}

	lots, _, err := lot.ByBlockIDPaginate(c.DB, c.Param("id"), p.PerPage, p.Offset)
	if err != nil {
		c.FlashErrorGeneric(err)
		lots = []lot.Item{}
	}

	v := c.View.New("block/show")
	v.Vars["item"] = item
	//add fields to the form
	forms, _ := form.GetForms(c.DB)
	formID := 0
	for idx := range forms {
		if c.Param("id") == strconv.FormatUint(uint64(forms[idx].ID), 10) {
			formID = idx
			forms[idx].StatusID = 1
			forms[idx].Fields, _ = form.GetFields(c.DB)
			forms[idx].FieldTypes, _ = form.GetFieldTypes(c.DB)
		} else {
			forms[idx].StatusID = 0
		}
	}
	v.Vars["forms"] = forms
	for fld := range forms[formID].Fields {
		v.Vars[forms[formID].Fields[fld].Name] = ""
	}

	v.Vars["items"] = items
	v.Vars["pagination"] = p
	v.Vars["lots"] = lots
	v.Render(w, r)

}

// Edit displays the edit form.
func Edit(w http.ResponseWriter, r *http.Request) {
	c := flight.Context(w, r)

	item, _, err := block.ByID(c.DB, c.Param("id"), c.UserID)
	if err != nil {
		c.FlashErrorGeneric(err)
		c.Redirect(uri)
		return
	}

	v := c.View.New("block/edit")
	//add fields to the form
	forms, _ := form.GetForms(c.DB)
	formID := 0
	for idx := range forms {
		if c.Param("id") == strconv.FormatUint(uint64(forms[idx].ID), 10) {
			formID = idx
			forms[idx].StatusID = 1
			forms[idx].Fields, _ = form.GetFields(c.DB)
			forms[idx].FieldTypes, _ = form.GetFieldTypes(c.DB)
		} else {
			forms[idx].StatusID = 0
		}
	}
	v.Vars["forms"] = forms
	for fld := range forms[formID].Fields {
		v.Vars[forms[formID].Fields[fld].Name] = ""
	}
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

	_, err := block.Update(c.DB, r.FormValue("name"), c.Param("id"), c.UserID)
	if err != nil {
		c.FlashErrorGeneric(err)
		Edit(w, r)
		return
	}

	c.FlashSuccess("Item updated.")
	c.Redirect(uri)
}

// Destroy handles the delete form submission.
func Destroy(w http.ResponseWriter, r *http.Request) {
	c := flight.Context(w, r)

	_, err := block.DeleteSoft(c.DB, c.Param("id"), c.UserID)
	if err != nil {
		c.FlashErrorGeneric(err)
	} else {
		c.FlashNotice("Item deleted.")
	}

	c.Redirect(uri)
}
