import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solana_seed_vault/solana_seed_vault.dart';
import 'package:wallet_example/bl/bloc.dart';
import 'package:wallet_example/presentation/account_list.dart';
import 'package:wallet_example/presentation/snack_bar.dart';

class SeedList extends StatelessWidget {
  const SeedList({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<SeedVaultBloc, SeedVaultState>(
        builder: (context, state) => state.maybeMap(
          orElse: () => const SizedBox.shrink(),
          loaded: (state) => ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.seeds.length,
            itemBuilder: (context, index) => SeedItem(
              seed: state.seeds.elementAt(index),
            ),
          ),
        ),
      );
}

class SeedItem extends StatefulWidget {
  const SeedItem({
    super.key,
    required this.seed,
  });

  final Seed seed;

  @override
  State<SeedItem> createState() => _SeedItemState();
}

class _SeedItemState extends State<SeedItem> {
  void _onRequestPublicKeys() {
    context
        .read<SeedVaultBloc>()
        .requestPublicKeys(widget.seed.authToken)
        .then((it) => showSnackBar(context, it.map((e) => e.join('\n\n'))));
  }

  void _onDeauthorize() {
    context.read<SeedVaultBloc>().deathorizeSeed(widget.seed.authToken);
  }

  void _onSignMessages() {
    context
        .read<SeedVaultBloc>()
        .signMessages(widget.seed.authToken)
        .then((it) => showSnackBar(context, it));
  }

  void _onSignTransactions() {
    context
        .read<SeedVaultBloc>()
        .signTransactions(widget.seed.authToken)
        .then((it) => showSnackBar(context, it));
  }

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text(
                widget.seed.name,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: _onDeauthorize,
                icon: const Icon(Icons.close, color: Colors.red),
              ),
            ],
          ),
          Text('Purpose: ${widget.seed.purpose}', style: _buttonStyle),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _onRequestPublicKeys,
            child: Text(
              'Get public keys for ${widget.seed.accounts.map((it) => it.derivationPath.toString()).join(' - ')}',
              textAlign: TextAlign.center,
              style: _buttonStyle,
            ),
          ),
          ElevatedButton(
            onPressed: _onSignTransactions,
            child: const Text(
              'Sign $_payloadCount transactions X $_keyCount keys',
              style: _buttonStyle,
            ),
          ),
          ElevatedButton(
            onPressed: _onSignMessages,
            child: const Text(
              'Sign $_payloadCount messages X $_keyCount keys',
              style: _buttonStyle,
            ),
          ),
          ExpansionTile(
            initiallyExpanded: false,
            title: const Text('Accounts marked as UserWallet'),
            children: [
              AccountList(
                authToken: widget.seed.authToken,
                accounts: widget.seed.accounts,
              ),
            ],
          ),
        ],
      );
}

const _payloadCount = 3;
const _keyCount = 3;

const _buttonStyle = TextStyle(fontSize: 18);
