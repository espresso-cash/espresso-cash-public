import 'package:cryptoplease/features/outgoing_transfer/bl/outgoing_payment.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:flutter/material.dart';

class ShareMessageHeader extends StatelessWidget {
  const ShareMessageHeader({
    Key? key,
    required this.amount,
    required this.tokenType,
  }) : super(key: key);

  final String amount;
  final OutgoingTransferTokenType tokenType;

  @override
  Widget build(BuildContext context) => Text.rich(
        tokenType != OutgoingTransferTokenType.fungibleToken
            ? TextSpan(text: context.l10n.shareIntroNft)
            : TextSpan(
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
