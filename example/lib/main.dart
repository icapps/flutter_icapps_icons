import 'package:flutter/material.dart';
import 'package:icapps_icons/icapps_icons.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(vertical: 32),
              itemCount: IcappsIcons.allIcons.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemBuilder: (context, index) => Column(
                children: [
                  Icon(
                    IcappsIcons.allIcons[index],
                    size: 48,
                  ),
                  Text(IcappsIcons.allIcons[index].codePoint.toString()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
