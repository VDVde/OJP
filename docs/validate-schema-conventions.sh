#!/bin/bash
# Validate the OJP Schema on adherence to design and documentation conventions
#
# You need the binary `xsltproc`
# apt-get install xsltproc

# The -e flag causes the script to exit as soon as one command returns a non-zero exit code
set -e

echo "Validating OJP Schema conventions ..."

base_dir="$(dirname "${0}")/.."
xsl_dir=$base_dir/docs

# Run the checks in the checker stylesheet
saved_output=$(xsltproc --xinclude "${xsl_dir}"/check-ojp-schemas.xsl "${xsl_dir}"/schema-collection.xml 2>&1)
echo -e "$saved_output"
errors=$(echo "$saved_output" | awk '/ERROR/')
if [ -n "$errors" ]
then
  echo -e '\033[1;31mValidating OJP Schema conventions failed\033[0m'
  exit 1
else
  echo -e '\033[0;32mValidating OJP Schema conventions succeeded\033[0m'
fi
