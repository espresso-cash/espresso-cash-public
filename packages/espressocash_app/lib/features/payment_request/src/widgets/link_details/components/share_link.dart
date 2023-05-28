import 'package:flutter/material.dart';
import 'package:share/share.dart';

import '../../../../../../core/presentation/format_amount.dart';
import '../../../../../../core/presentation/utils.dart';
import '../../../../../../core/tokens/token_list.dart';
import '../../../../../../di.dart';
import '../../../../../../l10n/l10n.dart';
import '../../../../../../ui/button.dart';
import '../../../../../../ui/colors.dart';
import '../../../../../../ui/share_message/share_message_bubble.dart';
import '../../../../../../ui/share_message/share_message_header.dart';
import '../../../../models/payment_request.dart';

class ShareLink extends StatelessWidget {
  const ShareLink({
    super.key,
    required this.paymentRequest,
  });

  final PaymentRequest paymentRequest;

  @override
  Widget build(BuildContext context) {
    final tokenlist = sl<TokenList>();

    final amount = paymentRequest.payRequest
            .cryptoAmount(tokenlist)
            ?.formatWithFiat(context) ??
        '';

    final message = context.l10n.sharePaymentRequestLinkMessage(
      amount,
      paymentRequest.dynamicLink,
    );

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
          WidgetSpan(child: _Links(link: paymentRequest.dynamicLink)),
        ],
      ),
    );

    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
      child: Column(
        children: [
          _Subtitle(text: context.l10n.sharePaymentRequestLinkDescription),
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
            _newLine,
          ],
          style: const TextStyle(fontSize: 18),
        ),
      );
}

class _Links extends StatelessWidget {
  const _Links({required this.link});

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

class _Subtitle extends StatelessWidget {
  const _Subtitle({required this.text});

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
