import 'dart:convert';
import 'dart:typed_data';

import 'package:espressocash_api/espressocash_api.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/solana.dart';

import '../accounts/models/account.dart';
import '../accounts/models/ec_wallet.dart';
import '../accounts/services/account_service.dart';
import 'auth_scope.dart';

@module
abstract class AuthModule {
  const AuthModule();

  @Singleton(scope: authScope)
  // ignore: avoid-non-null-assertion, shouldn't be null
  MyAccount account(AccountService service) => service.value!;

  @Singleton(scope: authScope)
  ECWallet wallet(MyAccount account) => account.wallet;

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
