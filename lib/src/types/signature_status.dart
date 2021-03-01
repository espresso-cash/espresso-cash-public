import 'package:json_annotation/json_annotation.dart';

part 'signature_status.g.dart';

enum TxStatus { processed, confirmed, finalized }

@JsonSerializable(createToJson: false)
class SignatureStatus {
  SignatureStatus({
    this.slot,
    this.confirmations,
    this.err,
    this.confirmationStatus,
  });

  factory SignatureStatus.fromJson(Map<String, dynamic> json) =>
      _$SignatureStatusFromJson(json);

  final int slot;
  final int confirmations;
  final dynamic err;
  final TxStatus confirmationStatus;

  String toString() => confirmationStatus.toString();
}
