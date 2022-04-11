import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/bl/payment_requests/payment_request.dart';
import 'package:cryptoplease/bl/tokens/token_list.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/components/decorated_window.dart';
import 'package:cryptoplease/presentation/components/share_message_wrapper.dart';
import 'package:cryptoplease/presentation/format_amount.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class SharePaymentRequestLinkScreen extends StatelessWidget {
  const SharePaymentRequestLinkScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final request = context.watch<PaymentRequest>();
    final formattedAmount =
        request.payRequest.cryptoAmount(TokenList())?.formatWithFiat(context) ??
            '';

    final message = context.l10n.sharePaymentRequestLinkMessage(
      formattedAmount,
      request.dynamicLink,
    );

    return DecoratedWindow(
      backgroundStyle: BackgroundStyle.gradient,
      isScrollable: false,
      title: context.l10n.sharePaymentRequestLinkTitle,
      message: context.l10n.sharePaymentRequestLinkDescription,
      backButton: BackButton(onPressed: () => context.router.pop()),
      bottomButton: CpBottomButton(
        text: context.l10n.share,
        onPressed: () => Share.share(message),
      ),
      child: ShareMessageWrapper(message: message),
    );
  }
}
