import 'package:meta/meta.dart';

class ConfirmedSignature {
  ConfirmedSignature({
    @required this.signature,
    @required this.slot,
    @required this.err,
    @required this.memo,
    @required this.blockTime,
  });

  factory ConfirmedSignature.fromJson(Map<String, dynamic> json) {
    return ConfirmedSignature(
      signature: json['signature'],
      slot: json['slot'],
      err: json['err'],
      memo: json['memo'],
      blockTime: json['blockTime'],
    );
  }

  final String signature;
  final int slot;
  final dynamic err;
  final String memo;
  final int blockTime;

  String toString() => signature;
}
