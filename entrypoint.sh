#!/bin/bash

cd "${GITHUB_WORKSPACE}" || exit
cd ${INPUT_PATH}

FORMATS=( `echo ${INPUT_FORMATS} | tr -s ',' ' '` )

echo "Requirements:"
echo "      dpi: ${INPUT_DPI}"
echo "    pixel: ${INPUT_PIXEL_LIMIT}"
echo "  formats: ${INPUT_FORMATS}"

export RESULT=0

test() {
    FORMAT=$(identify -format %m "$1")
    X_DPI_=$(identify -units PixelsPerInch -format %x "$1")
    Y_DPI_=$(identify -units PixelsPerInch -format %y "$1")
    X_DPI=$(echo "${X_DPI_}" | awk '{printf("%d",$1 + 0.5)}')
    Y_DPI=$(echo "${Y_DPI_}" | awk '{printf("%d",$1 + 0.5)}')
    W=$(identify -format %w "$1")
    H=$(identify -format %h "$1")
    PIXEL=$(( $W * $H ))

    echo "$1"

    if [[ ! " ${FORMATS[@]} " =~ " ${FORMAT} " ]]; then
        echo "::error:: $1: format $FORMAT, required $INPUT_FORMATS."
        export RESULT=1
    fi
    if [ "$X_DPI" != "${INPUT_DPI}" ]; then
        echo "::error:: $1: x dpi $X_DPI, required $INPUT_DPI."
        export RESULT=1
    fi
    if [ "$Y_DPI" != "${INPUT_DPI}" ]; then
        echo "::error:: $1: y dpi $Y_DPI, required $INPUT_DPI."
        export RESULT=1
    fi
    if [ "$PIXEL" -gt "${INPUT_PIXEL_LIMIT}" ]; then
        echo "::error:: $1: pixel $PIXEL, required $INPUT_PIXEL_LIMIT."
        export RESULT=1
    fi
}

for f in $(find . -type f); do
    test $f
done

exit $RESULT
