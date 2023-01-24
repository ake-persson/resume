all: clean html

deps:
	npm install bootstrap

unique:
	openssl rand -hex 8

clean-deps:
	rm -rf node_modules \
		package.json \
		package-lock.json

clean:
	rm -f html/css/*.css \
		html/css/*.css.map \
		html/*/*.html \
		html/*/*.pdf
	rm -rf .sass-cache/

html: css
	docker run -it -v $$PWD:/build debian-pandoc \
		-f markdown+hard_line_breaks \
		/build/md/resume.md \
		-o /build/templ/content.html ;\
	cat templ/header.html >html/index.html ;\
	cat templ/content.html >>html/index.html ;\
	cat templ/footer.html >>html/index.html ;\
	prettier --write html/index.html
	docker run -it -v $$PWD:/build debian-pandoc \
		-f markdown+hard_line_breaks \
		/build/md/bio.md \
		-o /build/templ/content.html ;\
	cat templ/bio-header.html >html/bio.html ;\
	cat templ/content.html >>html/bio.html ;\
	cat templ/footer.html >>html/bio.html ;\
	prettier --write html/bio.html

css:
	mkdir -p html/css
	sass scss/custom.scss html/css/custom.css

publish: html
	rsync -av html/ docs/

.PHONY: deps clean build css docker-clean docker-build docker-stage
