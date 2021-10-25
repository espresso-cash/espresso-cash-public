import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana_api_generator/src/parse_type.dart';

part 'parameter.freezed.dart';
part 'parameter.g.dart';

@freezed
class Parameter with _$Parameter {
  const factory Parameter({
    required String type,
    required String name,
    required String description,
    required String? url,
    @JsonKey(name: 'is_optional') required bool isOptional,
    @JsonKey(name: 'default_value') required dynamic defaultValue,
  }) = _Parameter;

  factory Parameter.fromJson(Map<String, dynamic> data) =>
      _$ParameterFromJson(data);

  const Parameter._();

  String asRequestParameter() {
    final isRequired = !isOptional && defaultValue == null;
    final nullableMarker = !isRequired && isOptional ? '?' : '';

    return _isPrimitive ? '$name' : '$name$nullableMarker.toJson()';
  }

  String asMethodArgument() {
    final isRequired = !isOptional && defaultValue == null;
    final nullableMarker = !isRequired && isOptional ? '?' : '';
    final parsedType = parseType(type);
    final requiredMarker = isRequired ? 'required ' : '';

    if (!isOptional && !_isPrimitive) {
      return '$parsedType $name = const $parsedType()';
    } else {
      return '$requiredMarker$parsedType$nullableMarker $name';
    }
  }

  bool get _isPrimitive {
    final parsedType = parseType(type);
    return parsedType == 'int' ||
        parsedType == 'String' ||
        parsedType.startsWith('List<') ||
        parsedType.startsWith('Map<');
  }

  @override
  String toString() => name;
}
