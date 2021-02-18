#!/usr/bin/env bash

#pandoc --standalone -f markdown-implicit_figures --template _templates/essay.html _markdown/2019-07-29-future-data-engineering.md -o essays/future-data-engineering.html
ESSAYS_YAML=_build/essays.yaml
echo "essay:" > $ESSAYS_YAML

for ESSAY_MD in $(ls -r _essays); do
  # Trim XXXX-XX-XX date and .md from filename
  ESSAY=$( echo "$ESSAY_MD" | cut -c 12- | rev | cut -c 4- | rev )
  ESSAY_HTML="$ESSAY.html"
  TITLE=$( sed -n '/title:/p' _essays/$ESSAY_MD  | head -n 1 | cut -c 8- )
  DATE=$( sed -n '/date:/p' _essays/$ESSAY_MD | head -n 1 | cut -c 7- )
  # That gnarly sed is to remove markdown links. Yeah.
  DESCRIPTION=$( sed -n '6 p' _essays/$ESSAY_MD | sed "s|\[\([^]]*\)\](\([^)]*\))|\1|g" | tr -d '"' | cut -c-200)

  echo "  - title: $TITLE" >> $ESSAYS_YAML
  echo "    date: $DATE" >> $ESSAYS_YAML
  echo "    dir: $ESSAY" >> $ESSAYS_YAML

  pandoc --standalone -f markdown-implicit_figures --template _templates/essay.html -Mdescription="$DESCRIPTION" _essays/$ESSAY_MD -o essays/$ESSAY_HTML
done

# Render essays index page
pandoc -f markdown-implicit_figures --template _templates/essays.html -Mtitle=Essays --metadata-file=_build/essays.yaml -o essays/index.html < /dev/null

# Render index page
pandoc -f markdown-implicit_figures --template _templates/index.html index.md -o index.html

# Render 404
pandoc -f markdown-implicit_figures --template _templates/404.html 404.md -o 404.html