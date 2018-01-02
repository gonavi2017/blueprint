// Package home displays the Home page.
package home

import (
	"net/http"
	"strconv"

	"github.com/gonavi2017/blueprint/controller/form"
	"github.com/gonavi2017/blueprint/lib/flight"

	"github.com/gonavi2017/core/router"
)

// Load the routes.
func Load() {
	router.Get("/", Index)
}

// Index displays the home page.
func Index(w http.ResponseWriter, r *http.Request) {
	c := flight.Context(w, r)

	v := c.View.New("home/index")
	if c.Sess.Values["id"] != nil {
		v.Vars["first_name"] = c.Sess.Values["first_name"]
	}
	forms, p := form.GetForms(w, r)

	formID := 0
	for idx := range forms {
		if c.Param("id") == strconv.FormatUint(uint64(forms[idx].ID), 10) {
			formID = idx
			forms[idx].StatusID = 1
			forms[idx].Fields = form.GetFields(w, r)
			forms[idx].FieldTypes = form.GetFieldTypes(w, r)
		} else {
			forms[idx].StatusID = 0
		}
	}
	v.Vars["forms"] = forms
	//add fields to the form
	for fld := range forms[formID].Fields {
		v.Vars[forms[formID].Fields[fld].Name] = ""
	}
	v.Vars["pagination"] = p
	v.Render(w, r)
}
