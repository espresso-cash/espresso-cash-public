import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solana_mobile_wallet_example/mobile_wallet/bloc.dart';

class SendTransactionsScreen extends StatelessWidget {
  const SendTransactionsScreen({
    super.key,
    required this.request,
  });

  final SendTransactions request;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sign transaction(s)',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              'Cluster: testnet',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(40),
              ),
              onPressed: () => context
                  .read<MobileWalletBloc>()
                  .signAndSendTransactionsSubmitted(),
              child: const Text('Simulate submitted'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(40),
              ),
              onPressed: () => context
                  .read<MobileWalletBloc>()
                  .signAndSendTransactionsNotSubmitted(),
              child: const Text('Simulate submit failed'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(40),
              ),
              onPressed: () => context
                  .read<MobileWalletBloc>()
                  .signAndSendTransactionsSend(),
              child: const Text('Send transaction to cluster'),
            ),
          ],
        ),
      );
}
