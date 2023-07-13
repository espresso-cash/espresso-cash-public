import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../ui/app_bar.dart';
import '../../../../ui/bordered_row.dart';
import '../../../../ui/button.dart';
import '../../../../ui/theme.dart';

@RoutePage<bool?>()
class OffRampConfirmationScreen extends StatelessWidget {
  const OffRampConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return CpTheme.dark(
      child: Scaffold(
        appBar: CpAppBar(
          title: const Text('Approve Transaction'),
        ),
        body: Column(
          children: [
            const CpBorderedRow(
              title: Text('Provider'),
              content: BorderedRowChip(
                child: Text('CoinFlow', style: _textStyle),
              ),
            ),
            const Spacer(),
            const SizedBox(height: 21),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: CpButton(
                text: 'Approve',
                minWidth: width,
                onPressed: () => context.router.pop(true),
                size: CpButtonSize.big,
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

const _textStyle = TextStyle(
  fontSize: 17,
  fontWeight: FontWeight.w500,
);
