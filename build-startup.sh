#!/bin/bash
#
# build-startup.sh -- Cleanup workspace and link all available dependencies.
#
# Copyright (c) 2010 Lukas Renggli <renggli@gmail.com>
#

# check required parameters
if [ -z "$WORKSPACE" ] ; then
	echo "$(basename $0): \$WORKSPACE variable not defined"
	exit 1
fi

# cleanup workspace
rm -rf "$WORKSPACE/*"

# link all dependencies
find "$WORKSPACE/../.." \
	-name "lastSuccessful" \
	-exec ln -s "{}/archive/*" "$WORKSPACE"

# success
exit 0
