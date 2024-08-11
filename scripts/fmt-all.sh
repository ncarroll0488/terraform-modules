#!/usr/bin/env bash
set -e

# This feels clumsy...
REPOPATH="$(realpath "$(dirname "$(realpath "${0}")")/../")"

# CD into the repo. We don't rely on .git existing to determine this, because not all use-cases include it
cd "${REPOPATH}"

# Scan the entire 'src' directory for terraform files
for DIRNAME in $(find src -type f -name "*.tf" -exec dirname {} \; | sort | uniq) ; do
  cd "${DIRNAME}"
  echo "Checking ${DIRNAME}"
  terraform fmt .
  cd "${REPOPATH}"
done
