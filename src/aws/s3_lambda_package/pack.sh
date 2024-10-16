#!/bin/bash -x
PATH="${PATH}:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/bin"

# Always fail on errors
set -e

# If you're invoking this on its own for some reason and are wondering why it fails silently, make sure these are set
# The path of the invoking terraform module
[ -n "${TF_PATH}" ]

# The runtime we're supposed to use
[ -n "${RUNTIME}" ]

# The source files we're going to pack up
[ -n "${SOURCE_PATH}" ]

# Check to see if we can actually package this runtime
[ -f "packagers/${RUNTIME}" ] || { echo "This module is not configured to package '${RUNTIME}'" ; exit 1 ; }

# Create a temporary file for our package
PACKAGE_ZIP="$(mktemp)"

# Dump a minimum viable zip file into it
echo UEsFBgAAAAAAAAAAAAAAAAAAAAAAAA== | base64 -d > "${PACKAGE_ZIP}"

. "packagers/${RUNTIME}"

cd "${TF_PATH}"

mv "${PACKAGE_ZIP}" "package.zip"
