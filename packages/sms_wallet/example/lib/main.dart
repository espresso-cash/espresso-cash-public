import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_wallet_example/mobile_wallet/bloc.dart';
import 'package:sms_wallet_example/screens/auth_screen.dart';

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
              remote: (r) => r.when(
                authorizeDapp: (request) => AuthScreen(request: request),
              ),
            ),
          ),
        ),
      );
}
