import 'package:espressocash_common/espressocash_common.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

import '../../../core/presentation/format_amount.dart';
import '../../../core/presentation/utils.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/button.dart';
import '../../../ui/colors.dart';
import '../../../ui/share_message/share_message_bubble.dart';
import '../../../ui/share_message/share_message_header.dart';
import '../models/outgoing_link_payment.dart';

class ShareLink extends StatelessWidget {
  const ShareLink({
    super.key,
    required this.status,
    required this.amount,
  });

  final CryptoAmount amount;
  final OLPStatusLinkReady status;

  @override
  Widget build(BuildContext context) {
    final formattedAmount = amount.formatWithFiat(context);

    final message = context.l10n.shareText(
      formattedAmount,
      status.link,
    );

    final messageBubble = ShareMessageBubble(
      backgroundColor: Colors.black,
      textSpan: TextSpan(
        children: [
          ShareMessageHeader(
            intro: context.l10n.shareIntroFt,
            amount: formattedAmount,
          ),
          const WidgetSpan(child: _Instructions()),
          WidgetSpan(child: _Link(link: status.link)),
        ],
      ),
    );

    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
      child: Column(
        children: [
          Flexible(
            flex: 4,
            child: messageBubble,
          ),
          const SizedBox(height: 24),
          const Spacer(),
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

class _Link extends StatelessWidget {
  const _Link({required this.link});

  final Uri link;

  @override
  Widget build(BuildContext context) => Text.rich(
        TextSpan(
          children: [
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
  const _Instructions();

  @override
  Widget build(BuildContext context) => Text.rich(
        TextSpan(
          children: [
            _newLine,
            TextSpan(text: context.l10n.shareInstructions),
            // ignore: avoid-duplicate-collection-elements, intended duplication
            _newLine,
          ],
          style: _baseStyle,
        ),
      );
}

const _newLine = TextSpan(text: '\n');

const _baseStyle = TextStyle(fontSize: 18);

final _linkStyle = _baseStyle.merge(
  const TextStyle(
    fontWeight: FontWeight.w600,
    color: CpColors.yellowColor,
  ),
);
