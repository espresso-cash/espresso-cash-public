import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solana/base58.dart';
import 'package:solana/solana.dart';
import 'package:solana_mobile_wallet_example/mobile_wallet/bloc.dart';
import 'package:solana_mobile_wallet_example/screens/auth_screen.dart';
import 'package:solana_mobile_wallet_example/screens/send_transactions_screen.dart';
import 'package:solana_mobile_wallet_example/screens/sign_payloads_screen.dart';
import 'package:solana_mobile_wallet_example/screens/sign_transactions_for_sending.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final key = prefs.getString('key');

  final Ed25519HDKeyPair pair;
  if (key == null) {
    pair = await Ed25519HDKeyPair.random();
    final privateKey = await pair.extract().then((value) => value.bytes).then(base58encode);
    await prefs.setString('key', privateKey);
  } else {
    final privateKey = base58decode(key);
    pair = await Ed25519HDKeyPair.fromPrivateKeyBytes(privateKey: privateKey);
  }

  runApp(BlocProvider(create: (_) => MobileWalletBloc(pair), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: const Text('Plugin example app')),
      body: BlocConsumer<MobileWalletBloc, MobileWalletState>(
        listener: (context, state) {
          if (state is MobileWalletStateSessionTerminated) {
            SystemNavigator.pop();
          }
        },
        builder:
            (context, state) => switch (state) {
              MobileWalletStateNone() => const Center(child: Text('Running...')),
              MobileWalletStateSessionTerminated() => const Center(child: Text('Running...')),
              MobileWalletStateRemote(request: final r) => switch (r) {
                RemoteRequestAuthorizeDapp() => AuthScreen(request: r.request),
                RemoteRequestSignPayloads() => SignPayloadsScreen(request: r.request),
                RemoteRequestSignTransactionsForSending() => SignTransactionsForSendingScreen(
                  request: r.request,
                ),
                RemoteRequestSendTransactions() => SendTransactionsScreen(request: r),
              },
            },
      ),
    ),
  );
}
