#!/bin/bash
# Script to generate the documentation tables as .html from the .xsd schema files
#
# You need the binary `xsltproc` to convert from xsd to asciidoc and `asciidoctor` to convert from asciidoc to html
# apt-get install xsltproc asciidoctor

base_dir="$(dirname "${0}")/.."
xsd_dir=$base_dir
xsl_dir=$base_dir/docs
generated_dir="${base_dir}/docs/generated"

create_asciidoc() {
  # xsl-transform of xsd file
  xsltproc --stringparam sectiontitle "$3" "${xsl_dir}"/ixsi-to-adoc-table.xsl "${xsd_dir}"/"$1" > "${generated_dir}"/"$2"
}

# prepare asciidoc_dir
mkdir -p "${generated_dir}"
rm -f "${generated_dir}/*.adoc"

# create asciidoc files
create_asciidoc OJP.xsd OJP.adoc "OJP"
create_asciidoc OJP/OJP_Places.xsd places.adoc "Places"
create_asciidoc OJP/OJP_Trips.xsd trips.adoc "Trips"

# convert asciidoc to html5
asciidoctor "${generated_dir}/*.adoc"

# end of file
