CURRENT=`pwd`
DIR_NAME=`basename "$CURRENT"`
if [ $DIR_NAME == 'tool' ]
then
  cd ..
fi

echo "--- Reorienting icons... ---"
npx reorient icons/*.svg

echo "--- Removing old previews... ---"
rm -rf ./previews/*

echo "--- Creating new previews... ---"
magick mogrify -background none -format png -resize 32x32 -path ./previews icons/*.svg

echo "--- Removing old font... ---"
rm -rf lib/fonts/icappsIcons.ttf

echo "--- Creating new font... ---"
npx fantasticon icons --output ./lib/fonts -t ttf --name icappsIcons -g ts
rm -rf lib/fonts/icappsIcons.ts
cd lib/fonts

echo "--- Generating icappsIcons.dart... ---"
ttx icappsIcons.ttf
cd ../..
dart run icon_parser/lib/icon_parser.dart

echo "--- Cleanup ... ---"
rm -rf lib/fonts/icappsIcons.ttx