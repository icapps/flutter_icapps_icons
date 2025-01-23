import 'dart:io';
import 'package:xml/xml.dart';

void main() async {
  final ttxPath = '../fonts/icappsIcons.ttx'; // Update this path
  final file = File(ttxPath);

  // Ensure the file exists
  if (!file.existsSync()) {
    print('TTX file not found at $ttxPath');
    return;
  }

  // Read the TTX content
  final ttxContent = await file.readAsString();

  // Parse XML
  final document = XmlDocument.parse(ttxContent);

  // We want to extract codepoint -> glyphName from the <map> elements under <cmap>
  // The <map> element has attributes like: code="0xe800" name="arrow-double-up-down"
  final mapElements = document.findAllElements('map');

  // Store results in a list or map if you like
  final glyphMappings = <String, String>{};

  for (final mapElement in mapElements) {
    final codeStr = mapElement.getAttribute('code');
    final glyphName = mapElement.getAttribute('name');

    // We only proceed if both are non-null and codeStr starts with "0x" (hex)
    if (codeStr != null && glyphName != null && codeStr.startsWith('0x')) {
      // Strip off the "0x", parse hex, then convert to uppercase string
      final codePointValue = int.tryParse(codeStr.substring(2), radix: 16);
      if (codePointValue != null) {
        final codePointHex = codePointValue.toRadixString(16).toUpperCase();
        glyphMappings[glyphName] = 'U+$codePointHex';
      }
    }
  }

  // Print the collected mappings:
  print('Glyph Name -> Codepoint');
  glyphMappings.forEach((glyphName, codepoint) {
    print('$glyphName -> $codepoint');
  });
}
