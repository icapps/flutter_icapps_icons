

This is a helper package for turning the svg icons from the icapps iconic library into a font and generating the required dart code.

## Getting started

To get started install the required tools to run the script, these are:
- svg-reorient: https://www.npmjs.com/package/svg-reorient?activeTab=readme
- fantasticon: https://www.npmjs.com/package/fantasticon?activeTab=readme
- fonttools: https://github.com/fonttools/fonttools
- imagemagick: brew install imagemagick

## Usage

To use the tool all you have to do is make sure all your icons are in the icons folder. After that run the update_font.sh command from the root (./tool/update_font.sh). That's it, the tool will now update the font with the newly added icons.
