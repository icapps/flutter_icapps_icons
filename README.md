A package that adds the ability to use all the icons of the icapps iconic library 

## Getting started

All you have to do to get started is to add this piece of code below to your pubspec.yaml

```yaml
flutter:
    fonts:
    - family: icappsIcons
        fonts:
        - asset: packages/icapps_icons/lib/fonts/icappsIcons.ttf
```

## Usage

You can use it like you would do any other icon in flutter.

```dart
Icon(IcappsIcons.alarm),
```
