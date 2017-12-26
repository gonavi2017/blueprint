// Package dashboard provides a simple CRUD application in a web page.
package dashboard

import (
	"net/http"
	"strconv"

	"github.com/gonavi2017/blueprint/lib/flight"
	"github.com/gonavi2017/blueprint/middleware/acl"
	"github.com/gonavi2017/blueprint/model/dashboard"
	"github.com/gonavi2017/core/pagination"
	"github.com/gonavi2017/core/router"
)

var (
	uri = "/dashboard"
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

// Get displays the items.
func Get(w http.ResponseWriter, r *http.Request) ([]dashboard.Item, *pagination.Info) {
	c := flight.Context(w, r)

	// Create a pagination instance with a max of 10 results.
	p := pagination.New(r, 10)

	dashboards, _, err := dashboard.ByDescriptionPaginate(c.DB, "These", p.PerPage, p.Offset)
	if err != nil {
		c.FlashErrorGeneric(err)
		dashboards = []dashboard.Item{}
	}

	count, err := dashboard.ByDescriptionCount(c.DB, "These")
	if err != nil {
		c.FlashErrorGeneric(err)
	}

	// Calculate the number of pages.
	p.CalculatePages(count)
	return dashboards, p
}

// Index displays the items.
func Index(w http.ResponseWriter, r *http.Request) {
	c := flight.Context(w, r)

	// Create a pagination instance with a max of 10 results.
	p := pagination.New(r, 10)

	dashboards, _, err := dashboard.ByDescriptionPaginate(c.DB, "These", p.PerPage, p.Offset)
	if err != nil {
		c.FlashErrorGeneric(err)
		dashboards = []dashboard.Item{}
	}

	count, err := dashboard.ByDescriptionCount(c.DB, "These")
	if err != nil {
		c.FlashErrorGeneric(err)
	}

	// Calculate the number of pages.
	p.CalculatePages(count)

	v := c.View.New("dashboard/index")
	v.Vars["dashboards"] = dashboards
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

	// Create a pagination instance with a max of 10 results.
	p := pagination.New(r, 10)

	dashboards, _, err := dashboard.ByDescription(c.DB, "These")
	if err != nil {
		c.FlashErrorGeneric(err)
		c.Redirect(uri)
		return
	}

	dashboards, _, err = dashboard.ByDescriptionPaginate(c.DB, "These", p.PerPage, p.Offset)
	if err != nil {
		c.FlashErrorGeneric(err)
		dashboards = []dashboard.Item{}
	}

	//decrypt
	//json
	for idx := range dashboards {
		if c.Param("id") == strconv.FormatUint(uint64(dashboards[idx].ID), 10) {
			dashboards[idx].StatusID = 1
		} else {
			dashboards[idx].StatusID = 0
		}
	}
	v := c.View.New("dashboard/index")
	v.Vars["dashboards"] = dashboards
	v.Vars["pagination"] = p
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
