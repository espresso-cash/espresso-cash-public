import 'dart:async';
import 'dart:convert';

import 'package:build/build.dart';
import 'package:recase/recase.dart';
import 'package:solana/src/builders/heplers.dart';

class TypesBuilder extends Builder {
  TypesBuilder();

  @override
  Map<String, List<String>> get buildExtensions => {
        '.rpc.types.json': ['.rpc.types.dart']
      };

  @override
  Future build(BuildStep buildStep) async {
    final StringBuffer buffer = StringBuffer();

    final output = buildStep.allowedOutputs.elementAt(0);
    final content = await buildStep.readAsString(buildStep.inputId);
    final data = json.decode(content) as Map<String, dynamic>;

    buffer
      ..writeln(
          'import \'package:freezed_annotation/freezed_annotation.dart\';\n')
      ..writeln('part \'${_toPartName(buildStep, "freezed")}\';')
      ..writeln('part \'${_toPartName(buildStep, "g")}\';\n');

    for (final String key in data.keys) {
      final dynamic definition = data[key];

      if (definition is! Map<String, dynamic>) {
        buffer.writeln('typedef $key = ${toDartType(definition as String)};\n');
        // A plain type
      } else if (definition['@type'] != null) {
        final _type = definition['@type'] as String;
        switch (_type) {
          case 'enum':
            buffer.writeln('enum $key {');
            for (final String value in definition['values']) {
              buffer.writeln('  $value,');
            }
            buffer.writeln('}\n');
            break;
          default:
            buffer.write('typedef $key = ${toDartType(_type)};\n\n');
        }
      } else {
        buffer
          ..writeln('@freezed')
          ..writeln('class $key with _\$$key {')
          ..writeln('  const factory $key({');

        for (final String name in definition.keys) {
          final dynamic value = definition[name];
          if (value is! Map<String, dynamic>) {
            throw ArgumentError('expected a map but got $value');
          }

          final field = _Field.fromJson(value);
          if (!name.isCamelCase()) {
            final camelCased = name.camelCase;
            final fieldDeclarator = '@JsonKey(name: \'$name\') required';
            buffer.writeln('    $fieldDeclarator ${field.type} $camelCased,');
          } else {
            buffer.writeln('    required ${field.type} $name,');
          }
        }
        buffer
          ..writeln('  }) = _$key;\n')
          ..write('  factory $key.fromJson(Map<String, dynamic> json)')
          ..write(' => _\$${key}FromJson(json);\n')
          ..writeln('}\n');
        ;
      }
    }

    buildStep.writeAsString(output, buffer.toString()).ignore();
  }
}

class _Field {
  _Field({
    required this.type,
    required this.description,
    this.nullable = false,
    this.fields = const {},
  });

  factory _Field.fromJson(Map<String, dynamic> json) {
    if (json['type'] == null) {
      throw ArgumentError('type must be NOT null');
    }

    if (json['description'] == null) {
      throw ArgumentError('description must be NOT null');
    }

    if (json['type'] is! String) {
      throw ArgumentError('type must be a string but was ${json["type"]}');
    }

    if (json['description'] is! String) {
      throw ArgumentError(
          'type must be a string but was ${json["description"]}');
    }

    return _Field(
      type: toDartType(json['type'] as String),
      description: json['description'] as String,
      nullable: json['nullable'] as bool? ?? false,
    );
  }

  @override
  String toString() => '''
class $type {}
    ''';

  final String type;
  final String description;
  bool nullable;
  Map<String, _Field> fields;
}

String _toPartName(BuildStep buildStep, String discriminator) {
  final outputId = buildStep.allowedOutputs.first;
  final withExtensionChanged = outputId.changeExtension('.$discriminator.dart');
  return withExtensionChanged.pathSegments.last;
}

extension on String {
  bool isCamelCase() => !contains(RegExp(r'[^a-zA-Z]'));
}
