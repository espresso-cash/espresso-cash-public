import 'dart:io';

import 'package:dart_style/dart_style.dart';
import 'package:solana_api_generator/src/generators/types_generator/type_definition.dart';
import 'package:solana_api_generator/src/utils/to_snake_case.dart';

class TypesSpec {
  const TypesSpec(
    this._types,
  );

  factory TypesSpec.create(dynamic data) {
    if (data is! Map<String, dynamic>) {
      throw ArgumentError('cannot understand the type specs provided');
    }

    final dynamic types = data['@types'];
    final dynamic help = data['@help'];

    if (help is! Map<String, dynamic>) {
      throw ArgumentError('cannot understand the type specs provided');
    }

    if (types is! List<dynamic>) {
      throw ArgumentError('cannot understand the type specs provided');
    }

    final convertedTypes = types.map(
      (dynamic def) => TypeDefinition.fromJson(def as Map<String, dynamic>),
    );

    return TypesSpec(convertedTypes);
  }

  void outputTo(String directory) {
    final formatter = DartFormatter();
    for (final type in _types) {
      final name = toSnakeCase(type.name);
      final code = formatter.format('$type');

      File('$directory/$name.dart').writeAsString(code);
    }
  }

  final Iterable<TypeDefinition> _types;
}
