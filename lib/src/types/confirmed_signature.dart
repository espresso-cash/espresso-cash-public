class ConfirmedSignature {
  ConfirmedSignature.fromDynamic(dynamic value)
      : signature = value['signature'],
        slot = value['slot'],
        err = value['err'],
        memo = value['memo'],
        blockTime = value['blockTime'];

  final String signature;
  final int slot;
  final dynamic err;
  final String memo;
  final int blockTime;

  String toString() => signature;
}
