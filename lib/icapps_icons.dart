library icapps_icons;

import 'package:flutter/widgets.dart';

class _IcappsIcons extends IconData {
  const _IcappsIcons(int codePoint)
      : super(
          codePoint,
          fontFamily: 'icappsIcons',
        );
}

class IcappsIcons {
  IcappsIcons._();

  static const addIcon = _IcappsIcons(0xe800);
}
