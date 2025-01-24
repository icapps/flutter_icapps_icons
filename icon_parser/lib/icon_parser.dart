import 'dart:io';

import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:icon_parser/case_util.dart';
import 'package:xml/xml.dart';

void main() async {
  const ttxPath = 'lib/fonts/icappsIcons.ttx'; // Update this path
  final file = File(ttxPath);

  // Ensure the file exists
  if (!file.existsSync()) {
    // ignore: avoid_print
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
      final codePointValue = codeStr;
      glyphMappings[glyphName] = codePointValue;
    }
  }
  _createIconsFile(glyphMappings);
}

void _createIconsFile(Map<String, String> mappings) {
  final emitter = DartEmitter();

  final iconsClass = Class(
    (b) => b
      ..name = 'IcappsIcons'
      ..fields.addAll(
        mappings.entries.map(
          (e) => Field(
            (b) => b
              ..name = CaseUtil(e.key).camelCase
              ..type = refer('IcappsIconData')
              ..static = true
              ..modifier = FieldModifier.constant
              ..assignment = Code(
                'IcappsIconData(${e.value})',
              ),
          ),
        ),
      ),
  );

  final fileContent = Library(
    (b) => b
      ..body.add(iconsClass)
      ..directives.add(Directive.import('package:icapps_icons/icapps_icon_data.dart')),
  ).accept(emitter);

  File('lib/icapps_icons.dart').writeAsStringSync(DartFormatter().format(fileContent.toString()));
}
