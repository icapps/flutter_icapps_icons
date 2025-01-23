import 'package:flutter/material.dart';

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
                Icon(IconData(0xe800, fontFamily: 'icappsIcons')),
                Icon(IconData(0xe801, fontFamily: 'icappsIcons')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
