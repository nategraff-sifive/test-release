#!/bin/bash

set -euo pipefail

if [ "$#" -lt 2 ] ; then
  >&2 echo "$0: please provide project name and release tag"
  exit 1
fi

project=$1; shift 1;
current_release=$1; shift 1;

last_release=$(git describe --tags HEAD~)

echo "# Release notes for ${project} ${current_release}"

echo "## Statistics since ${last_release}"
echo "- $(git rev-list --count ${last_release}..HEAD) commits"
echo "- $(git diff --shortstat ${last_release} HEAD)"

echo ""
echo "## Authors"
git shortlog -s -n --no-merges ${last_release}..HEAD | cut -f 2

echo ""
echo "## Merge history"
git log --merges --pretty=format:"%h %b" ${last_release}..HEAD

