#!/bin/bash
# Validate all OJP XML examples from the examples/ directory against the OJP XSD schema
#
# You need the binary `xmllint`
# apt-get install libxml2-utils

# The -e flag causes the script to exit as soon as one command returns a non-zero exit code
set -e

echo "Validating OJP XML examples ..."

if xmllint --noout --schema OJP.xsd examples/*/*.xml examples/*/*/*.xml; then
  echo -e '\033[0;32mValidating OJP XML examples succeeded\033[0m'
else
  echo -e '\033[0;31mValidating OJP XML examples failed\033[0m'
  exit 1
fi
