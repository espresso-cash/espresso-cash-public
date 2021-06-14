import 'package:json_annotation/json_annotation.dart';

part 'message_header.g.dart';

@JsonSerializable(createToJson: false)
class TxMessageHeader {
  TxMessageHeader({
    required this.numRequiredSignatures,
    required this.numReadonlySignedAccounts,
    required this.numReadonlyUnsignedAccounts,
  });

  factory TxMessageHeader.fromJson(Map<String, dynamic> json) =>
      _$TxMessageHeaderFromJson(json);

  final int numRequiredSignatures;
  final int numReadonlySignedAccounts;
  final int numReadonlyUnsignedAccounts;
}
