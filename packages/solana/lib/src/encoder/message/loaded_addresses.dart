import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/src/crypto/ed25519_hd_public_key.dart';

part 'loaded_addresses.freezed.dart';

@freezed
class LoadedAddresses with _$LoadedAddresses {
  const factory LoadedAddresses({
    required List<Ed25519HDPublicKey> writable,
    required List<Ed25519HDPublicKey> readonly,
  }) = _LoadedAddresses;
}
