import 'dart:convert';
import 'dart:typed_data';

import 'package:espressocash_api/espressocash_api.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/solana.dart';

import '../accounts/data/account_repository.dart';
import '../accounts/models/ec_wallet.dart';

const authScope = 'auth';

@module
abstract class AuthModule {
  const AuthModule();

  @Singleton(scope: authScope)
  Future<ECWallet> wallet(AccountRepository repository) async {
    final account = await repository.loadAccount();

    // ignore: avoid-non-null-assertion, shouldn't be null
    return account!.wallet;
  }

  @LazySingleton(scope: authScope)
  EspressoCashClient ecClient(ECWallet wallet) => EspressoCashClient(
        sign: (data) async => (
          signature:
              await wallet.sign([Uint8List.fromList(utf8.encode(data))]) //
                  .then((value) => value.first.toBase58()),
          publicKey: wallet.publicKey.toBase58(),
        ),
      );
}
