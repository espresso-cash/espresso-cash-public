import 'dart:convert';

import 'package:build/build.dart';
import 'package:dart_style/dart_style.dart';
import 'package:solana/src/builders/helpers.dart';

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
    final buffer = StringBuffer()..write(_outputFileHeader);

    for (final method in api.methods) {
      final result = method.result;
      final parameters = method.parameters;
      final returnType = toDartType(result.type);
      final resultType = result.type;
      final def = 'Future<$returnType> ${method.name}';
      if (parameters != null) {
        buffer
          ..write('$def({')
          ..write(_unwrapParameters(parameters))
          ..write('}) async');
      } else {
        buffer.write('$def() async');
      }
      buffer.write('{final data = await _client.request(\'${method.name}\',');
      if (parameters != null) {
        buffer.write(_parametersAsCallArguments(parameters));
      }
      buffer
        ..write(');')
        ..write('');
      if (resultType.startsWith('RpcResponse')) {
        buffer.write(
          '''
          final response = Response<RpcResponse<$returnType>>.fromJson(
            data,
            (Object? data) => RpcResponse<$returnType>.fromJson(
              data as Map<String, dynamic>,
              (Object? data) => ${_createFromJson(returnType)},
            ),
          );
          final rpcResponse = response.result;
          
          return rpcResponse.value;''',
        );
      } else {
        buffer.write(
          '''
          final response = Response<$returnType>.fromJson(
           data,
            (Object? data) => ${_createFromJson(returnType)},
          );
          
          return response.result;''',
        );
      }
      buffer.write('  }\n');
    }
    buffer.write('}');
    final formatter = DartFormatter();

    buildStep
        .writeAsString(outfile, formatter.format(buffer.toString()))
        .ignore();
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

String _unwrapParameters(List<_Field> parameters) {
  final buffer = StringBuffer();
  for (final field in parameters) {
    final type = field.type;
    if (type == 'object') {
      final fields = field.fields;
      if (fields == null) {
        print(field.name);
        throw ArgumentError('cannot unwrap object of unknown fields');
      }
      buffer.write(_unwrapParameters(fields));
    } else {
      final dartType = toDartType(type);
      if (!field.isOptional) {
        buffer.write('required $dartType ${field.name},');
      } else {
        buffer.write('$dartType? ${field.name},');
      }
    }
  }

  return buffer.toString();
}

String _createFromJsonForList(String type) {
  final regexp = RegExp('List<([^>]+)>');
  final allMatches = regexp.allMatches(type);
  final typeName = allMatches.first.group(1);
  if (typeName == null) {
    throw ArgumentError('cannot determine the type of list elements');
  }

  return '''(data as List<dynamic>)
          .map((dynamic data) => ${_createFromJson(typeName)})
          .toList(growable: false)
        ''';
}

String _createFromJson(String type) {
  switch (type) {
    case 'List<int>':
    case 'LeaderSchedule':
    case 'int':
    case 'String':
      return 'data as $type';
    default:
      if (RegExp('List<([^>]+)>').stringMatch(type) != null) {
        return _createFromJsonForList(type);
      }

      return '$type.fromJson(data as Map<String, dynamic>)';
  }
}

String _dumpObject(List<_Field>? fields) {
  final buffer = StringBuffer()..write('<String, dynamic>{');
  for (final field in fields ?? <_Field>[]) {
    if (field.type == 'object') {
      buffer.write('\'${field.name}\': ${_dumpObject(field.fields)},');
    } else {
      buffer.write('\'${field.name}\': ${field.name},');
    }
  }
  buffer.write('}');

  return buffer.toString();
}

String _parametersAsCallArguments(List<_Field> parameters) {
  final buffer = StringBuffer()..write('params: <dynamic>[');

  for (final parameter in parameters) {
    if (parameter.type == 'object') {
      buffer.write('${_dumpObject(parameter.fields)},');
    } else {
      buffer.write('${parameter.name},');
    }
  }
  buffer.write('    ]');

  return buffer.toString();
}

const _outputFileHeader = '''
import 'dart:async';

import 'package:solana/src/rpc_api_definitions/helper_types/response.dart';
import 'package:solana/src/rpc_api_definitions/helper_types/rpc_response.dart';
import 'package:solana/src/rpc_api_definitions/solana.rpc.types.dart';
import 'package:solana/src/rpc_client/json_rpc_client.dart';

class RPCClient {
  /// Constructs a SolanaClient that is capable of sending various RPCs to')
  /// [rpcUrl].
  RPCClient(String rpcUrl) : _client = JsonRpcClient(rpcUrl);
  
  final JsonRpcClient _client;
''';
