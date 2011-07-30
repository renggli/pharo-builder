#!/bin/bash
#
# build.sh -- Builds Pharo images using a series of Smalltalk
#   scripts. Best to be used together with Jenkins.
#
# Copyright (c) 2010 Yanni Chiu <yanni@rogers.com>
# Copyright (c) 2010-2011 Lukas Renggli <renggli@gmail.com>
#

# directory configuration
BASE_PATH="$(cd "$(dirname "$0")" && pwd)"
BUILD_PATH="${WORKSPACE:=$BASE_PATH/builds}"

IMAGES_PATH="$BASE_PATH/images"
SCRIPTS_PATH="$BASE_PATH/scripts"
SOURCES_PATH="$BASE_PATH/sources"
VM_PATH="$BASE_PATH/oneclick/Contents"
BUILD_CACHE="$BASE_PATH/cache"

# vm configuration
case "$(uname -s)" in
	"Linux")
		if [ -f "$(which cog)" ] ; then
			PHARO_VM="$(which cog)"
		elif [ -f "$(which squeak)" ] ; then
			PHARO_VM="$(which squeak)"
		else
			PHARO_VM="$VM_PATH/Linux/squeak"
		fi
		PHARO_PARAM="-nodisplay -nosound"
		;;
	"Darwin")
		PHARO_VM="$VM_PATH/MacOS/Squeak VM Opt"
		PHARO_PARAM="-headless"
		;;
	"Cygwin")
		PHARO_VM="$VM_PATH/Windows/Squeak.exe"
		PHARO_PARAM="-headless"
		;;
	*)
		echo "$(basename $0): unknown platform $(uname -s)"
		exit 1
		;;
esac

# build configuration
SCRIPTS=("$SCRIPTS_PATH/before.st")

# help function
function display_help() {
	echo "$(basename $0) -i input -o output {-s script} "
	echo " -i input product name, image from images-directory, or successful jenkins build"
	echo " -o output product name"
	echo " -s one or more scripts from the scripts-directory to build the image"
}

# parse options
while getopts ":i:o:s:?" OPT ; do
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
			OUTPUT_PATH="$BUILD_PATH/$OUTPUT_NAME"
			OUTPUT_ZIP="$BUILD_PATH/$OUTPUT_NAME.zip"
			OUTPUT_SCRIPT="$OUTPUT_PATH/$OUTPUT_NAME.st"
			OUTPUT_IMAGE="$OUTPUT_PATH/$OUTPUT_NAME.image"
			OUTPUT_CHANGES="$OUTPUT_PATH/$OUTPUT_NAME.changes"
			OUTPUT_CACHE="$OUTPUT_PATH/package-cache"
			OUTPUT_DEBUG="$OUTPUT_PATH/PharoDebug.log"
			OUTPUT_DUMP="$OUTPUT_PATH/crash.dmp"
		;;

		# script
		s)	if [ -f "$SCRIPTS_PATH/$OPTARG.st" ] ; then
                SCRIPTS=("${SCRIPTS[@]}" "$SCRIPTS_PATH/$OPTARG.st")
			else
				echo "$(basename $0): invalid script ($OPTARG)"
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
	echo "$(basename $0): no input product name given"
	exit 1
fi

if [ -z "$OUTPUT_IMAGE" ] ; then
	echo "$(basename $0): no output product name given"
	exit 1
fi

# prepare output path
if [ -d "$OUTPUT_PATH" ] ; then
	rm -rf "$OUTPUT_PATH"
fi
mkdir -p "$OUTPUT_PATH"
mkdir -p "$BUILD_CACHE/${JOB_NAME:=$OUTPUT_NAME}"
ln -s "$BUILD_CACHE/${JOB_NAME:=$OUTPUT_NAME}" "$OUTPUT_CACHE"

# prepare image file and sources
cp "$INPUT_IMAGE" "$OUTPUT_IMAGE"
cp "$INPUT_CHANGES" "$OUTPUT_CHANGES"
find "$SOURCES_PATH" -name "*.sources" -exec ln "{}" "$OUTPUT_PATH/" \;

# prepare script file
SCRIPTS=("${SCRIPTS[@]}" "$SCRIPTS_PATH/after.st")

for FILE in "${SCRIPTS[@]}" ; do
	cat "$FILE" >> "$OUTPUT_SCRIPT"
	echo "!" >> "$OUTPUT_SCRIPT"
done

# build image in the background
exec "$PHARO_VM" $PHARO_PARAM "$OUTPUT_IMAGE" "$OUTPUT_SCRIPT" &

# wait for the process to terminate, or a debug log
if [ $! ] ; then
	while kill -0 $! 2> /dev/null ; do
		if [ -f "$OUTPUT_DUMP" ] || [ -f "$OUTPUT_DEBUG" ] ; then
			sleep 5
			kill -s SIGKILL $! 2> /dev/null
			if [ -f "$OUTPUT_DUMP" ] ; then
				echo "$(basename $0): VM aborted ($PHARO_VM)"
				cat "$OUTPUT_DUMP" | tr '\r' '\n' | sed 's/^/  /'
			elif [ -f "$OUTPUT_DEBUG" ] ; then
				echo "$(basename $0): Execution aborted ($PHARO_VM)"
				cat "$OUTPUT_DEBUG" | tr '\r' '\n' | sed 's/^/  /'
			fi
			exit 1
		fi
		sleep 1
	done
else
	echo "$(basename $0): unable to start VM ($PHARO_VM)"
	exit 1
fi

# remove cache link
rm -rf "$OUTPUT_CACHE" "$OUTPUT_ZIP"
(
	cd "$OUTPUT_PATH"
	rm -f *.sources
)

# archive changes and image
(
	cd "$OUTPUT_PATH"
	zip -qj "$OUTPUT_ZIP" "$OUTPUT_IMAGE" "$OUTPUT_CHANGES"
	[ -d "files" ] && zip -qr "$OUTPUT_ZIP" "files"
)

# success
exit 0
