import 'package:json_annotation/json_annotation.dart';

part 'confirmed_signature.g.dart';

@JsonSerializable(createToJson: false)
class ConfirmedSignature {
  ConfirmedSignature({
    this.signature,
    this.slot,
    this.err,
    this.memo,
    this.blockTime,
  });

  factory ConfirmedSignature.fromJson(Map<String, dynamic> json) =>
      _$ConfirmedSignatureFromJson(json);

  final String signature;
  final int slot;
  final dynamic err;
  final String memo;
  final int blockTime;

  String toString() => signature;
}
