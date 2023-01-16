import 'package:collection/collection.dart';
import 'package:solana/src/crypto/ed25519_hd_public_key.dart';

class LoadedAddresses {
  LoadedAddresses({
    required this.writable,
    required this.readonly,
  });

  final List<Ed25519HDPublicKey> writable;
  final List<Ed25519HDPublicKey> readonly;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoadedAddresses &&
          runtimeType == other.runtimeType &&
          const DeepCollectionEquality().equals(writable, other.writable) &&
          const DeepCollectionEquality().equals(readonly, other.readonly);

  @override
  int get hashCode => Object.hash(
        const DeepCollectionEquality().hash(writable),
        const DeepCollectionEquality().hash(readonly),
      );
}
