import 'dart:async';
import 'dart:typed_data';

import 'package:ec_client_dart/ec_client_dart.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/solana.dart';
import 'auth_scope.dart';
import 'data/account_repository.dart';
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

  @Singleton(scope: authScope, dispose: disposeEcClient)
  @preResolve
  Future<EspressoCashClient> ecClient(ECWallet wallet, AccountRepository repo) async {
    final token = await repo.loadAuthToken();

    return EspressoCashClient(
      walletAddress: wallet.publicKey.toBase58(),
      sign: (data) async {
        final signature = await wallet.sign([Uint8List.fromList(data.toList())]);

        return signature.first.toBase58();
      },
      onTokenUpdated: (t) => repo.saveAuthToken(t),
      token: token,
    );
  }
}

Future<void> disposeEcClient(EspressoCashClient client) => client.dispose();
