import 'package:json_annotation/json_annotation.dart';

part 'return_data.g.dart';

/// A ReturnData
@JsonSerializable(createToJson: false)
class ReturnData {
  const ReturnData({
    required this.programId,
    required this.data,
  });

  factory ReturnData.fromJson(Map<String, dynamic> json) =>
      _$ReturnDataFromJson(json);

  /// The program that generated the return data, as base-58 encoded Pubkey
  final String programId;

  /// The return data itself, as base-64 encoded binary data
  final String data;
}
