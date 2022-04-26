import 'package:cryptoplease/bl/accounts/accounts_bloc.dart';
import 'package:cryptoplease/bl/wallet/wallet.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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

Future<String?> loadMnemonic(FlutterSecureStorage storage) =>
    storage.read(key: mnemonicKey);

/// Loads existing account if wallet data exist in [storage].
Future<MyAccount?> loadAccount(
  FlutterSecureStorage storage,
  LoadFileFromAppDir loadFile,
) async {
  final mnemonic = await loadMnemonic(storage);
  if (mnemonic == null) {
    return null;
  }
  final photoPath = await storage.read(key: photoKey);

  return MyAccount(
    firstName: (await storage.read(key: nameKey)) ?? '',
    photoPath: (await photoPath?.let(loadFile))?.path,
    wallet: await createWallet(
      mnemonic: mnemonic,
      account: 0,
    ),
  );
}

const mnemonicKey = 'mnemonic';
const nameKey = 'name';
const photoKey = 'photo';
