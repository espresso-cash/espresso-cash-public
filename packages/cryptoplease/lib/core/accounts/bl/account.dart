import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/solana.dart';

part 'account.freezed.dart';

@freezed
class MyAccount with _$MyAccount {
  const factory MyAccount({
    required Wallet wallet,
    required String firstName,
    String? photoPath,
  }) = _MyAccount;

  const MyAccount._();

  String get address => wallet.address;

  Ed25519HDPublicKey get publicKey => wallet.publicKey;
}
