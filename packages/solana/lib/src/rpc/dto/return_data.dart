import 'package:json_annotation/json_annotation.dart';

part 'return_data.g.dart';

/// A ReturnData
@JsonSerializable()
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
  @JsonKey(fromJson: _dataFromJson, toJson: _dataToJson)
  final String data;

  Map<String, dynamic> toJson() => _$ReturnDataToJson(this);

  static List<String> _dataToJson(String data) => [data, 'base64'];

  static String _dataFromJson(dynamic data) {
    if (data is String) {
      return data;
    } else if (data is List &&
        data.length == 2 &&
        data.every((element) => element is String) &&
        data[1] == 'base64') {
      return data[0] as String;
    }

    throw ArgumentError.value(data, 'data', 'Invalid data type');
  }
}
