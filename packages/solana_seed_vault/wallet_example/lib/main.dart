import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_example/bl/bloc.dart';
import 'package:wallet_example/presentation/seed_list.dart';

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
    bloc = SeedVaultBloc()..init();
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
                  state.maybeMap(
                    orElse: () => const SizedBox.shrink(),
                    loaded: (state) => Expanded(
                      child: SeedList(
                        seedList: state.seeds,
                        onDeauthorize: bloc.deathorizeSeed,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
}

// TODO(rhbrunetto): create a listener to observeSeedVaultContentChanges
