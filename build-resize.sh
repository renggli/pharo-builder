#!/bin/bash
#
# build-resize.sh -- Resize the image file
#
# Copyright (c) 2010 Lukas Renggli <renggli@gmail.com>
#

# directory configuration
BUILD_PATH="${WORKSPACE:=$(readlink -f $(dirname $0))/builds}"
TOOLS_PATH="$(readlink -f $(dirname $0))/tools"

# input image
if [ -f "$BUILD_PATH/$1/$1.image" ] ; then
	INPUT_IMAGE="$BUILD_PATH/$1/$1.image"
elif [ -f "$BUILD_PATH/$1.image" ] ; then
	INPUT_IMAGE="$BUILD_PATH/$1.image"
fi

# make the executable if not present
if [ ! -f "$TOOLS_PATH/build-resize" ] ; then
  make --directory="$TOOLS_PATH" all
fi

# pass on to exectuable
"$TOOLS_PATH/build-resize" "$INPUT_IMAGE" "$2" "$3"
