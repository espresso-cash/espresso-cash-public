import 'dart:async';
import 'dart:convert';

import 'package:build/build.dart';
import 'package:solana/src/builders/helpers.dart';

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
      ..writeln(_importFreezed)
      ..writeln(_importAccountData)
      ..writeln()
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
          value['name'] = name;

          final field = _Field.fromJson(value);
          // Now write it to the buffer
          buffer.writeln('    $field,');
        }
        buffer
          ..writeln('  }) = _$key;\n')
          ..write('  factory $key.fromJson(Map<String, dynamic> json)')
          ..write(' => _\$${key}FromJson(json);\n')
          ..writeln('}\n');
      }
    }

    buildStep.writeAsString(output, buffer.toString()).ignore();
  }
}

class _Field {
  _Field({
    required this.type,
    required this.description,
    required this.name,
    this.nullable = false,
    this.fields = const {},
  });

  factory _Field.fromJson(Map<String, dynamic> json) => _Field(
        type: toDartType(json['type'] as String),
        description: json['description'] as String,
        nullable: json['nullable'] as bool? ?? false,
        name: json['name'] as String,
      );

  @override
  String toString() {
    final marker = nullable ? '?' : '';
    if (type == 'AccountData') {
      return '@AccountDataConverter() required $type$marker $name';
    } else if (!name.isCamelCase) {
      final validName = name.toCamelCase();
      return '@JsonKey(name: \'$name\') required $type$marker $validName';
    } else {
      return 'required $type$marker $name';
    }
  }

  final String type;
  final String description;
  final String name;

  bool nullable;
  Map<String, _Field> fields;
}

String _toPartName(BuildStep buildStep, String discriminator) {
  final outputId = buildStep.allowedOutputs.first;
  final withExtensionChanged = outputId.changeExtension('.$discriminator.dart');
  return withExtensionChanged.pathSegments.last;
}

extension on String {
  bool get isCamelCase => !contains(RegExp('[^a-zA-Z]'));

  String toCamelCase() {
    final words = split(RegExp('[ _-]'));
    return words
        .map((word) => word.toLowerCase())
        .reduce((concatenated, word) => concatenated + word.toTitle());
  }

  String toTitle() {
    final lowerCased = toLowerCase();
    if (lowerCased.isEmpty) {
      throw ArgumentError('cannot determine the name of this field');
    }

    return lowerCased[0].toUpperCase() + lowerCased.substring(1);
  }
}

const _importFreezed =
    'import \'package:freezed_annotation/freezed_annotation.dart\';';
const _importAccountData =
    'import \'package:solana/src/rpc_api_definitions/helper_types/account_data.dart\';';
