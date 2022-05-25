#!/bin/bash
# Script to generate the documentation tables as .html from the .xsd schema files
#
# You need the binary `xsltproc` to generate html documentation from XML Schemas.
# apt-get install xsltproc

# The -e flag causes the script to exit as soon as one command returns a non-zero exit code
set -e

echo "Generating documentation tables"

base_dir="$(dirname "${0}")/.."
xsd_dir=$base_dir
xsl_dir=$base_dir/docs
generated_dir="${base_dir}/docs/generated"

# prepare generated_dir
mkdir -p "${generated_dir}"
rm -f "${generated_dir}"/OJP-prep.xml "${generated_dir}"/*.adoc "${generated_dir}"/*.html
cp "${xsl_dir}"/asciidoc.css "${generated_dir}"/

# create intermediate XML file for documentation
xsltproc --xinclude "${xsl_dir}"/ojp-to-prepdoc.xsl \
 "${xsl_dir}"/schema-collection.xml \
 >> "${generated_dir}"/OJP-prep.xml

# generate stand-alone HTML file for documentation
xsltproc --xinclude "${xsl_dir}"/ojp-prep-to-html-with-toc.xsl \
 "${generated_dir}"/OJP-prep.xml \
 >> "${generated_dir}"/OJP.html

# end of file
