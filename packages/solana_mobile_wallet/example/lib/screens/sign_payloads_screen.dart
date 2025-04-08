import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solana_mobile_wallet/solana_mobile_wallet.dart';
import 'package:solana_mobile_wallet_example/mobile_wallet/bloc.dart';

class SignPayloadsScreen extends StatelessWidget {
  const SignPayloadsScreen({super.key, required this.request});

  final SignPayloadsRequest request;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Sign transaction(s)', style: Theme.of(context).textTheme.titleLarge),
        Text(
          'Num payloads: ${request.payloads.length}',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () => context.read<MobileWalletBloc>().signPayloadsSimulateSign(),
              child: const Text('Authorize'),
            ),
            ElevatedButton(
              onPressed: () => context.read<MobileWalletBloc>().signPayloadsDeclined(),
              child: const Text('Decline'),
            ),
          ],
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(40)),
          onPressed: () => context.read<MobileWalletBloc>().signPayloadsSimulateAuthTokenInvalid(),
          child: const Text('Simulate auth token invalid'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(40)),
          onPressed: () => context.read<MobileWalletBloc>().signPayloadsSimulateInvalidPayloads(),
          child: const Text('Simulate first payload invalid'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(40)),
          onPressed: () => context.read<MobileWalletBloc>().signPayloadsSimulateTooManyPayloads(),
          child: const Text('Simulate too many payloads'),
        ),
      ],
    ),
  );
}
