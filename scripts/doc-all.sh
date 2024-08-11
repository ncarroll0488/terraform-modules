#!/usr/bin/env bash
set -e

# This feels clumsy...
REPOPATH="$(realpath "$(dirname "$(realpath "${0}")")/../")"

# CD into the repo. We don't rely on .git existing to determine this, because not all use-cases include it
cd "${REPOPATH}"

# Scan the entire 'src' directory for terraform files
for DIRNAME in $(find src -type f -name "*.tf" -exec dirname {} \; | sort | uniq) ; do
  cd "${DIRNAME}"

  # Don't blow away existing documents if they haven't been moved to a .md_part
  if [ -f "README.md" ] && [ ! -f "README.md_part" ] ; then
    echo "Refusing to blow out existing README in ${DIRNAME}"
    continue
  fi

  # Create the README.md_part file if it doesn't exist
  [ -f 'README.md_part' ] || touch 'README.md_part'

  # Concatenate auto-generated markdown and custom markdown into the README file
  echo "Creating documents in ${DIRNAME}"
  { terraform-docs markdown . ; cat README.md_part ; } > README.md
  cd "${REPOPATH}"
done
