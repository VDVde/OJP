#!/bin/bash
# Script to check the OJP XML Schemas on adherence to design and documentation conventions
#
# You need the binary `xsltproc` to runs the checks
# apt-get install xsltproc

# The -e flag causes the script to exit as soon as one command returns a non-zero exit code
set -e

echo "Checking OJP XML Schemas..."

base_dir="$(dirname "${0}")/.."
xsl_dir=$base_dir/docs

# Run the checks in the checker stylesheet
saved_output=$(xsltproc --xinclude "${xsl_dir}"/check-ojp-schemas.xsl "${xsl_dir}"/schema-collection.xml 2>&1)
EXITCODE=$?
# echo $EXITCODE
echo -e "$saved_output"
errors=$(echo "$saved_output" | awk '/ERROR/')
if [ -n "$errors" ]
then
  echo -e '\033[1;31mXML schema conventions: FAILED\033[0m'
  exit 1
else
  echo -e '\033[0;32mXML schema conventions: PASSED\033[0m'
fi

# end of file
