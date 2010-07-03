#!/bin/bash

#########################################
#
# Author: Max Leske						#
# Date: 30.04.2010						#
#										#
#########################################
#
# Purpose:
# The following opens a Squeak image and replaces bytes 24 to 27.
# These bytes encode integers (little endian) that represent the initial window size.
#
############
#
# Window size: 1032x1920
# big endian hex: 0408 0780
# little endian hex: 0804 8007
#
############
echo -e \\x08\\x04\\x80\\x07 | dd of="$1" obs=1 seek=24 conv=block,notrunc cbs=4
