#!/bin/bash
#
# build-oneclick.sh -- Builds Pharo based One-Click images
#
# Copyright (c) 2010-2011 Lukas Renggli <renggli@gmail.com>
#

# directory configuration
BASE_PATH="$(cd "$(dirname "$0")" && pwd)"
BUILD_PATH="${WORKSPACE:=$BASE_PATH/builds}"

IMAGES_PATH="$BASE_PATH/images"
TEMPLATE_PATH="$BASE_PATH/oneclick"
ICONS_PATH="$BASE_PATH/oneclick-icons"

# help function
function display_help() {
	echo "$(basename $0) -i input -o output [-n name] [-t title] [-v version] [-c icon] [-w timestamp]"
	echo " -i input product name, image from images-directory, or successful jenkins build"
	echo " -o output product name (e.g. pharo1.0)"
	echo " -n the name of the executable (e.g. pharo)"
	echo " -t the title of the application (e.g. Pharo)"
	echo " -v the version of the application (e.g. 1.0)"
	echo " -c the icon of the application (e.g. Pharo)"
	echo " -w a timestamp string (e.g. `date +'%B %d, %Y'`)"
}

# parse options
while getopts ":i:o:n:t:v:c:w:?" OPT ; do
	case "$OPT" in

		# input
		i)	if [ -f "$BUILD_PATH/$OPTARG/$OPTARG.image" ] ; then
				INPUT_IMAGE="$BUILD_PATH/$OPTARG/$OPTARG.image"
			elif [ -f "$BUILD_PATH/$OPTARG.image" ] ; then
				INPUT_IMAGE="$BUILD_PATH/$OPTARG.image"
			elif [ -f "$IMAGES_PATH/$OPTARG/$OPTARG.image" ] ; then
				INPUT_IMAGE="$IMAGES_PATH/$OPTARG/$OPTARG.image"
			elif [ -f "$IMAGES_PATH/$OPTARG.image" ] ; then
				INPUT_IMAGE="$IMAGES_PATH/$OPTARG.image"
			elif [ -n "$WORKSPACE" ] ; then
				INPUT_IMAGE=`find -L "$WORKSPACE/../.." -name "$OPTARG.image" | grep "/lastSuccessful/" | head -n 1`
			fi

			if [ ! -f "$INPUT_IMAGE" ] ; then
				echo "$(basename $0): input image not found ($OPTARG)"
				exit 1
			fi

			INPUT_CHANGES="${INPUT_IMAGE%.*}.changes"
			if [ ! -f "$INPUT_CHANGES" ] ; then
				echo "$(basename $0): input changes not found ($INPUT_CHANGES)"
				exit 1
			fi

			INPUT_PATH=`dirname "$INPUT_IMAGE"`
			if [ ! -d "$INPUT_PATH" ] ; then
				echo "$(basename $0): input directory not found ($INPUT_PATH)"
				exit 1
			fi

		;;

		# output
		o) OUTPUT_NAME="$OPTARG" ;;

		# settings
		n) OPTION_NAME="$OPTARG" ;;
		t) OPTION_TITLE="$OPTARG" ;;
		v) OPTION_VERSION="$OPTARG" ;;
		c) OPTION_ICON="$OPTARG" ;;
		w) OPTION_WHEN="$OPTARG" ;;

		# show help
		\?)	display_help
			exit 1
		;;

	esac
done

# check required parameters
if [ -z "$INPUT_IMAGE" ] ; then
	echo "$(basename $0): no input product name given"
	exit 1
fi

if [ -z "$OUTPUT_NAME" ] ; then
	echo "$(basename $0): no output product name given"
	exit 1
fi

# check the default paramaters
if [ -z "$OPTION_NAME" ] ; then
	OPTION_NAME="$OUTPUT_NAME"
fi

if [ -z "$OPTION_TITLE" ] ; then
	OPTION_TITLE="$OUTPUT_NAME"
fi

if [ -z "$OPTION_VERSION" ] ; then
	OPTION_VERSION="1.0"
fi

if [ -z "$OPTION_ICON" ] ; then
	OPTION_ICON="Pharo"
fi

if [ -z "$OPTION_WHEN" ] ; then
	OPTION_WHEN=`date +"%B %d, %Y"`
fi

# prepare output
OUTPUT_PATH="$BUILD_PATH/$OPTION_NAME.app"
OUTPUT_ARCH="$BUILD_PATH/$OUTPUT_NAME.zip"

if [ -f "$OUTPUT_ARCH" ] ; then
	rm -rf "$OUTPUT_ARCH"
fi

if [ -d "$OUTPUT_PATH" ] ; then
	rm -rf "$OUTPUT_PATH"
fi

# copy over the template
cp -R "$TEMPLATE_PATH" "$OUTPUT_PATH"

# expand all the templates
find "$OUTPUT_PATH" -name "*.template" | while read FILE ; do
	sed \
		-e "s/%{NAME}/$OPTION_NAME/g" \
		-e "s/%{TITLE}/$OPTION_TITLE/g" \
		-e "s/%{VERSION}/$OPTION_VERSION/g" \
		-e "s/%{WHEN}/$OPTION_WHEN/g" \
			"$FILE" > "${FILE%.*}"
	chmod --reference="$FILE" "${FILE%.*}"
	rm -f "$FILE"
done

# expand all the filenames
find "$OUTPUT_PATH" | while read FILE ; do
	TRANSFORMED_FILE=`echo "$FILE" | sed \
		-e "s/%{NAME}/$OPTION_NAME/g" \
		-e "s/%{TITLE}/$OPTION_TITLE/g" \
		-e "s/%{VERSION}/$OPTION_VERSION/g" \
		-e "s/%{WHEN}/$OPTION_WHEN/g"`
	if [ "$FILE" != "$TRANSFORMED_FILE" ] ; then
		mv "$FILE" "$TRANSFORMED_FILE"
	fi
done

# copy over the build contents
ls -1 "$INPUT_PATH" | while read FILE ; do
	if [ "${FILE##*.}" != "image" ] ; then
		if [ "${FILE##*.}" != "changes" ] ; then
			cp -R "$INPUT_PATH/$FILE" "$OUTPUT_PATH/Contents/Resources/"
		fi
	fi
done

# copy over specific files
cp "$INPUT_IMAGE" "$OUTPUT_PATH/Contents/Resources/$OPTION_NAME.image"
cp "$INPUT_CHANGES" "$OUTPUT_PATH/Contents/Resources/$OPTION_NAME.changes"
cp "$ICONS_PATH/$OPTION_ICON.png" "$OUTPUT_PATH/Contents/Resources/Squeak.png"
cp "$ICONS_PATH/$OPTION_ICON.ico" "$OUTPUT_PATH/Contents/Resources/Squeak.ico"
cp "$ICONS_PATH/$OPTION_ICON.icns" "$OUTPUT_PATH/Contents/Resources/Squeak.icns"

# zip up the application
cd "$BUILD_PATH"
zip --quiet --recurse-paths -9 "$OUTPUT_ARCH" "$OPTION_NAME.app"
cd - > /dev/null

# remove the build directory
rm -rf "$OUTPUT_PATH"

# success
exit 0
