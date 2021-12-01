import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:jsonrpc_client_annotation/jsonrpc_client_annotation.dart';
import 'package:source_gen/source_gen.dart';

class ClientGenerator extends GeneratorForAnnotation<SolanaRpcClient> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final methods = (element as ClassElement) //
        .methods
        .where((m) => m.isAbstract);

    return '''
class _${element.name} implements ${element.name} {
  _${element.name}(String url) : _client = JsonRpcClient(url);
  
  final JsonRpcClient _client;
  
  ${methods.map(_generateMethod).join('\n')}
}

${methods.map(_generateConfig).join('\n\n')}

''';
  }

  String _generateConfig(MethodElement method) {
    final fields = method.parameters.where((p) => p.isNamed);
    if (fields.isEmpty) return '';

    final name = method.name.capitalized;

    return '''
@JsonSerializable(createFactory: false, includeIfNull: false)
class ${name}Config {
  ${name}Config({${fields.map((f) => f.asFormalInitializer()).join(', ')},});

  ${fields.map((f) => f.asField()).join('\n')}

  Map<String, dynamic> toJson() => _\$${name}ConfigToJson(this);
}    
''';
  }

  String _generateMethod(MethodElement method) {
    final params = method.parameters.where((p) => p.isPositional).map((p) {
      if (p.type.isNullableType) {
        return 'if (${p.name} != null) ${p.toJson()}';
      } else {
        return p.toJson();
      }
    }).toList();
    final isWithContext = method.metadata.any(
      (a) => a.toSource() == "@withContext",
    );
    final configParams = method.parameters.where((p) => p.isNamed);
    final String configParamsString;
    if (configParams.isNotEmpty) {
      final configName = method.name.capitalized;
      final parameters =
          configParams.map((p) => '${p.name}: ${p.name}').join(', ');
      configParamsString = '''
          ${configName}Config($parameters).toJson()
''';
    } else {
      configParamsString = '<String, dynamic>{}';
    }

    final returnType =
        (method.returnType as ParameterizedType).typeArguments.first;
    final readerFn = isWithContext ? 'unwrapAndGetResult' : 'getResult';

    return '''
@override
${method.getDisplayString(withNullability: true)} async {
  final config = $configParamsString;
  final response = await _client.request(
      '${method.name}',
      params: <dynamic>[
        ${params.join(', ')}${params.isEmpty ? '' : ','}
        if (config.isNotEmpty) config,
      ],
    );
  final dynamic value = $readerFn(response);

  return ${returnType.fromJson("value")};
}
''';
  }
}

extension on String {
  String get capitalized => '${this[0].toUpperCase()}${substring(1)}';
}

extension on DartType {
  String convertFn() {
    final String definition;
    final nullCheck = isNullableType ? '(v == null) ? null : ' : '';
    final name = getDisplayString(withNullability: false);

    if (isDartCoreList) {
      final type = (this as ParameterizedType).typeArguments.first;
      definition = '${nullCheck}fromJsonArray(v, ${type.convertFn()})';
    } else if (isPrimitive) {
      definition = '${nullCheck}v as $name';
    } else {
      definition = '$nullCheck$name.fromJson(v as Map<String, dynamic>)';
    }

    return '(dynamic v) => $definition';
  }

  String fromJson(String data) {
    final String genericFactory;
    final typeIsPrimitive = isPrimitive;
    final typeName = getDisplayString(withNullability: true);
    final nullCheck = isNullableType ? '(value == null) ? null : ' : '';
    if (this is ParameterizedType) {
      if (isDartCoreList) {
        final type = (this as ParameterizedType).typeArguments.first;
        return 'fromJsonArray($data, ${type.convertFn()})';
      } else if (isDartCoreMap) {
        final kType = (this as ParameterizedType).typeArguments.first;
        final vType = (this as ParameterizedType).typeArguments.last;

        return 'fromJsonMap($data, ${kType.convertFn()}, ${vType.convertFn()})';
      } else if ((this as ParameterizedType).typeArguments.isEmpty) {
        genericFactory = '';
      } else {
        final type = (this as ParameterizedType).typeArguments.first;
        genericFactory = '(json) => ${type.fromJson('json')}';
      }
      final fromJsonParameters = [
        '$data as Map<String, dynamic>',
        if (genericFactory.isNotEmpty) genericFactory,
      ];

      if (typeIsPrimitive) {
        return '$nullCheck$data as $typeName';
      }

      return '$nullCheck$typeName.fromJson(${fromJsonParameters.join(', ')})';
    } else {
      return '$nullCheck$data as $typeName';
    }
  }

  bool get isPrimitive =>
      isDartCoreSymbol ||
      isDartCoreInt ||
      isDartCoreDouble ||
      isDartCoreBool ||
      isDartCoreString;

  bool get isNullableType =>
      isDynamic || nullabilitySuffix != NullabilitySuffix.none;

  String get nullSuffix =>
      nullabilitySuffix != NullabilitySuffix.none ? '?' : '';
}

extension on ParameterElement {
  String asField() {
    final t = type.getDisplayString(withNullability: true);
    return 'final $t $name;';
  }

  String asFormalInitializer() {
    var defaultValue = hasDefaultValue ? ' = $defaultValueCode' : '';
    if (isRequiredNamed) {
      return 'required this.$name$defaultValue';
    }

    return 'this.$name$defaultValue';
  }

  String toJson() {
    if (type.isPrimitive) {
      return name;
    } else if (isEnum()) {
      return '$name.value';
    } else if (!type.isDartCoreList) {
      return '$name${type.nullSuffix}.toJson()';
    } else {
      return '$name${type.nullSuffix}';
    }
  }

  bool isEnum() {
    final element = type.element;
    if (element is ClassElement) {
      return element.isEnum;
    }

    return false;
  }
}
