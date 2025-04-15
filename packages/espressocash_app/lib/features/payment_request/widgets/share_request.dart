import 'package:flutter/material.dart';

import '../../../di.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/app_bar.dart';
import '../../../ui/back_button.dart';
import '../../../ui/colors.dart';
import '../../../ui/content_padding.dart';
import '../../../ui/dialogs.dart';
import '../../../ui/loader.dart';
import '../../../ui/rounded_rectangle.dart';
import '../../../ui/share_link.dart';
import '../../../ui/text_button.dart';
import '../../../ui/theme.dart';
import '../../conversion_rates/widgets/extensions.dart';
import '../../currency/models/amount.dart';
import '../../tokens/data/token_repository.dart';
import '../models/payment_request.dart';
import '../services/payment_request_service.dart';

class ShareRequestPayment extends StatefulWidget {
  const ShareRequestPayment({super.key, required this.request});

  final PaymentRequest request;

  @override
  State<ShareRequestPayment> createState() => _ShareRequestPaymentState();
}

class _ShareRequestPaymentState extends State<ShareRequestPayment> {
  late Future<CryptoAmount?> _cryptoAmountFuture;

  @override
  void initState() {
    super.initState();
    _cryptoAmountFuture = widget.request.payRequest.cryptoAmount(sl<TokenRepository>().getToken);
  }

  @override
  Widget build(BuildContext context) {
    final title = Text(
      context.l10n.requestPaymentTitle.toUpperCase(),
      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
    );

    return CpTheme.black(
      child: Scaffold(
        appBar: CpAppBar(title: title, leading: const CpBackButton()),
        body: SingleChildScrollView(
          child: IntrinsicHeight(
            child: Column(
              children: [
                CpContentPadding(
                  bottom: false,
                  child: CpRoundedRectangle(
                    backgroundColor: CpColors.blackGreyColor,
                    scrollable: false,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
                    child: Center(
                      child: Text(
                        context.l10n.requestPaymentPending,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: FutureBuilder(
                    future: _cryptoAmountFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 32.0),
                            child: LoadingIndicator(),
                          ),
                        );
                      }

                      if (snapshot.hasError) {
                        return const SizedBox.shrink();
                      }

                      final link = widget.request.shortLink ?? widget.request.dynamicLink;
                      final formattedAmount = snapshot.data?.formatWithFiat(context) ?? '';

                      final message = context.l10n.sharePaymentRequestLinkMessage(
                        formattedAmount,
                        link,
                      );

                      return ShareCodeWidget(
                        title: context.l10n.scanToSend,
                        amount: formattedAmount,
                        qrCode: widget.request.dynamicLink,
                        shareText: message,
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 24,
                    bottom: MediaQuery.paddingOf(context).bottom + 24,
                  ),
                  child: CpTextButton(
                    text: context.l10n.requestDeletePaymentTitle,
                    variant: CpTextButtonVariant.grey,
                    onPressed:
                        () => showConfirmationDialog(
                          context,
                          title:
                              context.l10n.paymentRequest_lblCancelConfirmationTitle.toUpperCase(),
                          message: context.l10n.paymentRequest_lblCancelConfirmationSubtitle,
                          onConfirm: () {
                            sl<PaymentRequestService>().cancel(widget.request.id);
                            Navigator.of(context).pop();
                          },
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
