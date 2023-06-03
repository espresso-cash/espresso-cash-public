import 'package:collection/collection.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solana_seed_vault/solana_seed_vault.dart';
import 'package:wallet_example/bl/bloc.dart';
import 'package:wallet_example/presentation/snack_bar.dart';

class LimitsSection extends StatefulWidget {
  const LimitsSection({super.key});

  @override
  State<LimitsSection> createState() => _LimitsSectionState();
}

class _LimitsSectionState extends State<LimitsSection> {
  AuthToken? _validate() {
    final seed = context
        .read<SeedVaultBloc>()
        .state
        .mapOrNull(loaded: (state) => state.seeds.firstOrNull);

    if (seed == null) {
      showErrorSnackBar(context, 'Need authorized seed to exceed limits');
    }

    return seed?.authToken;
  }

  void _onMaxRequestedPublicKeysExceeded() => _validate()?.let(
        (authToken) => context
            .read<SeedVaultBloc>()
            .exceedMaxRequestedPublicKeys(authToken)
            .then((it) => showSnackBar(context, it.map((e) => e.join('\n\n')))),
      );

  void _onMaxSigningRequestsExceeded() => _validate()?.let(
        (authToken) => context
            .read<SeedVaultBloc>()
            .exceedMaxSigningRequests(authToken)
            .then((it) => showSnackBar(context, it)),
      );

  void _onMaxRequestedSignaturesExceeded() => _validate()?.let(
        (authToken) => context
            .read<SeedVaultBloc>()
            .exceedMaxRequestedSignatures(authToken)
            .then((it) => showSnackBar(context, it)),
      );

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<SeedVaultBloc, SeedVaultState>(
        builder: (context, state) => state.maybeMap(
          orElse: () => const SizedBox.shrink(),
          loaded: (state) => ExpansionTile(
            initiallyExpanded: false,
            title: const Text('Implementation Limits', style: _style),
            children: [
              _LimitTile(
                title:
                    'maxRequestedPublicKeys=${state.limits.maxRequestedPublicKeys}',
                onExceeded: _onMaxRequestedPublicKeysExceeded,
              ),
              _LimitTile(
                title: 'maxSigningRequests=${state.limits.maxSigningRequests}',
                onExceeded: _onMaxSigningRequestsExceeded,
              ),
              _LimitTile(
                title:
                    'maxRequestedSignatures=${state.limits.maxRequestedSignatures}',
                onExceeded: _onMaxRequestedSignaturesExceeded,
              ),
              _LimitTile(
                title: 'maxBip32PathDepth=${state.limits.maxBip32PathDepth}',
              ),
            ],
          ),
        ),
      );
}

class _LimitTile extends StatelessWidget {
  const _LimitTile({
    required this.title,
    this.onExceeded,
  });

  final String title;
  final VoidCallback? onExceeded;

  @override
  Widget build(BuildContext context) => ListTile(
        title: Text(title, style: const TextStyle(fontSize: 18)),
        subtitle: onExceeded == null
            ? const SizedBox.shrink()
            : ElevatedButton(
                onPressed: onExceeded,
                child: const Text('Exceed limit by 1'),
              ),
      );
}

const _style = TextStyle(fontSize: 14);
