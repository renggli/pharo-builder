#!/bin/bash
#
# build-oneclick.sh -- Builds Pharo based One-Click images
#
# Copyright (c) 2010 Yanni Chiu <yanni@rogers.com>
# Copyright (c) 2010 Lukas Renggli <renggli@gmail.com>
#

# directory configuration
BUILD_PATH="${WORKSPACE:=$(readlink -f $(dirname $0))/builds}"

IMAGES_PATH="$(readlink -f $(dirname $0))/images"
TEMPLATE_PATH="$(readlink -f $(dirname $0))/oneclick"

# help function
function display_help() {
	echo "$(basename $0) -i input -o output -t title -v version"
	echo " -i input product name, image from images-directory, or successful hudson build"
	echo " -o output product name"
	echo " -t the title of the application"
	echo " -v the version of the application"
}

# parse options
while getopts ":i:o:t:v:?" OPT ; do
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
		;;

		# output
		o)	OUTPUT_NAME="$OPTARG"
			OUTPUT_PATH="$BUILD_PATH/$OUTPUT_NAME.app"
			OUTPUT_ARCH="$BUILD_PATH/$OUTPUT_NAME.zip"
		;;

		# settings
		t) TITLE="$OPTARG" ;;
		v) VERSION="$OPTARG" ;;

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

if [ -z "$TITLE" ] ; then
	echo "$(basename $0): title is missing"
	exit 1
fi

if [ -z "$VERSION" ] ; then
	echo "$(basename $0): version is missing"
	exit 1
fi

# prepare output path
if [ -d "$OUTPUT_PATH" ] ; then
	rm -rf "$OUTPUT_PATH"
fi

# copy over the template
cp -R "$TEMPLATE_PATH" "$OUTPUT_PATH"

# prepare the expansion
EXPANSION="sed -e 's/%{NAME}/${OUTPUT_NAME}/g' -e 's/%{TITLE}/${TITLE}/g' -e 's/%{VERSION}/${VERSION}/g'"

# expand all the templates
for TEMPLATE_FILE in `find "$OUTPUT_PATH" -name "*.template"` ; do
	sed \
		-e "s/%{NAME}/${OUTPUT_NAME}/g" \
		-e "s/%{TITLE}/${TITLE}/g" \
		-e "s/%{VERSION}/${VERSION}/g" \
		"${TEMPLATE_FILE}" > "${TEMPLATE_FILE%.*}"
	chmod --reference="${TEMPLATE_FILE}" "${TEMPLATE_FILE%.*}"
	rm -f "${TEMPLATE_FILE}"
done

# expand all the filenames
for TEMPLATE_FILE in `find "$OUTPUT_PATH"` ; do
	TRANSFORMED_FILE=`echo "$TEMPLATE_FILE" | sed \
        -e "s/%{NAME}/${OUTPUT_NAME}/g" \
        -e "s/%{TITLE}/${TITLE}/g" \
        -e "s/%{VERSION}/${VERSION}/g"`
	if [ "$TEMPLATE_FILE" != "$TRANSFORMED_FILE" ] ; then
		mv "$TEMPLATE_FILE" "$TRANSFORMED_FILE"
	fi
done

# copy over the images
cp "$INPUT_IMAGE" "$OUTPUT_PATH/$OUTPUT_NAME.image"
cp "$INPUT_CHANGES" "$OUTPUT_PATH/$OUTPUT_NAME.changes"

# zip up the application
cd "$BUILD_PATH"
zip --quiet --recurse-paths -9 "$OUTPUT_ARCH" "$OUTPUT_NAME.app"
cd - > /dev/null

# remove the build directory
rm -rf "$OUTPUT_PATH"

# success
exit 0
