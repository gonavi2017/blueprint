package recaptcha

import (
	"fmt"
	"github.com/gonavi2017/blueprint/lib/recaptcha"
	"log"
	"net/http"
)

func ExampleRecaptcha_Verify() {
	sitekey := "{Your site key here}"
	re := recaptcha.recaptchaResponse{
		Secret: "{Your secret here}",
	}

	form := fmt.Sprintf(`
		<html>
			<head>
				<script src='https://www.google.com/recaptcha/api.js'></script>
			</head>
			<body>
				<form action="/submit" method="post">
					<div class="g-recaptcha" data-sitekey="%s"></div>
					<input type="submit">
				</form>
			</body>
		</html>
	`, sitekey)

	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		fmt.Fprintf(w, form)
	})
	http.HandleFunc("/submit", func(w http.ResponseWriter, r *http.Request) {
		isValid, err := re.Verify(*r)
		if isValid {
			fmt.Fprintf(w, "True")
		} else {
			fmt.Fprintf(w, "False!: %v", err)
		}
	})

	err := http.ListenAndServe(":8100", nil)

	if err != nil {
		log.Printf("Could not start server. %s", err)
	}
}
