import 'package:cryptoplease/presentation/screens/authenticated/send_flow/fungible_token/confirm_screen/components/send_token_to_solana_address_content.dart';
import 'package:flutter/material.dart';

import '../../../utils.dart';

void main() {
  testGoldensWidget(
    'Send to address with small amount',
    const _Wrapper(
      child: SendTokenToSolanaAddressContent(
        amount: '1.25 SOL',
        fee: '0.01 SOL',
        address: 'GKvqsuNcnwWqPzzuhLmGi4rzzh55FhJtGizkhHaEJqiV',
        fiatAmount: '123.45 USD',
      ),
    ),
  );

  testGoldensWidget(
    'Send to address with large amount',
    const _Wrapper(
      child: SendTokenToSolanaAddressContent(
        amount: '1.284958673 SOL',
        fee: '0.01 SOL',
        address: 'GKvqsuNcnwWqPzzuhLmGi4rzzh55FhJtGizkhHaEJqiV',
        fiatAmount: '123.45 USD',
      ),
    ),
  );
}

class _Wrapper extends StatelessWidget {
  const _Wrapper({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(32),
          child: child,
        ),
      );
}
