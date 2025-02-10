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
def _strip_404(md, _):
    frontmatter = md.frontmatter()
    siblings = frontmatter.get("siblings", [])
    siblings = filter(lambda s: s != "404.md", siblings)
    md.update_frontmatter({"siblings": list(siblings)})
    md.save()
# TODO remove * when transform handles single file paths
transform("site/index*.md", _strip_404)

transform("site/*/index.md", lambda md, _: md.update_frontmatter({"template": "index"}))

# Render site
render("site/**/*.md", site={"title": "cnr.sh"})

# Minify site HTML, CSS, and JS
minify("site/**/*.html")
minify("site/**/*.css")
minify("site/**/*.js")