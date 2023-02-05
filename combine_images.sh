#!/bin/bash

if [ -z "$IMAGE_DIR" ]; then
  IMAGE_DIR=/local/dbicon/ibm/carbon-pictograms-png
fi

if [ -z "$DBICON_DIR" ]; then
  DBICON_DIR=/local/dbicon/carbon-icons-64x64
fi

combine_images()
{
  local FILE=$(basename "$1")

  if [ -e "$TARGET_DIR/${FILE}" ]; then 
    return 0
  fi

  convert "$BACKGROUND_DIR/${SHAPE}_${TYPE}/${COLOR}.png" "$1" -gravity center -composite "$TARGET_DIR/${FILE}" &
}

export -f combine_images

make_color ()
{
  export COLOR=$1
  export COLOR_LOWER=$(echo $1 | awk '{ print tolower($1) }')

  export TARGET_DIR=${DBICON_DIR}/${SHAPE}/${TYPE}/${COLOR}/${SYMBOL_COLOR}
  mkdir -p "$TARGET_DIR" 

  find "$IMAGE_DIR/$SYMBOL_COLOR/$PIXEL" -name "*.png" -exec bash -c 'combine_images $0' {} \;
}

make_colors ()
{
  make_color "blue"
  make_color "yellow"
  make_color "orange"
}

export IMAGE_DIR
export DBICON_DIR
export BACKGROUND_DIR=hcl/background

export TYPE=gradient

# Export all icons with white symbols

export SYMBOL_COLOR=white

export SHAPE=square
export PIXEL=56
make_colors

export SHAPE=circle
export PIXEL=40
make_colors

exit 0

# Black isn't a good color for the symbols. But someone might want to experiment

# Export all icons with black symbols

export SYMBOL_COLOR=black

export SHAPE=square
export PIXEL=56
make_colors

export SHAPE=circle
export PIXEL=40
make_colors

