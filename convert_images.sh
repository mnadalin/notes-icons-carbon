#!/bin/bash

if [ -z "$CARBON_ICONS_SVG" ]; then
  CARBON_ICONS_SVG=/tmp/carbon-design-system/carbon/tree/main/packages/icons/src/svg/32
fi

if [ -z "$IMAGE_DIR" ]; then
  IMAGE_DIR=/tmp/carbon-png
fi

convert_image()
{
  local FILE=$(basename "$1" .svg)
  local TARGET_DIR=$IMAGE_DIR/$COLOR/$SIZE
  local TARGET_FILE=$TARGET_DIR/$FILE.png

  echo "Converting $FILE to ${TARGET_FILE}..."

  if [ ! -e "$TARGET_DIR" ]; then
    mkdir -p "$TARGET_DIR"
  fi
 
  if [ -e "$TARGET_FILE" ]; then
    return 0
  fi

  sed "s/viewBox/fill=\"#$COLOR\" viewBox/g" $1 | convert -background transparent -size ${SIZE}x${SIZE} - "$TARGET_FILE" &

}

export -f convert_image

convert_all_images()
{
  export COLOR=$1
  export SIZE=$2

  find "$CARBON_ICONS_SVG" -name "*.svg" -exec bash -c 'convert_image $0' {} \;
}

export IMAGE_DIR
export CARBON_ICONS_SVG

convert_all_images F7F7F7 24
convert_all_images F7F7F7 48
convert_all_images 313131 48
convert_all_images 0066B3 32
