import 'package:flutter/material.dart';
import 'package:share/share.dart';

import '../../../../../../core/presentation/utils.dart';
import '../../../../../../l10n/l10n.dart';
import '../../../../../../ui/button.dart';
import '../../../../../../ui/colors.dart';
import '../../../../../../ui/share_message/share_message_bubble.dart';
import '../../../../../../ui/share_message/share_message_header.dart';

class ShareLink extends StatelessWidget {
  const ShareLink({
    Key? key,
    required this.amount,
    required this.link,
  }) : super(key: key);

  final String? amount;
  final String link;

  @override
  Widget build(BuildContext context) {
    final amount = this.amount ?? '';
    final message = context.l10n.sharePaymentRequestLinkMessage(amount, link);

    final shareButton = CpButton(
      text: context.l10n.share,
      width: double.infinity,
      size: CpButtonSize.big,
      onPressed: () => Share.share(message),
    );

    final messageBubble = ShareMessageBubble(
      textSpan: TextSpan(
        children: [
          ShareMessageHeader(
            intro: context.l10n.sharePaymentRequestLinkIntro,
            amount: amount,
          ),
          const WidgetSpan(child: _Instructions()),
          WidgetSpan(child: _Links(link: link)),
        ],
      ),
    );

    return Column(
      children: [
        _Subtitle(text: context.l10n.sharePaymentRequestLinkDescription),
        Flexible(child: messageBubble),
        shareButton,
      ],
    );
  }
}

class _Instructions extends StatelessWidget {
  const _Instructions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Text.rich(
        TextSpan(
          children: [
            _newLine,
            TextSpan(text: context.l10n.sharePaymentRequestLinkInstructions),
            _newLine,
          ],
          style: const TextStyle(fontSize: 18),
        ),
      );
}

class _Links extends StatelessWidget {
  const _Links({
    Key? key,
    required this.link,
  }) : super(key: key);

  final String link;

  @override
  Widget build(BuildContext context) => Text.rich(
        TextSpan(
          text: link.withZeroWidthSpaces(),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: CpColors.linkColor,
          ),
        ),
      );
}

class _Subtitle extends StatelessWidget {
  const _Subtitle({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
        ),
      );
}

const _newLine = TextSpan(text: '\n\n');
