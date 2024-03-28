#!/bin/bash
# Generate the documentation tables in docs/generated/ from the .xsd schema files
#
# You need the binary `java`
# apt-get install default-jre

# The -e flag causes the script to exit as soon as one command returns a non-zero exit code
set -e

BASE_DIRECTORY=$(readlink -f "$(dirname "${0}")/..")
XSL_DIRECTORY="${BASE_DIRECTORY}/docs/generate_tables"
GENERATED_DIRECTORY="${BASE_DIRECTORY}/docs/generated"
BASEX_JAR="/tmp/basex.jar"

if [ ! -e ${BASEX_JAR} ]; then
	echo "Downloading BaseX ..."
	wget --output-document=${BASEX_JAR} https://files.basex.org/releases/10.6/BaseX106.jar
fi

echo "Generating documentation tables ..."

# prepare GENERATED_DIRECTORY
mkdir -p "${GENERATED_DIRECTORY}"
rm -f "${GENERATED_DIRECTORY}"/documentation-tables

cd "${XSL_DIRECTORY}"

java -cp ${BASEX_JAR} org.basex.BaseX \
 -b report=contab \
 -b dir="${BASE_DIRECTORY}" \
 -b odir="${GENERATED_DIRECTORY}" \
 -b custom=custom-ojp.xml \
 -b dnamesExcluded=".git .github" \
 xcore.xq

# Remove interim edesc files
rm -rf "${GENERATED_DIRECTORY}"/edesc

# move to speaking name
mv "${GENERATED_DIRECTORY}"/contab "${GENERATED_DIRECTORY}"/documentation-tables
mv "${GENERATED_DIRECTORY}"/documentation-tables/contab-index.html "${GENERATED_DIRECTORY}"/documentation-tables/index.html

echo -e '\033[0;32mFinished generating documentation tables\033[0m'
