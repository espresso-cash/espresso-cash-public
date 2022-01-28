import 'package:solana/src/common/byte_array.dart';
import 'package:solana/src/encoder/encoder.dart';

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
