import 'dart:convert';
import 'dart:typed_data';

import 'package:espressocash_api/espressocash_api.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/solana.dart';
import 'auth_scope.dart';
import 'models/account.dart';
import 'models/ec_wallet.dart';
import 'services/account_service.dart';

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
