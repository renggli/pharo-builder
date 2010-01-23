#!/bin/bash
#
# build.sh -- Builds Pharo images using a series of Smalltalk
#   scripts. Best to used together with Hudson.
#
# Copyright (c) 2010 Yanni Chiu <yanni@rogers.com>
# Copyright (c) 2010 Lukas Renggli <renggli@gmail.com>
#

# vm configuration
PHARO_VM="/usr/local/lib/squeak/3.11.3-2135/squeakvm"
PHARO_PARAM="-nodisplay -nosound"

# directory configuration
BUILD_PATH="${WORKSPACE:=$(readlink -f $(dirname $0))/builds}"

IMAGES_PATH="$(readlink -f $(dirname $0))/images"
SCRIPTS_PATH="$(readlink -f $(dirname $0))/scripts"
BUILD_CACHE="$(readlink -f $(dirname $0))/cache"

# build configuration
SCRIPTS=("$SCRIPTS_PATH/before.st")

# help function
function display_help() {
	echo "$0 -i input -o output {-s script} "
	echo " -i input product name, or image from images-directory"
	echo " -o output product name"
	echo " -s one or more scripts from the scripts-directory to build the image"
}

# parse options
while getopts ":i:o:s:?" OPT ; do
	case "$OPT" in

		# input
    	i)	if [ -f "$BUILD_PATH/$OPTARG/$OPTARG.image" ] ; then
				INPUT_IMAGE="$BUILD_PATH/$OPTARG/$OPTARG.image"
			elif [ -f "$IMAGES_PATH/$OPTARG.image" ] ; then
				INPUT_IMAGE="$IMAGES_PATH/$OPTARG.image"
			else
				echo "$0: input image not found ($OPTARG)"
				exit 1
			fi

			INPUT_CHANGES="${INPUT_IMAGE%.*}.changes"
			if [ ! -f "$INPUT_CHANGES" ] ; then
				echo "$0: input changes not found ($INPUT_CHANGES)"
				exit 1
			fi
		;;

		# output
		o)	OUTPUT_NAME="$OPTARG"
			OUTPUT_PATH="$BUILD_PATH/$OUTPUT_NAME"
			OUTPUT_SCRIPT="$OUTPUT_PATH/$OUTPUT_NAME.st"
			OUTPUT_IMAGE="$OUTPUT_PATH/$OUTPUT_NAME.image"
			OUTPUT_CHANGES="$OUTPUT_PATH/$OUTPUT_NAME.changes"
			OUTPUT_CACHE="$OUTPUT_PATH/package-cache"
		;;

		# script
		s)	if [ -f "$SCRIPTS_PATH/$OPTARG.st" ] ; then
                SCRIPTS=("${SCRIPTS[@]}" "$SCRIPTS_PATH/$OPTARG.st")
			else
				echo "$0: invalid script ($OPTARG)"
				exit 1
			fi
		;;

		# show help
		\?)	display_help
			exit 1
		;;

	esac
done

# check required parameters
if [ -z "$INPUT_IMAGE" ] ; then
	echo "$0: no input product name given"
	exit 1
fi

if [ -z "$OUTPUT_IMAGE" ] ; then
	echo "$0: no output product name given"
	exit 1
fi

# prepare output path
if [ -d "$OUTPUT_PATH" ] ; then
	rm -rf "$OUTPUT_PATH"
fi
mkdir -p "$OUTPUT_PATH"
mkdir -p "$BUILD_CACHE/$OUTPUT_NAME"
ln -s "$BUILD_CACHE/$OUTPUT_NAME" "$OUTPUT_CACHE"

# prepare image file
cp "$INPUT_IMAGE" "$OUTPUT_IMAGE"
cp "$INPUT_CHANGES" "$OUTPUT_CHANGES"

# prepare script file
SCRIPTS=("${SCRIPTS[@]}" "$SCRIPTS_PATH/after.st")

for FILE in "${SCRIPTS[@]}" ; do
	cat "$FILE" >> "$OUTPUT_SCRIPT"
	echo "!" >> "$OUTPUT_SCRIPT"
done

# build image
"$PHARO_VM" $PHARO_PARAM "$OUTPUT_IMAGE" "$OUTPUT_SCRIPT"

# clear cache
rm -f "$OUTPUT_CACHE"

# done
exit 0
