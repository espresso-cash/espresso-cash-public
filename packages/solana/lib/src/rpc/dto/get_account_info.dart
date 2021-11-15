part of 'dto.dart';

@JsonSerializable(createToJson: false)
class AccountInfo {
  AccountInfo({
    required this.lamports,
    required this.owner,
    required this.data,
    required this.executable,
    required this.rentEpoch,
  });

  factory AccountInfo.fromJson(Map<String, dynamic> json) =>
      _$AccountInfoFromJson(json);

  final int lamports;
  final String owner;
  final dynamic data;
  final bool executable;
  final int rentEpoch;
}
