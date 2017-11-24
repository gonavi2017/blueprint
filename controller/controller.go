// Package controller loads the routes for each of the controllers.
package controller

import (
	"github.com/gonavi2017/blueprint/controller/about"
	"github.com/gonavi2017/blueprint/controller/debug"
	"github.com/gonavi2017/blueprint/controller/home"
	"github.com/gonavi2017/blueprint/controller/login"
	"github.com/gonavi2017/blueprint/controller/point"
	"github.com/gonavi2017/blueprint/controller/register"
	"github.com/gonavi2017/blueprint/controller/static"
	"github.com/gonavi2017/blueprint/controller/status"
)

// LoadRoutes loads the routes for each of the controllers.
func LoadRoutes() {
	about.Load()
	debug.Load()
	register.Load()
	login.Load()
	home.Load()
	static.Load()
	status.Load()
	point.Load()
}
