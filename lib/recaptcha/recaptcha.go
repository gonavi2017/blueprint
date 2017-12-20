// Package recaptcha is google golang module for google re-captcha.
//
// Installation
//
//   go get github.com/haisum/recaptcha
//
// Usage
//
// Usage example can be found in example/main.go file.
//
//
// Source code
//
// Available on github: http://github.com/haisum/recaptcha
//
// Author: Haisum (haisumbhatti@gmail.com)
package recaptcha

import (
	"encoding/json"
	"io/ioutil"
	"net/http"
	"net/url"
	"time"
)

// Recaptcha type represents an object of Recaptcha and has public property Secret,
// which is secret obtained from google recaptcha tool admin interface
type Recaptcha struct {
	Secret    string
	lastError []string
}

// Struct for parsing json in google's response
type recaptchaResponse struct {
	Success    bool
	ErrorCodes []string `json:"error-codes"`
}

// Verify method, verifies if current request have valid re-captcha response and returns true or false
// This method also records any errors in validation.
// These errors can be received by calling LastError() method.
func (r *Recaptcha) Verify(req http.Request) (bool, []string) {
	var postURL = "https://www.google.com/recaptcha/api/siteverify"
	response := req.FormValue("g-recaptcha-response")
	r.lastError = make([]string, 1)
	client := &http.Client{Timeout: 20 * time.Second}
	resp, err := client.PostForm(postURL,
		url.Values{"secret": {r.Secret}, "response": {response}})
	if err != nil {
		r.lastError = append(r.lastError, err.Error())
		return false, r.lastError
	}
	defer resp.Body.Close()
	body, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		r.lastError = append(r.lastError, err.Error())
		return false, r.lastError
	}
	gr := new(recaptchaResponse)
	err = json.Unmarshal(body, gr)
	if err != nil {
		r.lastError = append(r.lastError, err.Error())
		return false, r.lastError
	}
	if !gr.Success {
		r.lastError = append(r.lastError, gr.ErrorCodes...)
	}
	return gr.Success, r.lastError

}
