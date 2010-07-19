#!/bin/bash
#
# build-oneclick.sh -- Builds One-Click Images
#
# Copyright (c) 2010 Yanni Chiu <yanni@rogers.com>
# Copyright (c) 2010 Lukas Renggli <renggli@gmail.com>
#

# directory configuration
BUILD_PATH="${WORKSPACE:=$(readlink -f $(dirname $0))/builds}"

IMAGES_PATH="$(readlink -f $(dirname $0))/images"
SOURCES_PATH="$(readlink -f $(dirname $0))/sources"
TEMPLATE_PATH="$(readlink -f $(dirname $0))/oneclick"

# help function
function display_help() {
	echo "$(basename $0) -t title -v version -i input -o output"
	echo " -t the title of the application"
	echo " -v the version of the application"
	echo " -i the input image"
	echo " -o the output name"
}

# parse options
while getopts ":i:o:s:?" OPT ; do
	case "$OPT" in

		# settings
		t) TITLE="$OPTARG" ;;
		v) VERSION="$OPTARG" ;;

		# show help
		\?)	display_help
			exit 1
		;;

	esac
done

# input image and changes
if [ -f "$BUILD_PATH/$1/$1.image" ] ; then
	INPUT_IMAGE="$BUILD_PATH/$1/$1.image"
elif [ -f "$BUILD_PATH/$1.image" ] ; then
	INPUT_IMAGE="$BUILD_PATH/$1.image"
elif [ -f "$IMAGES_PATH/$1/$1.image" ] ; then
	INPUT_IMAGE="$IMAGES_PATH/$1/$1.image"
elif [ -f "$IMAGES_PATH/$1.image" ] ; then
	INPUT_IMAGE="$IMAGES_PATH/$1.image"
elif [ -n "$WORKSPACE" ] ; then
    INPUT_IMAGE=`find -L "$WORKSPACE/../.." -name "$1.image" | grep "/lastSuccessful/" | head -n 1`
fi

if [ ! -f "$INPUT_IMAGE" ] ; then
	echo "$(basename $0): input image not found ($1)"
    exit 1
fi

INPUT_CHANGES="${INPUT_IMAGE%.*}.changes"
if [ ! -f "$INPUT_CHANGES" ] ; then
	echo "$(basename $0): input changes not found ($INPUT_CHANGES)"
    exit 1
fi

shift

# output path and application name
OUTPUT_NAME="$1"
OUTPUT_PATH="$BUILD_PATH/$OUTPUT_NAME.app"

if [ -d "$OUTPUT_PATH" ] ; then
	rm -rf "$OUTPUT_PATH"
fi
mkdir -p "$OUTPUT_PATH"

# copy over the template
cp -R "$TEMPLATE_PATH/*" "$OUTPUT_PATH/"

# expand all the templates
for TEMPLATE_FILE in `find "$OUTPUT_PATH" -name "*.template"` ; do
	while read LINE ; do
    	while [[ "$LINE" =~ '(\$\{[a-zA-Z_][a-zA-Z_0-9]*\})' ]] ; do
        	LHS="${BASH_REMATCH[1]}"
        	RHS="$(eval echo "\"$LHS\"")"
        	LINE="${LINE//$LHS/$RHS}"
    	done
    	echo "$LINE" >> "${TEMPLATE_FILE%.*}"
	done < cat "$TEMPLATE_FILE"
	rm "$TEMPLATE_FILE"
done

# expand all the filenames
for TEMPLATE_FILE in  `find "$OUTPUT_PATH"` ; do
	if [[ "$TEMPLATE_FILE" =~ '(\$\{[a-zA-Z_][a-zA-Z_0-9]*\})' ]] ; do
		LHS="${BASH_REMATCH[1]}"
		RHS="$(eval echo "\"$LHS\"")"
		mv "$TEMPLATE_FILE" "${TEMPLATE_FILE//$LHS/$RHS}"
	fi
done

# copy over the images
cp "$INPUT_IMAGE" "$OUTPUT_PATH/$OUTPUT_NAME.image"
cp "$INPUT_CHANGES" "$OUTPUT_PATH/$OUTPUT_NAME.changes"

# zip up the application
zip -r9 "$OUTPUT_PATH.zip" "$OUTPUT_PATH"
rm -rf "$OUTPUT_PATH"

# success
exit 0
