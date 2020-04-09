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
    FORMAT=$(identify -format %m $1)
    X_DPI=$(identify -format %x $1)
    Y_DPI=$(identify -format %y $1)
    W=$(identify -format %w $1)
    H=$(identify -format %h $1)
    PIXEL=$(( $W * $H ))

    if [[ ! " ${FORMATS[@]} " =~ " ${FORMAT} " ]]; then
        cho "::error:: $1: format $FORMAT, required $INPUT_FORMATS." 
        export RESULT=1
    fi
    if [ $X_DPI != ${INPUT_DPI} ]; then
        cho "::error:: $1: x dpi $X_DPI, required $INPUT_DPI." 
        export RESULT=1
    fi
    if [ $Y_DPI != ${INPUT_DPI} ]; then
        cho "::error:: $1: y dpi $Y_DPI, required $INPUT_DPI." 
        export RESULT=1
    fi
    if [ $PIXEL != ${INPUT_PIXEL_LIMIT} ]; then
        cho "::error:: $1: pixel $PIXEL, required $INPUT_PIXEL_LIMIT." 
        export RESULT=1
    fi
} 

for f in $(find . -type f); do
    test $f
done

exit $RESULT
