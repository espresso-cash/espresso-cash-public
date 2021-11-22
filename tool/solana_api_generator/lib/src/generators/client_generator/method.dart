import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana_api_generator/src/generators/client_generator/parameter.dart';
import 'package:solana_api_generator/src/generators/client_generator/result.dart';
import 'package:solana_api_generator/src/parse_type.dart';
import 'package:solana_api_generator/src/utils/format_documentation.dart';

part 'method.freezed.dart';
part 'method.g.dart';

@freezed
class Method with _$Method {
  const factory Method({
    required String name,
    required String description,
    @Default(false) @JsonKey(name: 'is_deprecated') bool isDeprecated,
    @Default(false) @JsonKey(name: 'is_new') bool isNew,
    required String? replacement,
    required Result result,
    List<Parameter>? parameters,
  }) = _Method;

  factory Method.fromJson(Map<String, dynamic> data) => _$MethodFromJson(data);

  const Method._();

  String get documentation => formatDocumentation(description);

  bool get resultIsNullable => result.nullable;

  String get status {
    if (isDeprecated) {
      return '''
      
      ///
      /// **DEPRECATED**: Please use $replacement instead for solana-core v1.7 
      /// or newer
      @deprecated''';
    } else if (isNew) {
      return '''
      
      ///
      /// **NEW**: This method is only available in solana-core v1.7 or newer
      /// Please use $replacement instead for solana-core v1.6''';
    } else {
      return '';
    }
  }

  String get resultType => result.type;

  String get returnType =>
      parseType(result.type) + (resultIsNullable ? '?' : '');

  @override
  String toString() => '''$documentation$status
    Future<$returnType> $name(${parameters?.asMethodArguments() ?? ''}) async {
      final response = await _client.request(
        '$name',
        params: <dynamic>[
          ${parameters?.asRequestParameters() ?? ''}
        ],
      );
     
      $result
    }
''';
}

extension on List<Parameter> {
  String asRequestParameters() {
    if (isEmpty) {
      return '';
    }
    return '${map((p) => p.asRequestParameter()).join(',')},';
  }

  String asMethodArguments() {
    if (isEmpty) {
      return '';
    }
    return '{${map((p) => p.asMethodArgument()).join(',')},}';
  }
}
