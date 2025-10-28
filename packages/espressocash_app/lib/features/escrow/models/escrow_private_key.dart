import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/solana.dart';

part 'escrow_private_key.freezed.dart';

@freezed
abstract class EscrowPrivateKey with _$EscrowPrivateKey {
  factory EscrowPrivateKey(List<int> bytes) = _EscrowPrivateKey;

  EscrowPrivateKey._();

  static Future<EscrowPrivateKey> fromKeyPair(Ed25519HDKeyPair keyPair) async {
    final data = await keyPair.extract();

    return EscrowPrivateKey(data.bytes);
  }

  @override
  late final Future<Ed25519HDKeyPair> keyPair = Ed25519HDKeyPair.fromPrivateKeyBytes(
    privateKey: bytes,
  );
}
