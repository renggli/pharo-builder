#!/bin/bash
#
# build -- Builds Pharo images using a series of Smalltalk scripts and an image name
#
# Copyright (c) 2010 Lukas Renggli <renggli@gmail.com>
#

# vm configuration
PHARO_VM="/usr/local/lib/squeak/3.11.3-2135/squeakvm"
PHARO_PARAM="-nodisplay -nosound"

# directory configuration
BUILD_PATH="${WORKSPACE:=`readlink -f builds`}"
SCRIPT_PATH="/home/apache/hudson.lukas-renggli.ch/scripts"
IMAGES_PATH="/home/apache/hudson.lukas-renggli.ch/images"

# build configuration
SCRIPTS=()

# help function
function display_help() {
	echo "$0 -i input -o output {-s script} "
	echo " -i input product name, local image path, or image from cache"
	echo " -o output product name"
	echo " -s one or more scripts to be used to build the image"
}

# parse options
while getopts ":i:o:s:?" OPT ; do
	case "$OPT" in

		# input
    	i)	if [ -f "$BUILD_DIR/$OPTARG/$OPTARG.image" ] ; then
				INPUT_IMAGE="$BUILD_DIR/$OPTARG/$OPTARG.image"
			elif [ -f "$OPTARG" ] ; then
				INPUT_IMAGE=`readlink -f "$OPTARG"`
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
		;;

		# script
		s)	if [ -f "$OPTARG" ] ; then
				SCRIPTS=("${SCRIPTS[@]}" `readlink -f "$OPTARG"`)
			elif [ -f "$SCRIPT_PATH/$OPTARG" ] ; then
                SCRIPTS=("${SCRIPTS[@]}" "$SCRIPT_PATH/$OPTARG")
			elif [ -f "$SCRIPT_PATH/$OPTARG.st" ] ; then
                SCRIPTS=("${SCRIPTS[@]}" "$SCRIPT_PATH/$OPTARG.st")
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

# prepare image file
cp "$INPUT_IMAGE" "$OUTPUT_IMAGE"
cp "$INPUT_CHANGES" "$OUTPUT_CHANGES"

# prepare script file
for FILE in $SCRIPTS ; do
	cat "$FILE" >> "$OUTPUT_SCRIPT"
	echo "!" >> "$OUTPUT_SCRIPT"
done
echo '"Snapshot Image and Quit"' >> "$OUTPUT_SCRIPT"
echo 'SmalltalkImage current snapshot: true andQuit: true.' >> "$OUTPUT_SCRIPT"
echo '!' >> "$OUTPUT_SCRIPT"

# build image
"$PHARO_VM" $PHARO_PARAM "$OUTPUT_IMAGE" "$OUTPUT_SCRIPT"
rm -rf "$OUTPUT_PATH/package-cache"

# done
exit 0
