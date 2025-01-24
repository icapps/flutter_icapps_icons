import 'package:flutter/material.dart';
import 'package:icapps_icons/icapps_icons.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                Icon(IcappsIcons.alarm),
                Icon(IcappsIcons.zeppelinFilled2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
