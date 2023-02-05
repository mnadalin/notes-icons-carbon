# domino-dbicons

## Create Notes database icons from IBM Carbon design pictorgram with HCL backgrounds

Starting with **HCL Notes 12.0.1** the desktop supports database icons with **64x64 pixel**.
Before 12.0.1 **32x32** have been already supported. This support goes back to Notes 8.5.x but many applications are still using the very old **16x16, 16 color** images.

The best format available for images would be the SVG vector format.
But Notes only supports GIF, JEPG and PNG today. If you like the idea to support SVG in the Notes Client, here is an idea on the [HCL Domino Ideas Portal](https://domino-ideas.hcltechsw.com/ideas/NTS-I-1648) to vote for.

PNG is the best of those three formats, because it supports image transparency and image layers.

The [IBM Carbon design project](https://carbondesignsystem.com/guidelines/pictograms/library/) provides over 930 modern free of charge pictograms in **SVG format**.

HCL provides a set of great looking background images with perfect fit for Notes 64x64 database icons in **PNG format**.

The idea is to combine those resources and to create a multiple sets of color and background shape combinations automatically.

One of the best tools for the jobs is [Image Magick](https://imagemagick.org)

It's in included in Linux! But available for Windows, too.
This repository leverages the Linux version with bash conversion scripts.

### Convert the symbol SVG to a transparent PNG sized 56x56 ...

With Image Magick converting an image from SVG to PNG with a defined size, is pretty simple.
The size can be adjusted using the `-size` option

```
convert -background transparent -size 56x56 symbol.svg symbol.png
```

### Combine the symbol with the background and overlay centered 

The HCL background images have the right size already.
That makes combinind those two PNG images very straightforward

```
convert blue.png symbol.png -gravity center -composite new_icon.png
```

### Replace the symbol color

The SVG graphics come in black. If you need a different color it can be quite complicated to change it using graphics tools.
But because SVG is a text based descriptive format an easy trick is to set the color directly in the source SVG via `sed` command.

Setting the color and converting the image be done both in one step.

In this example white is added to the SVG image:

```
sed "s/ d=/ fill=white d=/g" symbol.svg | convert -background transparent -size 56x56 - symbol.png
```

## Batch convert and combine icons

But converting just one image isn't what would help with 930 Carbond design pictograms

This repository provides a simple to tweak script to convert all carbon design pictograms and convert them with the HCL backgrounds.


### Clone Carbon design system from GitHub

First clone this repository to have access to the scripts.  
Then also clone the carbon design system, which will be the source for the pictogram SVG files

```
mkdir -p /local/github
cd /local/github
git clone https://github.com/nashcom/domino-dbicons.git
git clone https://github.com/carbon-design-system/carbon
```

### Define source and target directories

**CARBON_PICTOGRAMS_SVG** defines the source directory of the carbon design SVC graphics
**IMAGE_DIR** defines the target directory to create the symbol files in different colors
**DBICON_DIR** defines the target dir for the ready to use database icons

The following exports are the default behavior.
If you cloned the repositories to the default locations, those variables are already set inside the scripts as a default.


```
export CARBON_PICTOGRAMS_SVG=/local/github/carbon/packages/pictograms/src/svg
export IMAGE_DIR=/local/dbicon/ibm/carbon-pictograms-png
export DBICON_DIR=/local/dbicon/carbon-icons-64x64
```

### Convert and combine images

Now switch to the directory and run the conversion and combine scripts.

```
cd domino-dbicons
./convert_images.sh
./combine_images.sh
```

The scripts will build the symbols in black and also white.
Those images are combined with different background shapes and colors.


```
tree /local/dbicon/carbon-icons-64x64 -L 4
/local/dbicon/carbon-icons-64x64
├── circle
│   └── gradient
│       ├── blue
│       │   ├── black
│       │   └── white
│       ├── orange
│       │   ├── black
│       │   └── white
│       └── yellow
│           ├── black
│           └── white
└── square
    └── gradient
        ├── blue
        │   ├── black
        │   └── white
        ├── orange
        │   ├── black
        │   └── white
        └── yellow
            ├── black
            └── white
```

