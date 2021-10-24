import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana_api_generator/src/utils/format_documentation.dart';

part 'enum_value.freezed.dart';
part 'enum_value.g.dart';

@freezed
class EnumValue with _$EnumValue {
  const factory EnumValue({
    required String name,
    required String description,
  }) = _EnumValue;

  factory EnumValue.fromJson(Map<String, dynamic> data) =>
      _$EnumValueFromJson(data);

  const EnumValue._();

  String get code => '''
  ${formatDocumentation(description)}
  $name,
''';
}
