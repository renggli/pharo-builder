#!/bin/bash
#
# build-teardown.sh -- Cleanup workspace after successful build.
#
# Copyright (c) 2010 Lukas Renggli <renggli@gmail.com>
#

# check for workspace
if [ -z "$WORKSPACE" ] ; then
	echo "$(basename $0): \$WORKSPACE variable not defined"
	exit 1
fi

# remove dependencies
find "$WORKSPACE" \
	-maxdepth 1 \
	-type l \
	-exec rm {} \;

# success
exit 0
