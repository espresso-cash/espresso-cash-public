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
  
  _${element.name}.forClient(this._client);
  
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
    final isWithContext =
        TypeChecker.fromRuntime(WithContextResult).hasAnnotationOf(method);
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

  String _listFromJson(String data) {
    final type = (this as ParameterizedType).typeArguments.first;
    return 'fromJsonArray($data, ${type.convertFn()})';
  }

  String _mapFromJson(String data) {
    final kType = (this as ParameterizedType).typeArguments.first;
    final vType = (this as ParameterizedType).typeArguments.last;

    return 'fromJsonMap($data, ${kType.convertFn()}, ${vType.convertFn()})';
  }

  List<String> _parameterizedTypeFromJsonParameters(
    ParameterizedType parameterizedType,
    String data,
  ) {
    final typeArguments = parameterizedType.typeArguments;
    if (typeArguments.isEmpty) {
      return ['$data as Map<String, dynamic>'];
    } else {
      return [
        '$data as Map<String, dynamic>',
        '(json) => ${typeArguments.first.fromJson('json')}',
      ];
    }
  }

  String _parameterizedTypeFromJson(
    ParameterizedType parameterizedType,
    String data,
  ) {
    final typeName = getDisplayString(withNullability: false);

    if (isPrimitive) {
      return '$_nullCheck$data as $typeName';
    } else if (isDartCoreList) {
      return _listFromJson(data);
    } else if (isDartCoreMap) {
      return _mapFromJson(data);
    } else {
      final parameters =
          _parameterizedTypeFromJsonParameters(parameterizedType, data);
      return '$_nullCheck$typeName.fromJson(${parameters.join(', ')})';
    }
  }

  String fromJson(String data) {
    if (this is ParameterizedType) {
      return _parameterizedTypeFromJson(this as ParameterizedType, data);
    } else {
      final typeName = getDisplayString(withNullability: false);
      return '$_nullCheck$data as $typeName';
    }
  }

  String get _nullCheck => isNullableType ? '(value == null) ? null : ' : '';

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
