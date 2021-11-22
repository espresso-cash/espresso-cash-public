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
    @Default(false)
    @JsonKey(name: 'with_default_parameter')
        bool withDefaultParameter,
  }) = _Parameter;

  factory Parameter.fromJson(Map<String, dynamic> data) =>
      _$ParameterFromJson(data);

  const Parameter._();

  String asRequestParameter() {
    final nullableMarker = isOptional && !withDefaultParameter ? '?' : '';

    // We have to convert to json (except primitive types) before
    // passing the parameters to the [JsonRpcClient.request()] method
    // because it uses the plain [json.encode()] and this will not
    // encode our data types correctly.
    return _isPrimitive ? '$name' : '$name$nullableMarker.toJson()';
  }

  String asMethodArgument() {
    final parsedType = parseType(type);
    if (withDefaultParameter) {
      return '$parsedType $name = const $parsedType()';
    } else {
      final nullableMarker = isOptional ? '?' : '';
      final requiredMarker = isOptional ? '' : 'required ';

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
