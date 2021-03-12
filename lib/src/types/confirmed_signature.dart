class ConfirmedSignature {
  ConfirmedSignature({
    this.signature,
    this.slot,
    this.err,
    this.memo,
    this.blockTime,
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
