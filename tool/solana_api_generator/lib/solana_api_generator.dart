import 'dart:convert';
import 'dart:io';

import 'package:solana_api_generator/src/generators/types_generator/types_spec.dart';

int main() {
  _generateTypes('types.json');

  return 0;
}

Future<void> _generateTypes(String path) async {
  final file = File(path);
  final content = await file.readAsString();

  TypesSpec.create(json.decode(content))
      .outputTo('../../packages/solana/lib/src/dto');
}
