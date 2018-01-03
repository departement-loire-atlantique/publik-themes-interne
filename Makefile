VERSION=`git describe | sed 's/^v//; s/-/./g' `
NAME="la-publik-themes"

prefix = /usr

all: icons css

css: export LC_ALL=C.UTF-8
css:
	cd static/loireatlantique/ && sass style.scss:style.css
	rm -rf static/*/.sass-cache/

icons:

clean:
	rm -rf sdist

DIST_FILES = \
	Makefile \
	desc.xml \
	static templates themes.json \
	src

dist: clean
	-mkdir sdist
	rm -rf sdist/$(NAME)-$(VERSION)
	mkdir -p sdist/$(NAME)-$(VERSION)
	for i in $(DIST_FILES); do \
		cp -R "$$i" sdist/$(NAME)-$(VERSION); \
	done

install:
	mkdir -p $(DESTDIR)$(prefix)/share/publik/themes/loireatlantique
	cp -r static templates themes.json desc.xml $(DESTDIR)$(prefix)/share/publik/themes/loireatlantique
	mkdir -p $(DESTDIR)$(prefix)/share/wcs/themes/
	ln -s $(prefix)/share/publik/themes/loireatlantique $(DESTDIR)$(prefix)/share/wcs/themes/loireatlantique

dist-bzip2: dist
	-mkdir sdist
	cd sdist && tar cfj ../sdist/$(NAME)-$(VERSION).tar.bz2 $(NAME)-$(VERSION)

version:
	@(echo $(VERSION))

name:
	@(echo $(NAME))

fullname:
	@(echo $(NAME)-$(VERSION))
