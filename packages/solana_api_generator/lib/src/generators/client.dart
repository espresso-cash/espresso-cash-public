import 'dart:convert';

import 'package:build/build.dart';
import 'package:dart_style/dart_style.dart';
import 'package:solana_api_generator/src/generators/client_generator/client_spec.dart';

class ClientBuilder extends Builder {
  ClientBuilder();

  @override
  Map<String, List<String>> get buildExtensions => {
        '.client.json': ['.dart']
      };

  @override
  Future build(BuildStep buildStep) async {
    final formatter = DartFormatter();
    final outfile = buildStep.allowedOutputs.first;
    final content = await buildStep.readAsString(buildStep.inputId);
    final clientSpec = ClientSpecs.fromJson(json.decode(content));

    buildStep
        .writeAsString(outfile, formatter.format(clientSpec.toString()))
        .ignore();
  }
}
