CURRENT=`pwd`
DIR_NAME=`basename "$CURRENT"`
if [ $DIR_NAME == 'tools' ]
then
  cd ..
fi

rm -rf lib/fonts/icappsIcons.ttf
npx fantasticon icons --output ./lib/fonts -t ttf --name icappsIcons -g ts
rm -rf lib/fonts/icappsIcons.ts
cd lib/fonts
ttx icappsIcons.ttf
cd ../..
dart run icon_parser/lib/icon_parser.dart
rm -rf lib/fonts/icappsIcons.ttx