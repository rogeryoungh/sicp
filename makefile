# Makefile for compiling sicp.epub from the sources.
# (c) 2014 Andres Raba, GNU GPL v.3.

# Constants

DIR = html/
SRC = sicp-pocket.texi          # book's Texinfo source
GOAL = ../sicp.epub             # the end product of compilation
NEXUS = $(DIR)index.html       # the central file with table of contents
META = content.opf toc.html    # epub metafiles generated from NEXUS
HTML = $(DIR)*.html            # all the HTML files of the book
FIG = $(DIR)fig/*/*.svg         # SVG diagrams
CSS = $(DIR)css/*.css           # style files
FONT = $(DIR)css/fonts/*        # WOFF fonts
JS = $(DIR)js/*.js              # javascript libraries
CONV = texi2any lib/Texinfo/Convert/HTML.pm     # Texinfo converter scripts
HIGHL = $(DIR)js/highlight/
PRETTY = $(HIGHL)prettify.js $(HIGHL)lang-lisp.js batch-prettify.js
COVER = index.in.html $(DIR)fig/coverpage.std.svg $(DIR)fig/bookwheel.jpg
THUMB = $(DIR)fig/cover.png     # thumbnail cover image
SHELL = /bin/bash

GITHUB = <a href=\"https://github.com/sarabander/sicp\"><img style=\"position: absolute; top: 0; right: 0; border: 0; width: 149px; height: 149px; z-index: 10; opacity: 0.5;\" src=\"http://aral.github.com/fork-me-on-github-retina-ribbons/right-red\@2x.png\" alt=\"Fork me on GitHub\" /></a>

# Targets

html: $(NEXUS)

exercises.texi figures.texi: ex-fig-ref.pl
	@./ex-fig-ref.pl -e > exercises.texi; \
	 ./ex-fig-ref.pl -f > figures.texi

$(NEXUS): $(SRC) $(CONV) exercises.texi figures.texi
	@echo "Converting Texinfo file to HTML"; \
	./texi2any --no-warn --html --split=section --no-headers --iftex $(SRC)
	@# Remove temporary files.
	@grep -lZ 'This file redirects' $(HTML) | xargs -0 rm -f --
	@echo "done."

	@# Fix broken link
	@perl -0p -i -e \
	  's{\.\./dir/index\.html}{../index.html}g' $(NEXUS)

clean:
	cd html && rm *.html