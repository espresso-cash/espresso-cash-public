import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana_api_generator/src/parse_type.dart';

part 'result.freezed.dart';
part 'result.g.dart';

@Freezed(unionKey: 'kind')
class Result with _$Result {
  @FreezedUnionValue('wrapped')
  const factory Result.wrapped({
    required String type,
    required String description,
    @Default(false) bool nullable,
  }) = WrappedResult;

  @FreezedUnionValue('simple')
  const factory Result.simple({
    required String type,
    required String description,
    @Default(false) bool nullable,
  }) = SimpleResult;

  factory Result.fromJson(Map<String, dynamic> data) => _$ResultFromJson(data);

  const Result._();

  bool get _isPrimitive {
    final parsedType = parseType(type);
    return parsedType == 'int' ||
        parsedType == 'String' ||
        parsedType.startsWith('List<') ||
        parsedType.startsWith('Map<');
  }

  @override
  String toString() => map(
        wrapped: (result) {
          final parsedType = parseType(type);
          if (_isPrimitive) {
            return result.primitive;
          } else {
            final nullCheck = _nullCheckCode(nullable, 'value');
            return '''
              final value = _extractValueFromWrappedResponse(response);
              $nullCheck

              return $parsedType.fromJson(value);
          ''';
          }
        },
        simple: (result) {
          final parsedType = parseType(type);
          if (_isPrimitive) {
            return result.primitive;
          } else {
            final nullCheck = _nullCheckCode(nullable, 'result');

            return '''
            final result = _extractResultFromResponse(response);
            $nullCheck
            
            if (result is! Map<String, dynamic>) {
              throw const FormatException('expecting result to be map and it is not');
            }

            return $parsedType.fromJson(result);
          ''';
          }
        },
      );
}

extension on SimpleResult {
  String get primitive {
    final parsedType = parseType(type);
    final optionalMarker = nullable ? '?' : '';
    return '''
      return _extractResultFromResponse(response) as $parsedType$optionalMarker;
    ''';
  }
}

extension on WrappedResult {
  String get primitive {
    final parsedType = parseType(type);
    final optionalMarker = nullable ? '?' : '';
    return '''
      return _extractValueFromWrappedResponse(response) as $parsedType$optionalMarker;
  ''';
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
