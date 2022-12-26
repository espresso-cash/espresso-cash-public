import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:request_permission/request_permission.dart';
import 'package:wallet_example/bl/bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final SeedVaultBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = SeedVaultBloc(
      RequestPermission.instace,
    )..init();
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Fake Wallet for Seed Vault'),
          ),
          body: Center(
            child: BlocBuilder<SeedVaultBloc, SeedVaultState>(
              bloc: bloc,
              builder: (context, state) => Column(
                children: [
                  Text(state.toString()),
                  ElevatedButton(
                    onPressed: bloc.authorizeSeed,
                    child: const Text('Authorize Seed'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}

// TODO(rhbrunetto): create a listener to observeSeedVaultContentChanges
