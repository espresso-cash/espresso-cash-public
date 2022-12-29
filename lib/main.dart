import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_example/bl/bloc.dart';
import 'package:wallet_example/presentation/limits_section.dart';
import 'package:wallet_example/presentation/seed_list.dart';
import 'package:wallet_example/presentation/seed_section.dart';

void main() {
  runApp(
    BlocProvider<SeedVaultBloc>(
      create: (context) => SeedVaultBloc()..init(),
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
  late final SeedVaultBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = context.read<SeedVaultBloc>();
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('FakeWallet'),
          ),
          body: Center(
            child: BlocBuilder<SeedVaultBloc, SeedVaultState>(
              builder: (context, state) => state.map(
                none: always(const CircularProgressIndicator()),
                loaded: always(const SeedVaultContent()),
                error: (state) => Text(state.err),
                unauthorized: always(
                  ElevatedButton(
                    onPressed: bloc.init,
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
  const SeedVaultContent({Key? key}) : super(key: key);

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
