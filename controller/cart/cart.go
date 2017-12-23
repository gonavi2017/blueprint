// Package about displays the About page.
package cart

import (
	"net/http"

	"github.com/gonavi2017/blueprint/lib/flight"

	"github.com/gonavi2017/core/router"
)

// Load the routes.
func Load() {
	router.Get("/cart", Index)
}

// Index displays the About page.
func Index(w http.ResponseWriter, r *http.Request) {
	c := flight.Context(w, r)

	c.View.New("cart/index").Render(w, r)
}
