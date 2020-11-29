#!/bin/bash

basedir="$(dirname $0)/.."
xsddir=$basedir
xsldir=$basedir/docs
adocdir="$basedir/adoc/generated"

doxslt() {
  xsltproc --stringparam sectiontitle "$4" $xsldir/$1 $xsddir/$2 > $adocdir/$3
}

mkdir -p "$adocdir"
doxslt ixsi-to-adoc-table.xsl OJP.xsd main.adoc "First test"
doxslt ixsi-to-adoc-table.xsl OJP_Locations.xsd main_locations.adoc "Locations"
doxslt ixsi-to-adoc-table.xsl OJP_Trips.xsd main_trips.adoc "Trips"

# end of file
