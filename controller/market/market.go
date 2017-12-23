// Package about displays the About page.
package market

import (
	"net/http"

	"github.com/gonavi2017/blueprint/lib/flight"

	"github.com/gonavi2017/core/router"
)

// Load the routes.
func Load() {
	router.Get("/market", Index)
}

// Index displays the Market page.
func Index(w http.ResponseWriter, r *http.Request) {
	c := flight.Context(w, r)

	c.View.New("market/index").Render(w, r)
}
