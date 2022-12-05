import 'package:flutter/material.dart';
import 'package:share/share.dart';

import '../../../../core/amount.dart';
import '../../../../core/presentation/format_amount.dart';
import '../../../../core/presentation/utils.dart';
import '../../../../l10n/l10n.dart';
import '../../../../ui/app_bar.dart';
import '../../../../ui/button.dart';
import '../../../../ui/colors.dart';
import '../../../../ui/content_padding.dart';
import '../../../../ui/share_message/share_message_bubble.dart';
import '../../../../ui/share_message/share_message_header.dart';
import '../../../../ui/theme.dart';
import '../bl/outgoing_tip_payment.dart';

class ShareLinkScreen extends StatelessWidget {
  const ShareLinkScreen({
    Key? key,
    required this.amount,
    required this.status,
  }) : super(key: key);

  final CryptoAmount amount;
  final OutgoingTipLinkReady status;

  @override
  Widget build(BuildContext context) {
    final formattedAmount = amount.formatWithFiat(context);

    // final message = context.l10n.shareText(
    //   formattedAmount,
    //   status.link1,
    //   status.link2,
    // );
    const message = 'TODO'; //TODO

    final messageBubble = ShareMessageBubble(
      textSpan: TextSpan(
        children: [
          ShareMessageHeader(
            intro: context.l10n.shareIntroFt,
            amount: formattedAmount,
          ),
          const WidgetSpan(child: _Instructions()),
          WidgetSpan(
            child: _Link(link: status.link),
          ),
        ],
      ),
    );

    final title = Text(
      context.l10n.yourLinkIsReady.toUpperCase(),
      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
    );

    final subTitle = Text(
      context.l10n.linkSubtitle,
      textAlign: TextAlign.center,
      style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
    );

    final shareButton = CpButton(
      text: context.l10n.shareLink,
      width: double.infinity,
      size: CpButtonSize.big,
      onPressed: () => Share.share(message),
    );

    return CpTheme.dark(
      child: Scaffold(
        appBar: CpAppBar(title: title),
        body: CpContentPadding(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: subTitle,
              ),
              Flexible(child: messageBubble),
              const SizedBox(height: 24),
              shareButton,
            ],
          ),
        ),
      ),
    );
  }
}

class _Link extends StatelessWidget {
  const _Link({
    Key? key,
    required this.link,
  }) : super(key: key);

  final Uri link;

  @override
  Widget build(BuildContext context) => Text.rich(
        TextSpan(
          children: [
            TextSpan(text: context.l10n.shareStep1),
            _newLine,
            TextSpan(
              text: link.toString().withZeroWidthSpaces(),
              style: _linkStyle,
            ),
          ],
          style: _baseStyle,
        ),
      );
}

class _Instructions extends StatelessWidget {
  const _Instructions({Key? key}) : super(key: key);

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

final _linkStyle = _baseStyle.merge(
  const TextStyle(
    fontWeight: FontWeight.w600,
    color: CpColors.linkColor,
  ),
);

const _baseStyle = TextStyle(fontSize: 18);
