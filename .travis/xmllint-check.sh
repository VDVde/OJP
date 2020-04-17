#!/bin/bash
/usr/bin/find . -type f \( -name "*.xsd" -or -name "*.xml" \) -print0 | while read -r -d $'\0' filename; do XMLLINT_INDENT=$'\t' xmllint --encode UTF-8 --pretty 1 "${filename}" > "${filename}.pretty"; mv "${filename}.pretty" "${filename}"; grep -i -v "xmlspy" "${filename}" > "${filename}.tmp" && mv "${filename}.tmp" "${filename}"; done;
echo "finished formatting"
# xmllint --noout --schema OJP.xsd examples/subdirectory1/*xml examples/subdirectory2/*xml
