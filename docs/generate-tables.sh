#!/bin/bash
# Generate the documentation tables as docs/generated/OJP.html from the .xsd schema files
#
# You need the binary `xsltproc`
# apt-get install xsltproc

# The -e flag causes the script to exit as soon as one command returns a non-zero exit code
set -e

echo "Generating documentation tables ..."

base_dir="$(dirname "${0}")/.."
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
 >> "${generated_dir}"/index.html

# remove intermediate XML file
rm -f "${generated_dir}"/OJP-prep.xml

echo -e '\033[0;32mFinished generating documentation tables\033[0m'
