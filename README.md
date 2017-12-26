# Blue Jay - Blueprint

[![Go Report Card](https://goreportcard.com/badge/github.com/blue-jay/blueprint)](https://goreportcard.com/report/github.com/blue-jay/blueprint)
[![GoDoc](https://godoc.org/github.com/blue-jay/blueprint?status.svg)](https://godoc.org/github.com/blue-jay/blueprint)

Blueprint for your next web application in Go.

Documentation available here: https://blue-jay.github.io/

Blue Jay is a web toolkit for [Go](https://golang.org/). It's a collection of
command-line tools and a web blueprint that allows you to easily structure
your web application. There is no rigid framework to which you have to
conform.

There are a few components:

- [**Blueprint**](https://github.com/blue-jay/blueprint) is a
model-view-controller (MVC) style web skeleton.

- [**Jay**](https://github.com/blue-jay/jay) is a command-line tool with
modules for find/replace, database migrations, code generation, and env.json.

- [**Core**](https://github.com/blue-jay/core) is a collection of packages
available to Blueprint and Jay as well as other applications.

Check the [milestones](https://github.com/blue-jay/blueprint/milestones) for
project status.

Notes:
Functionality:
    1- Entry
        a. Parameters(1- Green: the purpose solved, 2- Yellow: it was hard, but purpose still solved and will avoid in future, 3- Red: purpose did not solve)
        b. End users(*, the user has to be registered with the system)
        Lots: 60 words
        c. Action: ok, cancel
    2-Search
        a. Parameters(1 - , 2 - , 3- )
        b. List
        c. Action: Assign Block OR Use it
    3-Register
        a. End User
    4-Business development
        a. Advertisement

IT:
    1- Development
        a. coding
            - Client
            - Server
        b. Logo design 
        c. UI design
        d. DB design
        e. App and DB hosting
        f. check scalability
    2- legal registration and advise (liability)
    3- domain name registration
    4- website hosting
    5- patent checks
    6- debugging (go get github.com/derekparker/delve/cmd/dlv & xcode-select --install)
    
    
Mappings:
"Available on GitHub" : "Copyright"
"Blueprint": "Block"
"Home": "Description"


Team: KS,NS

Main Screen Design
0) name - text
1) Category - text
2) Rating -  R,Y,G
3) Lot - text


https://bootsnipp.com/forms
type ElementType int
const (
    Legend = ElementType(iota)
    ButtonDouble
    Button
    FileButton
    SelectMultiple
    SelectBasic
    MultipleCheckboxesInLine
    MultipleCheckboxes
    MultipleRadiosInLine 
    MultipleRadios 
    TextArea
    PrependedCheckbox
    ButtonDropDown
    PasswordInput
    SearchInput
    TextInput
)

<form class="form-horizontal">
    <fieldset>
    
    <!-- Form Name -->
    {{if eq .Type Legend}}
        <legend> {{.Name}} </legend>
    {{end}}
    
    <!-- Button (Double) -->
    {{if eq .Type ButtonDouble}}
        <div class="form-group">
        <label class="col-md-4 control-label" >{{.Label}}</label>
        <div class="col-md-8">
        {{range $n := .Paceholders}}
            <button id="{{.Paceholder}}" class="btn btn-success">{{.Paceholder}}</button>
        {{end}}
        </div>
    {{end}}
    
    <!-- Button -->
    {{if eq .Type Button}}
        <label class="col-md-4 control-label" >{{.Label}}</label>
        <div class="col-md-4">
        {{range $n := .Paceholders}}
            <button id="{{.PaceholderID}}" class="btn btn-success">{{.PaceholderValue}}</button>
        {{end}}
        </div>
    {{end}}
    
    <!-- File Button --> 
    {{if eq .Type FileButton}}
        <label class="col-md-4 control-label" >{{.Label}}</label>
        <div class="col-md-4">
        <input id="{{.Name}}"  class="input-file" type="file">
        </div>
    {{end}}
    
    <!-- Select Multiple -->
    {{if eq .Type SelectMultiple}}
        <label class="col-md-4 control-label" >{{.Label}}</label>
        <div class="col-md-4">
        <select id="{{.Name}}" class="form-control" multiple="multiple">
        {{range $n := .Paceholders}}
            <option value="{{.PaceholderID}}">{{.PaceholderValue}}</option>
        {{end}}
        </select>
        </div>
    {{end}}
    
    <!-- Select Basic -->
    {{if eq .Type SelectBasic}}
        <label class="col-md-4 control-label" >{{.Label}}</label>
        <div class="col-md-4">
        <select id="{{Name}}"  class="form-control">
        {{range $n := .Paceholders}}
            <option value="{{.PaceholderID}}">{{.PaceholderValue}}</option>
        {{end}}
        </select>
        </div>
    {{end}}
    
    <!-- Multiple Checkboxes (inline) -->
    {{if eq .Type MultipleCheckboxesInLine}}
        <label class="col-md-4 control-label" >{{.Label}}</label>
        <div class="col-md-4">
        {{range $n := .Paceholders}}
                <label class="checkbox-inline">
                <input type="checkbox"  id="{{.PaceholderID}}" value="{{.PaceholderValue}}">
                {{.PaceholderValue}}
                </label>
        {{end}}
        </div>
    {{end}}
    
    <!-- Multiple Checkboxes -->
    {{if eq .Type MultipleCheckboxes}}
        <label class="col-md-4 control-label" >{{.Label}}</label>
        <div class="col-md-4">
            {{range $n := .Paceholders}}
                <div class="checkbox">
                <label for="checkboxes-0">
                    <input type="checkbox"  id="{{.PaceholderID}}" value="{{.PaceholderValue}}">
                    {{.PaceholderID}}
                </label>
                </div>
            {{end}}
        </div>
    {{end}}
    
    <!-- Multiple Radios (inline) -->
    {{if eq .Type MultipleRadiosInLine}}
        <label class="col-md-4 control-label" >{{.Label}}</label>
        <div class="col-md-4"> 
        {{range $n := .Paceholders}}
            <label class="radio-inline" for="radios-0">
                <input type="radio"  id="{{.PaceholderID}}" value="{{.PaceholderValue}}">
                {{.PaceholderID}}
            </label> 
        {{end}}
        </div>
    {{end}}
    
    <!-- Multiple Radios -->
    {{if eq .Type MultipleRadios}}
        <label class="col-md-4 control-label" >{{.Label}}</label>
        <div class="col-md-4">
        {{range $n := .Paceholders}}
            <div class="radio">
                <label for="radios-0">
                <input type="radio"  id="{{.PaceholderID}}" value="{{.PaceholderValue}}">
                {{.PaceholderValue}}
                </label>
            </div>
        {{end}}
    {{end}}
    
    <!-- Textarea -->
    {{if eq .Type TextArea}}
        <label class="col-md-4 control-label" >{{.Label}}</label>
        <div class="col-md-4">      
        {{range $n := .Paceholders}}               
            <textarea class="form-control" id="{{.Name}}">{{.PaceholderID}}</textarea>
        {{end}}
        </div>
    {{end}}

    <!-- Prepended checkbox -->
    {{if eq .Type PrependedCheckbox}}
        <label class="col-md-4 control-label" >{{.Label}}</label>
        <div class="col-md-4">
        {{range $n := .Paceholders}}   
            <div class="input-group">
            <span class="input-group-addon">     
                <input type="checkbox">     
            </span>
                <input id="{{.Name}}"  class="form-control" type="text">
            </div>
            <p class="help-block">{{.PaceholderID}}</p>
            {{end}}
            </div>
    {{end}}
    
    <!-- Button Drop Down -->
    {{if eq .Type ButtonDropDown}}
        <label class="col-md-4 control-label" >{{.Label}}</label>
        <div class="col-md-4">
        <div class="input-group">
            <input id="{{.Name}}"  class="form-control" placeholder="placeholder" type="text">
            <div class="input-group-btn">
            <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
                Action
                <span class="caret"></span>
            </button>
            {{range $n := .Paceholders}}   
            <ul class="dropdown-menu pull-right">
                <li><a href="#">{{.PaceholderID}}</a></li>
                <li><a href="#">{{.PaceholderID}}</a></li>
                <li><a href="#">{{.PaceholderID}}</a></li>
            </ul>
            {{end}}
            </div>
        </div>
        </div>
    {{end}}
    
   
    <!-- Password input-->
    {{if eq .Type PasswordInput}}
        <label class="col-md-4 control-label" >{{.Label}}</label>
        <div class="col-md-4">
        {{range $n := .Paceholders}}   
            <input id="{{.Name}}"  type="password" placeholder="placeholder" class="form-control input-md">
            <span class="help-block">{{.PaceholderID}}</span>
        {{end}}
        </div>
    {{end}}
    
    <!-- Search input-->
    {{if eq .Type SearchInput}}
        <label class="col-md-4 control-label" >{{.Label}}</label>
        <div class="col-md-4">
        {{range $n := .Paceholders}}   
            <input id="{{.Name}}"  type="search" placeholder="placeholder" class="form-control input-md">
            <p class="help-block">{{.PaceholderID}}</p>
        {{end}}
        </div>
    {{end}}
    
    <!-- Text input-->
    {{if eq .Type TextInput}}
        <label class="col-md-4 control-label" >{{.Label}}</label>  
        <div class="col-md-4">
        {{range $n := .Paceholders}}   
            <input id="{{.Name}}" type="text" placeholder="{{.PaceholderID}}" class="form-control input-md" required="">
            <span class="help-block">{{.PaceholderValue}}</span>  
        {{end}}
        </div>
    {{end}}

    </fieldset>
    </form>
    