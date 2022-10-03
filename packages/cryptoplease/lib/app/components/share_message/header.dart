import 'package:cryptoplease/l10n/l10n.dart';
import 'package:flutter/material.dart';

class ShareMessageHeader extends StatelessWidget {
  const ShareMessageHeader({
    Key? key,
    required this.amount,
  }) : super(key: key);

  final String amount;

  @override
  Widget build(BuildContext context) => Text.rich(
        TextSpan(
          text: context.l10n.shareIntroFt,
          children: [
            TextSpan(
              text: amount,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
          style: const TextStyle(fontSize: 18, color: Colors.white),
        ),
      );
}
