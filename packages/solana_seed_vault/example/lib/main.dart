import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_example/bl/bloc.dart';
import 'package:wallet_example/bl/signature_verifier.dart';
import 'package:wallet_example/presentation/limits_section.dart';
import 'package:wallet_example/presentation/seed_list.dart';
import 'package:wallet_example/presentation/seed_section.dart';

void main() {
  runApp(
    BlocProvider<SeedVaultBloc>(
      create: (context) => SeedVaultBloc(const SignatureVerifier())..init(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final SeedVaultBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<SeedVaultBloc>();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: BlocBuilder<SeedVaultBloc, SeedVaultState>(
          builder: (context, state) => Scaffold(
            appBar: AppBar(
              title: const Text('FakeWallet'),
              actions: [
                IconButton(
                  onPressed: _bloc.refreshUI,
                  icon: const Icon(Icons.refresh),
                ),
              ],
            ),
            body: Center(
              child: state.map(
                none: always(const CircularProgressIndicator()),
                loaded: always(const SeedVaultContent()),
                error: (state) => Text(state.err),
                unauthorized: always(
                  ElevatedButton(
                    onPressed: _bloc.init,
                    child: const Text('Request permission'),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}

class SeedVaultContent extends StatelessWidget {
  const SeedVaultContent({super.key});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(16),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  const LimitsSection(),
                  const SizedBox(height: 16),
                  const SeedSection(),
                  const SizedBox(height: 16),
                  const SeedList(),
                ],
              ),
            ),
          ],
        ),
      );
}
