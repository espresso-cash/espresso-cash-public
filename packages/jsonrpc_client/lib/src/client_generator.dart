import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
// ignore: implementation_imports
import 'package:solana/src/gen/annotations.dart';
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

Map<K, V> _fromJsonMap<K, V>(
  dynamic map,
  K Function(dynamic key) convertKey,
  V Function(dynamic value) convertValue,
) {
  if (map is! Map<String, dynamic>) {
    throw const FormatException('invalid input type is not map');
  }

  final result = <K, V>{};
  for (final entry in map.entries) {
    result[convertKey(entry.key)] = convertValue(entry.value);
  }

  return result;
}

List<T> _fromJsonArray<T>(dynamic array, T Function(dynamic) convert) {
  if (array is List<Map<String, dynamic>>) {
    return array.map(convert).toList(growable: false);
  } else {
    throw const FormatException('invalid input type is not json array');
  }
}

dynamic _getResult(dynamic raw) {
  if (raw is! Map<String, dynamic>) {
    throw const FormatException('expecting a map but got something else');
  }

  return raw['result'];
}

dynamic _unwrapAndGetResult(dynamic raw) {
  final dynamic result = _getResult(raw);
  if (result is! Map<String, dynamic>) {
    throw const FormatException('expecting a map but got something else');
  }

  return result['value'];
}

''';
  }

  String _generateConfig(MethodElement method) {
    final fields = method.parameters.where((p) => p.isNamed);
    if (fields.isEmpty) return '';

    final name = method.name.firstUpper;

    return '''
@JsonSerializable(createFactory: false, includeIfNull: false)
class ${name}Config {
  ${name}Config({${fields.map((f) => f.asFormalInitializer()).join(', ')}});

  ${fields.map((f) => f.asField()).join('\n')}

  Map<String, dynamic> toJson() => _\$${name}ConfigToJson(this);
}    
''';
  }

  String _generateMethod(MethodElement method) {
    final params = method.parameters
        .where((p) => p.isPositional)
        .map((p) => p.toJson())
        .toList();
    final iswithContext = method.metadata.any(
      (a) => a.toSource() == "@withContext",
    );
    final configParams = method.parameters.where((p) => p.isNamed);
    final String configParamsString;
    if (configParams.isNotEmpty) {
      final configName = method.name.firstUpper;
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

    return '''
@override
${method.getDisplayString(withNullability: true)} async {
  final config = $configParamsString;
  final data = await _client.request(
      '${method.name}',
      params: <dynamic>[
        ${params.join(', ')}${params.isEmpty ? '' : ','}
        if (config.isNotEmpty) config,
      ],
    );
  final dynamic value = ${iswithContext ? '_unwrapAndGetResult' : '_getResult'}(data);

  return ${returnType.fromJson("value")};
}
''';
  }
}

extension on String {
  String get firstUpper => '${this[0].toUpperCase()}${substring(1)}';
}

extension on DartType {
  String convertFn() {
    final name = getDisplayString(withNullability: true);
    if (isDartCoreList) {
      final type = (this as ParameterizedType).typeArguments.first;
      return '(dynamic v) => _fromJsonArray(v, ${type.convertFn()})';
    }
    // We are not considering nested maps, because we don't need
    // to
    if (primitiveTypes.any((t) => t.isExactlyType(this))) {
      return '(dynamic v) => v as $name';
    } else {
      return '(dynamic v) => $name.fromJson(v as Map<String, dynamic>)';
    }
  }

  String fromJson(String data) {
    final String genericFactory;
    if (this is ParameterizedType) {
      if (isDartCoreList) {
        final type = (this as ParameterizedType).typeArguments.first;
        return '_fromJsonArray($data, ${type.convertFn()})';
      } else if (isDartCoreMap) {
        final kType = (this as ParameterizedType).typeArguments.first;
        final vType = (this as ParameterizedType).typeArguments.last;

        return '_fromJsonMap($data, ${kType.convertFn()}, ${vType.convertFn()})';
      } else if ((this as ParameterizedType).typeArguments.isEmpty) {
        genericFactory = '';
      } else {
        final type = (this as ParameterizedType).typeArguments.first;
        genericFactory = '(json) => ${type.fromJson('json')}';
      }
    } else {
      genericFactory = '';
    }

    final fromJsonParameters = [
      '$data as Map<String, dynamic>',
      if (genericFactory.isNotEmpty) genericFactory,
    ];

    return primitiveTypes.any((t) => t.isExactlyType(this))
        ? '$data as ${getDisplayString(withNullability: true)}'
        : '${getDisplayString(withNullability: true)}.fromJson(${fromJsonParameters.join(', ')})';
  }

  String get nullSuffix => isNullableType ? '?' : '';

  bool get isNullableType =>
      isDynamic || nullabilitySuffix == NullabilitySuffix.question;
}

extension on ParameterElement {
  String asField() {
    final t = type.getDisplayString(withNullability: true);
    return 'final $t $name;';
  }

  String asFormalInitializer() {
    if (isRequiredNamed) {
      return 'required this.$name';
    }

    return 'this.$name';
  }

  String toJson() {
    if (primitiveTypes.any((t) => t.isExactlyType(type))) {
      return name;
    } else if (isEnum()) {
      return '$name.value';
    } else {
      return '$name${type.nullSuffix}.toJson()';
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

final primitiveTypes = [
  String,
  int,
].map((t) => TypeChecker.fromRuntime(t));
