#!/bin/bash
# Script to generate the documentation tables as .html from the .xsd schema files
#
# You need the binary `xsltproc` to convert from xsd to asciidoc and `asciidoctor` to convert from asciidoc to html
# apt-get install xsltproc asciidoctor

# The -e flag causes the script to exit as soon as one command returns a non-zero exit code
set -e

echo "Generating documentation tables"

base_dir="$(dirname "${0}")/.."
xsd_dir=$base_dir
xsl_dir=$base_dir/docs
generated_dir="${base_dir}/docs/generated"

# prepare generated_dir
mkdir -p "${generated_dir}"
rm -f "${generated_dir}"/*.adoc "${generated_dir}"/*.html

# Add asciidoc header
printf '%s\n' \
  '= OJP - **O**pen API for distributed **J**ourney **P**lanning' \
 ":toc:" \
 ":homepage: https://github.com/VDVde/OJP" \
 "// Disable last updated text." \
 ":!last-update-label:" \
 "" >> "${generated_dir}"/OJP.adoc

# create asciidoc file
xsltproc "${xsl_dir}"/ojp-to-asciidoc.xsl \
 "${xsd_dir}"/OJP.xsd \
 "${xsd_dir}"/OJP/OJP_Requests.xsd \
 "${xsd_dir}"/OJP/OJP_RequestSupport.xsd \
 "${xsd_dir}"/OJP/OJP_Places.xsd \
 "${xsd_dir}"/OJP/OJP_PlaceSupport.xsd \
 "${xsd_dir}"/OJP/OJP_StopEvents.xsd \
 "${xsd_dir}"/OJP/OJP_Trips.xsd \
 "${xsd_dir}"/OJP/OJP_JourneySupport.xsd \
 "${xsd_dir}"/OJP/OJP_SituationSupport.xsd \
 "${xsd_dir}"/OJP/OJP_TripInfo.xsd \
 "${xsd_dir}"/OJP/OJP_Fare.xsd \
 "${xsd_dir}"/OJP/OJP_FareSupport.xsd \
 "${xsd_dir}"/OJP/OJP_Common.xsd \
 "${xsd_dir}"/OJP/OJP_FacilitySupport.xsd \
 "${xsd_dir}"/OJP/OJP_ModesSupport.xsd \
 "${xsd_dir}"/OJP/OJP_Utility.xsd \
 >> "${generated_dir}"/OJP.adoc

# convert asciidoc to html5
asciidoctor "${generated_dir}/OJP.adoc"

# end of file
