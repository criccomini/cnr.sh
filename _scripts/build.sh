#!/usr/bin/env bash

ESSAYS_YML=_yaml/essays.yml
TALKS_YML=_yaml/talks.yml
SITEMAP_YML=_yaml/sitemap.yml

echo "links:" > $ESSAYS_YML

echo "links:" > $SITEMAP_YML
echo "  - https://cnr.sh/essays/" >> $SITEMAP_YML
echo "  - https://cnr.sh/talks/" >> $SITEMAP_YML

# Render essays
for ESSAY_MD in $( ls -r _essays ); do
  # Trim XXXX-XX-XX date and .md from filename
  ESSAY=$( echo "$ESSAY_MD" | cut -c 12- | rev | cut -c 4- | rev )
  ESSAY_HTML="$ESSAY.html"
  TITLE=$( sed -n '/title:/p' _essays/$ESSAY_MD  | head -n 1 | cut -c 8- )
  DATE=$( sed -n '/date:/p' _essays/$ESSAY_MD | head -n 1 | cut -c 7- )
  # That gnarly sed is to remove markdown links. Yeah.
  DESCRIPTION=$( sed -n '6 p' _essays/$ESSAY_MD | sed "s|\[\([^]]*\)\](\([^)]*\))|\1|g" | tr -d '"' | cut -c-200)

  echo "  - title: $TITLE" >> $ESSAYS_YML
  echo "    date: $DATE" >> $ESSAYS_YML
  echo "    url: /essays/$ESSAY" >> $ESSAYS_YML

  echo "  - https://cnr.sh/essays/$ESSAY" >> $SITEMAP_YML

  pandoc --standalone -f markdown-implicit_figures --template _templates/essay.html -Mdescription="$DESCRIPTION" _essays/$ESSAY_MD -o essays/$ESSAY_HTML
done

# Render essays index page
pandoc -f markdown-implicit_figures --template _templates/links.html -Mtitle=Essays --metadata-file=$ESSAYS_YML -o essays/index.html < /dev/null

# Render talks index page
pandoc -f markdown-implicit_figures --template _templates/links.html -Mtitle=Talks --metadata-file=$TALKS_YML -o talks/index.html < /dev/null

# Render index page
pandoc -f markdown-implicit_figures --template _templates/index.html index.md -o index.html

# Render sitemap
pandoc -f markdown-implicit_figures --template _templates/sitemap.xml --metadata-file=$SITEMAP_YML -t plain -o sitemap.xml < /dev/null

# Render 404
pandoc -f markdown-implicit_figures --template _templates/404.html 404.md -o 404.html
