import 'dart:convert';

import 'package:build/build.dart';
import 'package:solana/src/builders/heplers.dart';

class MethodsBuilder extends Builder {
  MethodsBuilder();

  @override
  Map<String, List<String>> get buildExtensions => {
        '.rpc.methods.json': ['.rpc.methods.dart']
      };

  @override
  Future build(BuildStep buildStep) async {
    final outfile = buildStep.allowedOutputs.first;
    final content = await buildStep.readAsString(buildStep.inputId);
    final parsed = json.decode(content) as Map<String, dynamic>;
    final api = _ApiSpecs.fromJson(parsed);
    final buffer = StringBuffer()
      ..writeln('import \'dart:async\';\n')
      ..writeln('import \'$_packagePath/helper_types/rpc_response.dart\';')
      ..writeln('import \'$_packagePath/solana.rpc.types.dart\';\n')
      ..writeln('class RPCClient {');
    for (final method in api.methods) {
      buffer
        ..writeln('  Future<${toDartType(method.result.type)}> ${method.name}(')
        ..writeln('      int parameter1,')
        ..writeln('  ) {')
        ..writeln('    throw UnimplementedError(\'not yet implemented\');')
        ..writeln('  }\n');
    }
    buffer.writeln('}');

    buildStep.writeAsString(outfile, buffer.toString()).ignore();
  }
}

// Not using `@JsonSerializable` because it is not possible to do it
// at the phase of the build process
class _ApiSpecs {
  const _ApiSpecs({
    required this.methods,
  });

  factory _ApiSpecs.fromJson(Map<String, dynamic> data) {
    final list = data['methods'] as List<dynamic>;

    return _ApiSpecs(
      methods: list
          .map((dynamic item) =>
              _ApiMethod.fromJson(item as Map<String, dynamic>))
          .toList(growable: false),
    );
  }

  final List<_ApiMethod> methods;
}

// Not using `@JsonSerializable` because it is not possible to do it
// at the phase of the build process
class _ApiMethod {
  const _ApiMethod({
    required this.name,
    required this.description,
    required this.isDeprecated,
    required this.isNew,
    required this.result,
    this.parameters,
  });

  factory _ApiMethod.fromJson(Map<String, dynamic> data) => _ApiMethod(
        name: data['name'] as String,
        description: data['description'] as String,
        isDeprecated: data['is_deprecated'] as bool,
        isNew: data['is_new'] as bool,
        parameters: _toFieldsList(data['parameters'] as List<dynamic>?),
        result: _Result.fromJson(data['result'] as Map<String, dynamic>),
      );

  final String name;
  final String description;
  final bool isDeprecated;
  final bool isNew;
  final List<_Field>? parameters;
  final _Result result;
}

class _Field {
  const _Field({
    required this.type,
    required this.name,
    required this.description,
    required this.isOptional,
    required this.fields,
    this.url,
  });

  factory _Field.fromJson(Map<String, dynamic> data) => _Field(
        type: data['type'] as String,
        name: data['name'] as String,
        description: data['description'] as String,
        isOptional: data['is_optional'] as bool,
        url: data['url'] as String?,
        fields: _toFieldsList(data['fields'] as List<dynamic>?),
      );

  final String type;
  final String name;
  final String description;
  final String? url;
  final bool isOptional;
  final List<_Field>? fields;
}

class _Result {
  const _Result({
    required this.type,
    required this.description,
    this.nullable = false,
  });

  factory _Result.fromJson(Map<String, dynamic> data) => _Result(
        type: data['type'] as String,
        description: data['description'] as String,
        nullable: data['nullable'] as bool?,
      );

  final String type;
  final String description;
  final bool? nullable;
}

List<_Field>? _toFieldsList(List<dynamic>? list) {
  if (list == null || list.isEmpty) {
    return null;
  }

  return list
      .map((dynamic item) => _Field.fromJson(item as Map<String, dynamic>))
      .toList(growable: false);
}

const _packagePath = 'package:solana/src/rpc_api_definitions';
