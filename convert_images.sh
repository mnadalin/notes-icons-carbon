#!/bin/bash

if [ -z "$CARBON_PICTOGRAMS_SVG" ]; then
  CARBON_PICTOGRAMS_SVG=/local/github/carbon/packages/pictograms/src/svg
fi

if [ -z "$IMAGE_DIR" ]; then
  IMAGE_DIR=/local/dbicon/ibm/carbon-pictograms-png
fi

convert_image()
{
  local FILE=$(basename "$1" .svg)
  local TARGET_DIR=$IMAGE_DIR/$COLOR/$SIZE
  local TARGET_FILE=$TARGET_DIR/$FILE.png

  if [ ! -e "$TARGET_DIR" ]; then
    mkdir -p "$TARGET_DIR"
  fi
 
  if [ -e "$TARGET_FILE" ]; then
    return 0
  fi

  if [ "$COLOR" = "black" ]; then
    convert -background transparent -size ${SIZE}x${SIZE} "$1" "$TARGET_FILE" &
  else
    sed "s/<svg version=\"1.1\"/<svg version=\"1.1\" fill=\"$COLOR\"/g" $1 | convert -background transparent -size ${SIZE}x${SIZE} - "$TARGET_FILE" &
  fi

}

export -f convert_image

convert_all_images()
{
  export COLOR=$1
  export SIZE=$2

  find "$CARBON_PICTOGRAMS_SVG" -name "*.svg" -exec bash -c 'convert_image $0' {} \;
}

export IMAGE_DIR
export CARBON_PICTOGRAMS_SVG

convert_all_images white 56
convert_all_images white 40
convert_all_images black 56
convert_all_images black 40
