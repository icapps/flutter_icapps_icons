import 'dart:io';

import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:icon_parser/case_util.dart';
import 'package:xml/xml.dart';

void main() async {
  const ttxPath = 'lib/fonts/icappsIcons.ttx'; // Update this path
  final file = File(ttxPath);

  if (!file.existsSync()) {
    // ignore: avoid_print
    print('TTX file not found at $ttxPath');
    return;
  }

  final ttxContent = await file.readAsString();
  final document = XmlDocument.parse(ttxContent);

  // We want to extract codepoint -> glyphName from the <map> elements under <cmap>
  // The <map> element has attributes like: code="0xe800" name="arrow-double-up-down"
  final mapElements = document.findAllElements('map');

  final glyphMappings = <String, String>{};

  for (final mapElement in mapElements) {
    final codeStr = mapElement.getAttribute('code');
    final glyphName = mapElement.getAttribute('name');

    if (codeStr != null && glyphName != null && codeStr.startsWith('0x')) {
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
      )
      ..fields.add(Field(
        (b) => b
          ..name = 'allIcons'
          ..type = refer('List<IcappsIconData>')
          ..static = true
          ..modifier = FieldModifier.constant
          ..assignment = literalList(
            mappings.entries
                .map(
                  (e) => refer('IcappsIconData(${e.value})'),
                )
                .toList()
                .reversed,
          ).code,
      )),
  );

  final fileContent = Library(
    (b) => b
      ..body.add(iconsClass)
      ..directives.add(Directive.import('package:icapps_icons/icapps_icon_data.dart')),
  ).accept(emitter);

  File('lib/icapps_icons.dart').writeAsStringSync(DartFormatter().format(fileContent.toString()));
}
