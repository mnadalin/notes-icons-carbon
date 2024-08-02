
# Notes Carbon design icons

Based on the [Notes 64x64 icons: IBM Carbon design + HCL backgrounds](https://github.com/nashcom/notes-dbicons-carbon), the goal here is to batch convert all the **icons** (not pictograms) to be used in outlines, actionbars, forms, etc.

## Requirements

[ImageMagick](https://imagemagick.org)

## Batch convert icons

First clone this repository to have access to the script.  
Then also clone the carbon design system, which will be the source for the icon SVG files:

```bash
cd /tmp
git clone https://github.com/mnadalin/notes-carbon-icons.git
git clone https://github.com/carbon-design-system/carbon.git
```

If you only need the `icons` directory you can use [Download GitHub Directory](https://download-directory.github.io/) providing the folder URL [https://github.com/carbon-design-system/carbon/tree/main/packages/icons/src/svg/32](`https://github.com/carbon-design-system/carbon/tree/main/packages/icons/src/svg/32`)

### Define source and target directories

`CARBON_ICONS_SVG` defines the source directory of the carbon design SVC graphics  
`IMAGE_DIR` defines the target directory to create the symbol files in different colors

The following exports are the default behavior. If you cloned the repositories to the default locations, those variables are already set inside the scripts as a default.

```bash
export CARBON_ICONS_SVG=/tmp/carbon-design-system/carbon/tree/main/packages/icons/src/svg/32
export IMAGE_DIR=/tmp/carbon-png
```

### Define sizes and colors

Edit the bottom lines of the script to define size in pixel and color in hex format **without** the leading `#`, like:

```bash
convert_all_images 0066B3 32
```

To convert all SVGs to 32x32 PNG files filled with the Notes primary <strong style="color:#0066B3">blue</strong> color.

### Convert images

```bash
./convert_images.sh
```

The script will output the PNG files in the following directory structure:

```
/tmp/carbon-png
├── 0066B3
│   └── 32
├── 313131
│   └── 24
├── F7F7F7
│   └── 24
│   └── 48
```
