// Package home displays the Home page.
package home

import (
	"net/http"

	"github.com/gonavi2017/blueprint/controller/dashboard"
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
	dashboards, p := dashboard.Get(w, r)
	v.Vars["dashboards"] = dashboards
	v.Vars["pagination"] = p
	v.Render(w, r)
}
