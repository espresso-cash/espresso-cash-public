import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana_api_generator/src/generators/client_generator/primitive.dart';
import 'package:solana_api_generator/src/parse_type.dart';
import 'package:solana_api_generator/src/utils/is_primitive_type.dart';

part 'result.freezed.dart';
part 'result.g.dart';

@freezed
class Result with _$Result {
  const factory Result({
    required String type,
    required String description,
    @Default(false) bool wrapped,
    @Default(false) bool nullable,
  }) = _Result;

  factory Result.fromJson(Map<String, dynamic> data) => _$ResultFromJson(data);

  const Result._();

  bool get _isPrimitive {
    final parsedType = parseType(type);
    return isPrimitiveType(parsedType);
  }

  String get _primitiveCode {
    final parsedType = parseType(type);
    final primitive = Primitive.fromTypeName(parsedType);

    final code = primitive.toCode(
      extractor: wrapped
          ? '_extractValueFromWrappedResponse'
          : '_extractResultFromResponse',
      variableName: 'response',
      nullable: nullable,
    );

    return 'return $code;';
  }

  @override
  String toString() {
    if (wrapped) {
      final parsedType = parseType(type);
      if (_isPrimitive) {
        return _primitiveCode;
      } else {
        final nullCheck = _nullCheckCode(nullable, 'value');
        return '''
              final dynamic value = _extractValueFromWrappedResponse(response);
              $nullCheck
              
              if (value is! Map<String, dynamic>) {
                throw InvalidResultValueException(value);
              }

              return $parsedType.fromJson(value);
          ''';
      }
    } else {
      final parsedType = parseType(type);
      if (_isPrimitive) {
        return _primitiveCode;
      } else {
        final nullCheck = _nullCheckCode(nullable, 'result');

        return '''
            final dynamic result = _extractResultFromResponse(response);
            $nullCheck
            
            if (result is! Map<String, dynamic>) {
              throw const FormatException('expecting result to be map and it is not');
            }

            return $parsedType.fromJson(result);
          ''';
      }
    }
  }
}

String _nullCheckCode(bool nullable, String variableName) {
  if (nullable) {
    return '''
        if ($variableName == null) {
          return null;
        }
    ''';
  } else {
    return '''
        if ($variableName == null) {
          throw NullResponseException();
        }
    ''';
  }
}
