all: build

install:
	cargo install cargo-server
	curl https://webinstall.dev/comrak | bash

create-body:
	touch body
	echo "</div></body></html>" >> body

create-header:
	touch header
	echo "<!DOCTYPE html><html lang='en'><head><meta charset='UTF-8'>" \
		"<title>Kyoto 京</title>" \
		"<meta name='viewport' content='width=device-width, initial-scale=1.0'/>" \
		"<link rel='stylesheet' href='style.css'>" \
		"<link rel='shortcut icon' href='/assets/images/favicon.ico' type='image/x-icon' />" \
		"</head><body><div class='container'>" >> header

cleanup:
	rm -rf ./temp-specs
	rm -f overview.html

build:
	make cleanup
	mkdir temp-specs
	cp -r ../specs/* temp-specs/
	make create-header
	make create-body
	cat header >> overview.html
	comrak temp-specs/01-overview.md -t html >> overview.html
	cat body >> overview.html
	rm -rf ./temp-specs
	rm -f header body