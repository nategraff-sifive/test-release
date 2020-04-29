#!/usr/bin/env bash

set -euo pipefail

if [ "$#" -lt 1 ] ; then
  >&2 echo "Please provide a tag"
  exit 1
fi

tag=$1; shift 1;

submodules=(test-release-submodule )

for submodule in ${submodules[@]} ; do
  git -C ${submodule} tag ${tag}
  git -C ${submodule} push --tags
done
