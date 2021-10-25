import 'dart:async';
import 'dart:convert';

import 'package:build/build.dart';
import 'package:dart_style/dart_style.dart';
import 'package:solana_api_generator/src/generators/types_generator/types_spec.dart';

class TypesBuilder extends Builder {
  TypesBuilder();

  @override
  Map<String, List<String>> get buildExtensions => {
        '.types.json': ['.dart']
      };

  @override
  Future build(BuildStep buildStep) async {
    final formatter = DartFormatter();
    final content = await buildStep.readAsString(buildStep.inputId);
    final typesSpec = TypesSpec.create(buildStep, json.decode(content));
    final outfile = buildStep.allowedOutputs.elementAt(0);

    try {
      buildStep
          .writeAsString(outfile, formatter.format(typesSpec.toString()))
          .ignore();
    } on Exception {
      buildStep.writeAsString(outfile, typesSpec.toString()).ignore();
    }
  }
}
