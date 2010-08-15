#!/bin/bash
#
# build-resize.sh -- Resize the image file
#
# Copyright (c) 2010 Lukas Renggli <renggli@gmail.com>
#

# directories
TOOLS_PATH="$(readlink -f $(dirname $0))/tools"

# make the executable if not present
if [ ! -f "$TOOLS_PATH/build-resize" ] ; then
  make --directory="$TOOLS_PATH" all
fi

# pass on to exectuable
"$TOOLS_PATH/build-resize" "$@"
