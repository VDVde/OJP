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
xsltproc -xinclude "${xsl_dir}"/check-ojp-schemas.xsl \
 "${xsl_dir}"/schema-collection.xml

# end of file
