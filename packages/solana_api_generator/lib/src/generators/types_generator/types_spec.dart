import 'package:build/build.dart';
import 'package:solana_api_generator/src/generators/types_generator/type_definition.dart';

class TypesSpec {
  const TypesSpec(
    this._types,
    this._buildStep,
  );

  factory TypesSpec.create(BuildStep buildStep, dynamic data) {
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

    return TypesSpec(convertedTypes, buildStep);
  }

  @override
  String toString() => '''
///
/// Generated file, please do not modify
///
/// All types needed for the RPC api are defined in this file, they were
/// generated from a specification file in json format.
///

import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/dto/account_data.dart';
import 'package:solana/src/dto/by_identity_value.dart';
import 'package:solana/src/parsed_message/parsed_message.dart';

part '${_buildStep.part("g")}';

${_types.join('\n')}

''';

  final Iterable<TypeDefinition> _types;
  final BuildStep _buildStep;
}

extension on BuildStep {
  String part(String discriminator) {
    final outputId = allowedOutputs.first;
    final withExtensionChanged =
        outputId.changeExtension('.$discriminator.dart');
    return withExtensionChanged.pathSegments.last;
  }
}
