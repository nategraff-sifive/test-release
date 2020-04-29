#!/bin/bash

set -euo pipefail

if [ "$#" -lt 3 ] ; then
  >&2 echo "$0: please provide project name and release tag"
  exit 1
fi

project=$1; shift 1;
current_release=$1; shift 1;
output_file=$1; shift 1

last_release=$(git describe --tags HEAD~)

echo "# Release notes for ${project} ${current_release}" | tee ${output_file}

echo "## Statistics since ${last_release}" | tee ${output_file}
echo "- $(git rev-list --count ${last_release}..HEAD) commits" | tee ${output_file}
echo "- $(git diff --shortstat ${last_release} HEAD)" | tee ${output_file}

echo "" | tee ${output_file}
echo "## Authors" | tee ${output_file}
git shortlog -s -n --no-merges ${last_release}..HEAD | cut -f 2 | tee ${output_file}

echo "" | tee ${output_file}
echo "## Merge history" | tee ${output_file}
git log --merges --pretty=format:"%h %b" ${last_release}..HEAD | tee ${output_file}

