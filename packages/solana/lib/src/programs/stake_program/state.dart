import 'package:solana/src/encoder/buffer.dart';

abstract class Serializable {
  Buffer serialize();
}

class Authorized implements Serializable {
  Authorized({
    required this.staker,
    required this.withdrawer,
  });

  @override
  Buffer serialize() => Buffer.fromConcatenatedByteArrays([
        Buffer.fromBase58(staker),
        Buffer.fromBase58(withdrawer),
      ]);

  final String staker;
  final String withdrawer;
}

class Lockup implements Serializable {
  const Lockup({
    required this.unixTimestamp,
    required this.epoch,
    required this.custodian,
  });

  const Lockup.zero()
      : unixTimestamp = 0,
        epoch = 0,
        custodian = '11111111111111111111111111111111';

  @override
  Buffer serialize() => Buffer.fromConcatenatedByteArrays([
        Buffer.fromUint64(unixTimestamp),
        Buffer.fromUint64(epoch),
        Buffer.fromBase58(custodian),
      ]);

  final int unixTimestamp;
  final Epoch epoch;
  final String custodian;
}

typedef Epoch = int;
