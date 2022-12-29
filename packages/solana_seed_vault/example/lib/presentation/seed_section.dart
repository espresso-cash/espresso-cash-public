import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solana_seed_vault/solana_seed_vault.dart';
import 'package:wallet_example/bl/bloc.dart';
import 'package:wallet_example/presentation/snack_bar.dart';

class SeedSection extends StatefulWidget {
  const SeedSection({Key? key}) : super(key: key);

  @override
  State<SeedSection> createState() => _SeedSectionState();
}

class _SeedSectionState extends State<SeedSection> {
  void _onAuthorizeSeed() {
    context
        .read<SeedVaultBloc>()
        .authorizeSeed()
        .then((s) => showSnackBar(s, context));
  }

  void _onCreateSeed() {
    context
        .read<SeedVaultBloc>()
        .createSeed()
        .then((s) => showSnackBar(s, context));
  }

  void _onImportSeed() {
    context
        .read<SeedVaultBloc>()
        .importSeed()
        .then((s) => showSnackBar(s, context));
  }

  @override
  Widget build(BuildContext context) => ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          ListTile(
            title: Text(
              'Authorize seed for ${Purpose.signSolanaTransaction}',
              style: _style,
            ),
            trailing: IconButton(
              onPressed: _onAuthorizeSeed,
              icon: const Icon(Icons.add, color: Colors.green),
            ),
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
      );
}

const _style = TextStyle(fontSize: 18);
