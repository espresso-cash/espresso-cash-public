import 'package:solana/src/crypto/ed25519_hd_public_key.dart';
import 'package:solana/src/encoder/byte_array.dart';

abstract class StakeAuthorize {
  const factory StakeAuthorize.staker(Ed25519HDPublicKey pubKey) =
      StakerAuthority;

  const factory StakeAuthorize.withdrawer(Ed25519HDPublicKey pubKey) =
      WithdrawerAuthority;

  Ed25519HDPublicKey get pubKey;

  ByteArray serialize();
}

class StakerAuthority implements StakeAuthorize {
  const StakerAuthority(this.pubKey) : type = 0;

  @override
  ByteArray serialize() => ByteArray.merge([
        pubKey.toByteArray(),
        ByteArray.u32(type),
      ]);

  @override
  final Ed25519HDPublicKey pubKey;
  final int type;
}

class WithdrawerAuthority implements StakeAuthorize {
  const WithdrawerAuthority(this.pubKey) : type = 1;

  @override
  ByteArray serialize() => ByteArray.merge([
        pubKey.toByteArray(),
        ByteArray.u32(type),
      ]);

  @override
  final Ed25519HDPublicKey pubKey;
  final int type;
}

typedef Epoch = int;
typedef UnixTimestamp = int;
