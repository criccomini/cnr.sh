#!/usr/bin/env python3
from markupdown import *

# Copy files to the site directory
cp("assets/**/*.*", "site")
cp("content/**/*.md", "site")
cp("CNAME", "site")

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

# Remove "404.md" from the root's sibling frontmatter
def _hide_from_nav(md, _):
    frontmatter = md.frontmatter()
    siblings = frontmatter.get("siblings", [])
    siblings = filter(lambda s: s not in ["404.md", "colophon.md"], siblings)
    md.update_frontmatter({"siblings": list(siblings)})
    md.save()
transform("site/index.md", _hide_from_nav)

# Set custom template for index and post pages
transform("site/posts/*.md", lambda md, _: md.update_frontmatter({"template": "post"}))
transform("site/*/index.md", lambda md, _: md.update_frontmatter({"template": "index"}))

# Render site
render("site/**/*.md", site={
    "title": "cnr.sh",
    "image": "/images/shoes.png",
})

# Move 404.html to site/404.html
cp("site/404/index.html", "site/404.html")

# Minify site HTML, CSS, and JS
minify("site/**/*.html")
minify("site/**/*.css")
minify("site/**/*.js")