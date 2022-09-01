import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solana_mobile_wallet_example/mobile_wallet/bloc.dart';
import 'package:solana_mobile_wallet_example/screens/auth_screen.dart';
import 'package:solana_mobile_wallet_example/screens/send_transactions_screen.dart';
import 'package:solana_mobile_wallet_example/screens/sign_payloads_screen.dart';
import 'package:solana_mobile_wallet_example/screens/sign_transactions_for_sending.dart';

void main() {
  runApp(
    BlocProvider(
      create: (_) => MobileWalletBloc(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
          ),
          body: BlocConsumer<MobileWalletBloc, MobileWalletState>(
            listener: (context, state) => state.whenOrNull(
              sessionTerminated: SystemNavigator.pop,
            ),
            builder: (context, state) => state.when(
              none: () => const Center(
                child: Text('Running...'),
              ),
              sessionTerminated: () => const Center(
                child: Text('Running...'),
              ),
              remote: (r) => r.map(
                authorizeDapp: (r) => AuthScreen(request: r.request),
                signPayloads: (r) => SignPayloadsScreen(request: r.request),
                signTransactionsForSending: (r) =>
                    SignTransactionsForSendingScreen(request: r.request),
                sendTransactions: (r) => SendTransactionsScreen(request: r),
              ),
            ),
          ),
        ),
      );
}
