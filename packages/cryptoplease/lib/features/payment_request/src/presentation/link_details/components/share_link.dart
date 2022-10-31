part of '../share_link.dart';

class ShareLink extends StatelessWidget {
  const ShareLink({
    Key? key,
    required this.paymentRequest,
  }) : super(key: key);

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

const _newLine = TextSpan(text: '\n\n');
