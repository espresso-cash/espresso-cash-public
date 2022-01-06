import 'package:solana/solana.dart';
import 'package:solana/src/common/byte_array.dart';

class Authorized {
  Authorized({
    required this.staker,
    required this.withdrawer,
  });

  ByteArray serialize() => Buffer.fromConcatenatedByteArrays([
        Buffer.fromBase58(staker),
        Buffer.fromBase58(withdrawer),
      ]);

  final String staker;
  final String withdrawer;
}

class Lockup {
  const Lockup({
    required this.unixTimestamp,
    required this.epoch,
    required this.custodian,
  });

  const Lockup.none()
      : unixTimestamp = 0,
        epoch = 0,
        custodian = '11111111111111111111111111111111';

  ByteArray serialize() => Buffer.fromConcatenatedByteArrays([
        Buffer.fromInt64(unixTimestamp),
        Buffer.fromUint64(epoch),
        Buffer.fromBase58(custodian),
      ]);

  final UnixTimestamp unixTimestamp;
  final Epoch epoch;
  final String custodian;
}

abstract class StakeAuthorize {
  const factory StakeAuthorize.staker(String pubKey) = StakerAuthority;

  const factory StakeAuthorize.withdrawer(String pubKey) = WithdrawerAuthority;

  String get pubKey;

  ByteArray serialize();
}

class StakerAuthority implements StakeAuthorize {
  const StakerAuthority(this.pubKey) : type = 0;

  ByteArray serialize() => Buffer.fromConcatenatedByteArrays([
        Buffer.fromBase58(pubKey),
        Buffer.fromUint32(type),
      ]);

  final String pubKey;
  final int type;
}

class WithdrawerAuthority implements StakeAuthorize {
  const WithdrawerAuthority(this.pubKey) : type = 1;

  ByteArray serialize() => Buffer.fromConcatenatedByteArrays([
        Buffer.fromBase58(pubKey),
        Buffer.fromUint32(type),
      ]);

  final String pubKey;
  final int type;
}

typedef Epoch = int;
typedef UnixTimestamp = int;
