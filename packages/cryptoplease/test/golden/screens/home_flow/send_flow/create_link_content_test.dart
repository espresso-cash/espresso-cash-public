import 'package:cryptoplease/presentation/screens/authenticated/send_flow/fungible_token/confirm_screen/components/token_create_link_content.dart';
import 'package:flutter/material.dart';

import '../../../utils.dart';

void main() {
  testGoldensWidget(
    'Create link with small amount',
    const _Wrapper(
      child: TokenCreateLinkContent(
        amount: '1.25 SOL',
        fee: '0.01 SOL',
        fiatAmount: '123.45 USD',
      ),
    ),
  );

  testGoldensWidget(
    'Create link with large amount',
    const _Wrapper(
      child: TokenCreateLinkContent(
        amount: '1.284958673 SOL',
        fee: '0.01 SOL',
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
