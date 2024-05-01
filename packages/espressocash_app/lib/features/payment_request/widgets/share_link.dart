import 'package:flutter/material.dart';
import 'package:share/share.dart';

import '../../../l10n/l10n.dart';
import '../../../ui/button.dart';
import '../../../ui/colors.dart';
import '../../../ui/share_message/share_message_bubble.dart';
import '../../../ui/share_message/share_message_header.dart';
import '../../../utils/extensions.dart';
import '../../conversion_rates/widgets/extensions.dart';
import '../../currency/models/amount.dart';

class ShareLink extends StatelessWidget {
  const ShareLink({
    super.key,
    required this.amount,
    required this.link,
  });

  final CryptoAmount? amount;
  final String link;

  @override
  Widget build(BuildContext context) {
    final amount = this.amount?.formatWithFiat(context) ?? '';
    final message = context.l10n.sharePaymentRequestLinkMessage(
      amount,
      link,
    );

    final shareButton = CpButton(
      text: context.l10n.share,
      width: double.infinity,
      size: CpButtonSize.big,
      onPressed: () => Share.share(message),
    );

    final messageBubble = ShareMessageBubble(
      backgroundColor: Colors.black,
      textSpan: TextSpan(
        children: [
          ShareMessageHeader(
            intro: context.l10n.sharePaymentRequestLinkIntro,
            amount: amount,
          ),
          const WidgetSpan(child: _Instructions()),
          WidgetSpan(child: _Link(link: link)),
        ],
      ),
    );

    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
      child: Column(
        children: [
          Flexible(child: messageBubble),
          shareButton,
        ],
      ),
    );
  }
}

class _Instructions extends StatelessWidget {
  const _Instructions();

  @override
  Widget build(BuildContext context) => Text.rich(
        TextSpan(
          children: [
            _newLine,
            TextSpan(text: context.l10n.sharePaymentRequestLinkInstructions),
            // ignore: avoid-duplicate-collection-elements, intended duplication
            _newLine,
          ],
          style: const TextStyle(fontSize: 18),
        ),
      );
}

class _Link extends StatelessWidget {
  const _Link({required this.link});

  final String link;

  @override
  Widget build(BuildContext context) => Text.rich(
        TextSpan(
          text: link.withZeroWidthSpaces(),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: CpColors.yellowColor,
          ),
        ),
      );
}

const _newLine = TextSpan(text: '\n\n');
