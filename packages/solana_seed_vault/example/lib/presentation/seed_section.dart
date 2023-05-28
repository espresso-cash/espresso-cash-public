import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solana_seed_vault/solana_seed_vault.dart';
import 'package:wallet_example/bl/bloc.dart';
import 'package:wallet_example/presentation/snack_bar.dart';

class SeedSection extends StatefulWidget {
  const SeedSection({super.key});

  @override
  State<SeedSection> createState() => _SeedSectionState();
}

class _SeedSectionState extends State<SeedSection> {
  void _onAuthorizeSeed() {
    context
        .read<SeedVaultBloc>()
        .authorizeSeed()
        .then((it) => showSnackBar(context, it.map(always('Seed authorized'))));
  }

  void _onCreateSeed() {
    context
        .read<SeedVaultBloc>()
        .createSeed()
        .then((it) => showSnackBar(context, it.map(always('Seed created'))));
  }

  void _onImportSeed() {
    context
        .read<SeedVaultBloc>()
        .importSeed()
        .then((it) => showSnackBar(context, it.map(always('Seed imported'))));
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<SeedVaultBloc, SeedVaultState>(
        builder: (context, state) => state.maybeMap(
          orElse: always(const SizedBox.shrink()),
          loaded: (state) => ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              if (state.hasUnauthorizedSeeds)
                ListTile(
                  title: Text(
                    'Authorize seed for ${Purpose.signSolanaTransaction}',
                    style: _style,
                  ),
                  trailing: IconButton(
                    onPressed: _onAuthorizeSeed,
                    icon: const Icon(Icons.add, color: Colors.green),
                  ),
                )
              else
                const ListTile(
                  title: Text('No more seeds to be authorized', style: _style),
                ),
              const Divider(),
              ListTile(
                title: const Text('Create a new seed', style: _style),
                trailing: IconButton(
                  onPressed: _onCreateSeed,
                  icon: const Icon(Icons.add, color: Colors.green),
                ),
              ),
              const Divider(),
              ListTile(
                title: const Text('Import an existing seed', style: _style),
                trailing: IconButton(
                  onPressed: _onImportSeed,
                  icon: const Icon(Icons.add, color: Colors.green),
                ),
              ),
            ],
          ),
        ),
      );
}

const _style = TextStyle(fontSize: 18);
