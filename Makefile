DOCKER ?= podman

all: clean html

.PHONY: deps-npm
deps-npm:
	npm install bootstrap
	make -C debian-pandoc

.PHONY: deps-docker
deps-docker:
	make -C debian-pandoc

.PHONY: deps
deps: deps-npm deps-docker

.PHONY: unqiue
unique:
	openssl rand -hex 8

.PHONY: clean-deps
clean-deps:
	rm -rf node_modules \
		package.json \
		package-lock.json
 
.PHONY: clean
clean:
	rm -f html/css/*.css \
		html/css/*.css.map \
		html/*/*.html \
		html/*/*.pdf
	rm -rf .sass-cache/

.PHONY: css
css:
	mkdir -p html/css
	sass scss/custom.scss html/css/custom.css

.PHONY: html
html: css
	$(DOCKER) run -it -v $$PWD:/build debian-pandoc \
		-f markdown+hard_line_breaks \
		/build/md/resume.md \
		-o /build/templ/content.html
	cat templ/header.html >html/index.html
	cat templ/content.html >>html/index.html
	cat templ/footer.html >>html/index.html
	prettier --write html/index.html

.PHONY: publish
publish: html
	rsync -av html/ docs/
