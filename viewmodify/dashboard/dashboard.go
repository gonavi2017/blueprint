// Package dashboard adds content to the view template.
package dashboard

import (
	"net/http"

	"github.com/gonavi2017/blueprint/lib/flight"
	"github.com/gonavi2017/core/view"
)

//Tab contains dashboard information
type Tab struct {
	ID          uint32
	Name        string
	Description string
	Active      bool
}

//Item contains dashboard information
type Item struct {
	header string
	Tabs   []Tab
	footer string
}

// Modify sets AuthLevel in the template to auth if the user is authenticated.
// Sets AuthLevel to anon if not authenticated.
func Modify(w http.ResponseWriter, r *http.Request, v *view.Info) {
	c := flight.Context(w, r)
	result := Item{}
	// Set the AuthLevel to auth if the user is logged in
	if c.Sess.Values["id"] != nil {
		result.Tabs = append(result.Tabs, Tab{0, "FUT", "This is future dashboard", true})
		result.Tabs = append(result.Tabs, Tab{1, "OPT", "This is option dashboard", false})
		result.Tabs = append(result.Tabs, Tab{2, "FX", "This is foriegn exchange dashboard", false})
		result.Tabs = append(result.Tabs, Tab{3, "FI", "This is fixed income dashboard", false})
		result.header = "MARKET"
		result.footer = "US"
		v.Vars["Dashboard"] = result
	} else {
		v.Vars["Dashboard"] = result
	}
}
