#!/bin/bash

# Builds index.html from presentation.md using pandoc + reveal.js.
#
# --slide-level=2
#   Controls which heading level creates a new slide. With level 2, top-level
#   headings (#) create horizontal slides and second-level headings (##) create
#   vertical slides that you navigate to by pressing the down arrow.
#
# --include-after-body footer.html
#   Appends footer.html just before </body> in the generated HTML. Used to
#   inject a script that adds Cmd+= / Cmd+- / Cmd+0 keyboard shortcuts for
#   adjusting font size at presentation time without rebuilding.
#
# sed -i '' 's/data-src=/src=/g'
#   Pandoc emits images with data-src instead of src so that reveal.js can
#   lazy-load them as slides come into view. Lazy loading requires the file
#   to be served over HTTP — opening index.html directly as a local file
#   (file://) means the images never load. This replaces data-src with src
#   so the browser loads images immediately regardless of how the file is opened.

pandoc presentation.md -t revealjs -s -o index.html --css style.css --include-after-body footer.html -V theme=white --syntax-highlighting=tango --slide-level=2
sed -i '' 's/data-src=/src=/g' index.html
