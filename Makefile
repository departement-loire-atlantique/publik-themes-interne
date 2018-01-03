VERSION=`git describe | sed 's/^v//; s/-/./g' `
NAME="la-publik-themes"

prefix = /usr

all: icons css

# Needed to compile form SASS publik include (called in publik.scss)
data_uris:
	cd publik-base-theme && python make_data_uris.py static/includes/

css: export LC_ALL=C.UTF-8
css: data_uris
	cd static/loireatlantique/ && sass style.scss:style.css
	rm -rf static/*/.sass-cache/

icons:

clean:
	rm -rf sdist

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
	# Create or empty a folder for custom templates
	if [ -d $(DESTDIR)$(prefix)/share/publik/themes/loireatlantique ] ; then \
		rm -Rf $(DESTDIR)$(prefix)/share/publik/themes/loireatlantique; \
	fi
	mkdir -p $(DESTDIR)$(prefix)/share/publik/themes/loireatlantique
	cp -r static templates themes.json desc.xml $(DESTDIR)$(prefix)/share/publik/themes/loireatlantique
	
	# Create a link for custom wcs templates"
	mkdir -p $(DESTDIR)$(prefix)/share/wcs/themes/
	if [ -e $(DESTDIR)$(prefix)/share/wcs/themes/loireatlantique ] ; then \
		rm $(DESTDIR)$(prefix)/share/wcs/themes/loireatlantique; \
	else \
		ln -s $(prefix)/share/publik/themes/loireatlantique $(DESTDIR)$(prefix)/share/wcs/themes/loireatlantique; \
	fi

	# Create a link for static files (js, css, images, ...) into the public base theme directory
	test -d $(DESTDIR)$(prefix)/share/publik/themes/publik-base/static
	if [ -e $(DESTDIR)$(prefix)/share/publik/themes/publik-base/static/loireatlantique ] ; then \
		rm $(DESTDIR)$(prefix)/share/publik/themes/publik-base/static/loireatlantique; \
	fi
	ln -s $(prefix)/share/publik/themes/loireatlantique/static/loireatlantique $(DESTDIR)$(prefix)/share/publik/themes/publik-base/static/loireatlantique 	

	# Create a link for custom templates into the public base theme directory
	test -d $(DESTDIR)$(prefix)/share/publik/themes/publik-base/templates/variants
	if [ -e $(DESTDIR)$(prefix)/share/publik/themes/publik-base/templates/variants/loireatlantique ] ; then \
		rm $(DESTDIR)$(prefix)/share/publik/themes/publik-base/templates/variants/loireatlantique; \
	fi
	ln -s $(prefix)/share/publik/themes/loireatlantique/templates $(DESTDIR)$(prefix)/share/publik/themes/publik-base/templates/variants/loireatlantique 

	@echo "\n------------- \n- Success ! -\n-------------"

dist-bzip2: dist
		@echo 'Error, publik base theme has not been installed'; \
	-mkdir sdist
	cd sdist && tar cfj ../sdist/$(NAME)-$(VERSION).tar.bz2 $(NAME)-$(VERSION)

version:
	@(echo $(VERSION))

name:
	@(echo $(NAME))

fullname:
	@(echo $(NAME)-$(VERSION))
