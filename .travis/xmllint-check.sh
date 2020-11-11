#!/bin/bash
# The -e flag causes the script to exit as soon as one command returns a non-zero exit code
set -e

echo "Formatting XSD and XML files"

PARSING_ERROR=0
while IFS= read -r -d $'\0' filename; do
  if XMLLINT_INDENT=$'\t' xmllint --encode UTF-8 --pretty 1 "${filename}" >"${filename}.pretty"; then
    grep -i -v "xmlspy" "${filename}.pretty" >"${filename}"
  else
    PARSING_ERROR=$?
    echo -e "\033[0;31mParsing of file '${filename}' failed\033[0m"
  fi
  rm "${filename}.pretty"
done < <(/usr/bin/find . -type f \( -name "*.xsd" -or -name "*.xml" \) -print0)

if [ ${PARSING_ERROR} -ne 0 ]; then
  exit ${PARSING_ERROR}
fi
echo -e '\033[0;32mFinished formatting XSD and XML files\033[0m'

# xmllint --noout --schema OJP.xsd examples/subdirectory1/*xml examples/subdirectory2/*xml
