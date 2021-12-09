import 'package:json_annotation/json_annotation.dart';

part 'mint_account_data_info.g.dart';

@JsonSerializable()
class MintAccountDataInfo {
  const MintAccountDataInfo({
    required this.mintAuthority,
    required this.freezedAuthority,
    required this.isInitialized,
    required this.decimals,
    required this.supply,
  });

  factory MintAccountDataInfo.fromJson(Map<String, dynamic> json) =>
      _$MintAccountDataInfoFromJson(json);

  Map<String, dynamic> toJson() => _$MintAccountDataInfoToJson(this);

  final String? mintAuthority;
  final String? freezedAuthority;
  final bool isInitialized;
  final String supply;
  final int decimals;
}
