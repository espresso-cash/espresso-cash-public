import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/solana.dart';

import 'ec_wallet.dart';

part 'account.freezed.dart';

@freezed
class MyAccount with _$MyAccount {
  const factory MyAccount({
    required ECWallet wallet,
    required AccessMode accessMode,
  }) = _MyAccount;

  const MyAccount._();

  String get address => wallet.address;

  Ed25519HDPublicKey get publicKey => wallet.publicKey;
}

@freezed
class AccessMode with _$AccessMode {
  const factory AccessMode.loaded() = _Loaded;
  const factory AccessMode.seedInputted() = _SeedInputted;
  const factory AccessMode.created() = _AccountCreated;
}
