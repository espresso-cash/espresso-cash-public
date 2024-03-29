import 'package:flutter/material.dart';
import 'package:share/share.dart';

import '../../../di.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/button.dart';
import '../../../ui/colors.dart';
import '../../../ui/share_message/share_message_bubble.dart';
import '../../../ui/share_message/share_message_header.dart';
import '../../../utils/extensions.dart';
import '../../conversion_rates/widgets/extensions.dart';
import '../../tokens/token_list.dart';
import '../models/payment_request.dart';

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
      backgroundColor: Colors.black,
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

const _newLine = TextSpan(text: '\n\n');
