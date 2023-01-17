#!/bin/bash
# Move generated files as a preparation step for upload
#
# Moving will only be done if not the default branch (currently changes_for_v1.1) which is uploaded to the main directory

# The -e flag causes the script to exit as soon as one command returns a non-zero exit code
set -e

echo "Checking whether to move generated files for GITHUB_REF_NAME=${GITHUB_REF_NAME} GITHUB_HEAD_REF=${GITHUB_HEAD_REF} ..."

if [[ "${GITHUB_REF_NAME}" == 'changes_for_v1.1' ]]; then
  echo -e '\033[0;32mMoving files not necessary.\033[0m'
elif [[ "${GITHUB_REF_NAME}" != '' && "${GITHUB_HEAD_REF}" == '' ]]; then
  # This is a branch push
  mkdir ./docs/generated/"${GITHUB_REF_NAME}"
  mv ./docs/generated/index.html ./docs/generated/"${GITHUB_REF_NAME}"/
  mv ./docs/generated/asciidoc.css ./docs/generated/"${GITHUB_REF_NAME}"/
  echo -e '\033[0;32mMoving files succeeded.\033[0m'
fi
