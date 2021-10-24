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

  String asRequestParameter() => name;

  String asMethodArgument() {
    final isRequired = !isOptional && defaultValue == null;
    final nullableMarker = !isRequired && isOptional ? '?' : '';
    final parsedType = parseType(type);
    final requiredMarker = isRequired ? 'required ' : '';

    return '$requiredMarker$parsedType$nullableMarker $name';
  }

  @override
  String toString() => name;

  /*String get defaultValueString {
    if (defaultValue == null) {
      return '';
    } else if (defaultValue is bool) {
      return ' = $defaultValue';
    } else if (defaultValue is int) {
      return ' = $defaultValue';
    } else {
      if (type == 'CommitmentObject') {
        return ' = const CommitmentObject(commitment: Commitment.$defaultValue)';
      } else if (type == 'Commitment') {
        return ' = Commitment.$defaultValue';
      } else if (type == 'Encoding') {
        return ' = Encoding.$defaultValue';
      } else {
        throw ArgumentError('cannot use other types of default values $type');
      }
    }
  }

  bool get isEnumType {
    switch (type) {
      case 'StakeActivationState':
      case 'Commitment':
      case 'Encoding':
      case 'RewardType':
      case 'CirculationStatus':
        return true;
      default:
        return false;
    }
  }

  bool get isNullable => defaultValue == null && isOptional;*/
}
