import 'package:flutter/material.dart';
import 'package:share/share.dart';

import '../../../../../core/amount.dart';
import '../../../../../core/presentation/format_amount.dart';
import '../../../../../core/presentation/utils.dart';
import '../../../../../l10n/l10n.dart';
import '../../../../../ui/button.dart';
import '../../../../../ui/colors.dart';
import '../../../../../ui/share_message/share_message_bubble.dart';
import '../../../../../ui/share_message/share_message_header.dart';
import '../../../models/outgoing_split_key_payment.dart';

class ShareLinks extends StatelessWidget {
  const ShareLinks({
    super.key,
    required this.status,
    required this.amount,
  });

  final CryptoAmount amount;
  final OSKPStatusLinksReady status;

  @override
  Widget build(BuildContext context) {
    final formattedAmount = amount.formatWithFiat(context);

    final message = context.l10n.shareText(
      formattedAmount,
      status.link1,
      status.link2,
    );

    final messageBubble = ShareMessageBubble(
      textSpan: TextSpan(
        children: [
          ShareMessageHeader(
            intro: context.l10n.shareIntroFt,
            amount: formattedAmount,
          ),
          const WidgetSpan(child: _Instructions()),
          WidgetSpan(
            child: _Links(firstLink: status.link1, secondLink: status.link2),
          ),
        ],
      ),
    );

    final subTitle = Text(
      context.l10n.linkSubtitle,
      textAlign: TextAlign.center,
      style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
    );

    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: subTitle,
          ),
          Flexible(child: messageBubble),
          const SizedBox(height: 24),
          CpButton(
            text: context.l10n.shareLink,
            width: double.infinity,
            size: CpButtonSize.big,
            onPressed: () => Share.share(message),
          ),
        ],
      ),
    );
  }
}

class _Links extends StatelessWidget {
  const _Links({
    required this.firstLink,
    required this.secondLink,
  });

  final Uri firstLink;
  final Uri secondLink;

  @override
  Widget build(BuildContext context) => Text.rich(
        TextSpan(
          children: [
            TextSpan(text: context.l10n.shareStep1),
            _newLine,
            TextSpan(
              text: firstLink.toString().withZeroWidthSpaces(),
              style: _linkStyle,
            ),
            _newLine,
            TextSpan(text: context.l10n.shareStep2),
            _newLine,
            TextSpan(
              text: secondLink.toString().withZeroWidthSpaces(),
              style: _linkStyle,
            ),
          ],
          style: _baseStyle,
        ),
      );
}

class _Instructions extends StatelessWidget {
  const _Instructions();

  @override
  Widget build(BuildContext context) => Text.rich(
        TextSpan(
          children: [
            _newLine,
            TextSpan(text: context.l10n.shareInstructions),
            _newLine,
          ],
          style: _baseStyle,
        ),
      );
}

const _newLine = TextSpan(text: '\n\n');

const _baseStyle = TextStyle(fontSize: 18);

final _linkStyle = _baseStyle.merge(
  const TextStyle(
    fontWeight: FontWeight.w600,
    color: CpColors.yellowColor,
  ),
);
