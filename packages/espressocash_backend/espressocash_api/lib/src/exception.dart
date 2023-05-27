import 'package:json_annotation/json_annotation.dart';

part 'exception.g.dart';

@JsonSerializable()
class EspressoCashException implements Exception {
  const EspressoCashException({required this.error});

  factory EspressoCashException.fromJson(Map<String, dynamic> json) =>
      _$EspressoCashExceptionFromJson(json);

  Map<String, dynamic> toJson() => _$EspressoCashExceptionToJson(this);

  final EspressoCashError error;
}

@JsonEnum(fieldRename: FieldRename.pascal)
enum EspressoCashError {
  /// Account is invalid or does not exist.
  invalidEscrowAccount,
}
