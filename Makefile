VERSION := $(shell git describe --tags --abbrev=0)
NAME := la-publik-themes

prefix = /usr

all: css

# Needed to compile form SASS publik include (called in publik.scss)
data_uris:
	cd publik-base-theme && python make_data_uris.py static/includes/

css: export LC_ALL=C.UTF-8
css: data_uris
	cd static/loireatlantique/ && sass style.scss:style.css
	rm -rf static/*/.sass-cache/

clean:
	rm -rf sdist
	rm -f static/*/_data_uris.scss

DIST_FILES = \
	Makefile \
	desc.xml \
	static templates themes.json \

dist: clean
	-mkdir sdist
	rm -rf sdist/$(NAME)-$(VERSION)
	mkdir -p sdist/$(NAME)-$(VERSION)
	for i in $(DIST_FILES); do \
		cp -R "$$i" sdist/$(NAME)-$(VERSION); \
	done

install:
	# Create a link for static files (js, css, images, ...) into the public base theme directory
	test -d $(DESTDIR)$(prefix)/share/publik/themes/publik-base/static
	ln -sf $(CURDIR)/sdist/$(NAME)-$(VERSION)/static/loireatlantique $(DESTDIR)$(prefix)/share/publik/themes/publik-base/static/loireatlantique 	

	# Create a link for custom templates into the public base theme directory
	test -d $(DESTDIR)$(prefix)/share/publik/themes/publik-base/templates/variants
	ln -sf $(CURDIR)/sdist/$(NAME)-$(VERSION)/templates $(DESTDIR)$(prefix)/share/publik/themes/publik-base/templates/variants/loireatlantique 

	# Link themes.json
	test -d $(DESTDIR)$(prefix)/share/publik/themes/publik-base/themes.json ; \
        rm $(DESTDIR)$(prefix)/share/publik/themes/publik-base/themes.json ; \
        ln -s $(CURDIR)/sdist/$(NAME)-$(VERSION)/themes.json $(DESTDIR)$(prefix)/share/publik/themes/publik-base/themes.json	

version:
	@(echo $(VERSION))

name:
	@(echo $(NAME))

fullname:
	@(echo $(NAME)-$(VERSION))
