import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_example/bl/bloc.dart';

class LimitsSection extends StatefulWidget {
  const LimitsSection({Key? key}) : super(key: key);

  @override
  State<LimitsSection> createState() => _LimitsSectionState();
}

class _LimitsSectionState extends State<LimitsSection> {
  void _onMaxRequestedPublicKeysExceeded() {}
  void _onMaxSigningRequestsExceeded() {}
  void _onMaxBip32PathDepthExceeded() {}
  void _onMaxRequestedSignaturesExceeded() {}

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
                onExceeded: _onMaxBip32PathDepthExceeded,
              ),
            ],
          ),
        ),
      );
}

class _LimitTile extends StatelessWidget {
  const _LimitTile({
    Key? key,
    required this.title,
    required this.onExceeded,
  }) : super(key: key);

  final String title;
  final VoidCallback onExceeded;

  @override
  Widget build(BuildContext context) => ListTile(
        title: Text(title, style: const TextStyle(fontSize: 18)),
        subtitle: ElevatedButton(
          onPressed: onExceeded,
          child: const Text('Exceed limit by 1'),
        ),
      );
}

const _style = TextStyle(fontSize: 14);
