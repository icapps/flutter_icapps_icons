CURRENT=`pwd`
DIR_NAME=`basename "$CURRENT"`
if [ $DIR_NAME == 'tools' ]
then
  cd ..
fi

cd lib/fonts
ttx icappsIcons.ttf
cd ../..
dart run icon_parser/lib/icon_parser.dart
rm -rf lib/fonts/icappsIcons.ttx