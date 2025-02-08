#!/usr/bin/env python3
from markupdown import *

# Copy files to the site directory
cp("assets/css/*.css", "site/css")
cp("assets/js/*.js", "site/js")
cp("assets/images/*.png", "site/images")
cp("assets/*.ico", "site")
cp("content/**/*.md", "site")
cp("assets/*.txt", "site")

# Update markdown frontmatter
title("site/**/*.md")
link("site/**/*.md")
blurb("site/**/*.md")
siblings("site/**/index.md")
children("site/**/index.md")
changelog("content/**/*.md", "site")
references("site/**/*.md")
feed(
    "site/**/*.md",
    feed_id="https://cnr.sh",
    feed_title="Chris Riccomini",
    feed_link="https://cnr.sh",
    feed_description="Chris Riccomini's blog",
)
sitemap("site/**/*.md", site_url="https://cnr.sh")

# Render site
render("site/**/*.md", site={"title": "cnr.sh"})

# Minify site HTML, CSS, and JS
minify("site/**/*.html")
minify("site/**/*.css")
minify("site/**/*.js")