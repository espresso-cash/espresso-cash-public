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
''';
  }

  String _generateConfig(MethodElement method) {
    final fields = method.parameters.where((p) => p.isNamed);
    if (fields.isEmpty) return '';

    final name = method.name.firstUpper;

    return '''
@JsonSerializable(createFactory: false, includeIfNull: false)
class ${name}Config {
  ${name}Config(${fields.map((f) => 'this.${f.name}').join(', ')});

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

    final configParams = method.parameters.where((p) => p.isNamed);
    final String configParamsString;
    if (configParams.isNotEmpty) {
      final configName = method.name.firstUpper;
      configParamsString = '''
          ${configName}Config(${configParams.map((p) => p.name).join(', ')}).toJson()
''';
    } else {
      configParamsString = '<String, dynamic>{}';
    }

    final returnType =
        (method.returnType as ParameterizedType).typeArguments.first;

    return '''
${method.getDisplayString(withNullability: true)} async {
  final config = $configParamsString;
  final data = await _client.request(
      '${method.name}',
      params: <dynamic>[
        ${params.join(', ')}${params.isEmpty ? '' : ','}
        if (config.isNotEmpty) config,
      ],
    );

    return ${returnType.fromJson("data['result']")};
}
''';
  }
}

extension on String {
  String get firstUpper => '${this[0].toUpperCase()}${substring(1)}';
}

extension on DartType {
  String fromJson(String data) {
    final String genericFactory;
    if (this is ParameterizedType) {
      if ((this as ParameterizedType).typeArguments.isEmpty) {
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

  String toJson() => primitiveTypes.any((t) => t.isExactlyType(type))
      ? name
      : '$name${type.nullSuffix}.toJson()';
}

final primitiveTypes = [
  String,
  int,
].map((t) => TypeChecker.fromRuntime(t));
