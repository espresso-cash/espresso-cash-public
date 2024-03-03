import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../di.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/app_bar.dart';
import '../../../ui/back_button.dart';
import '../../../ui/dialogs.dart';
import '../../../ui/tab_bar.dart';
import '../../../ui/text_button.dart';
import '../../../ui/theme.dart';
import '../data/repository.dart';
import '../models/payment_request.dart';
import '../widgets/share_link.dart';
import '../widgets/share_qr_code.dart';

class SharePaymentRequestScreen extends StatelessWidget {
  const SharePaymentRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final request = context.watch<PaymentRequest>();
    final title = Text(
      context.l10n.sharePaymentRequestTitle.toUpperCase(),
      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
    );

    return CpTheme.black(
      child: Scaffold(
        appBar: CpAppBar(
          title: title,
          leading: const CpBackButton(),
        ),
        body: DefaultTabController(
          length: 2,
          initialIndex: 0,
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                child: CpTabBar(
                  variant: CpTabBarVariant.black,
                  tabs: [
                    Tab(text: context.l10n.sharePaymentRequestLinkTitle),
                    Tab(text: context.l10n.sharePaymentRequestQrCodeTitle),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    ShareLink(paymentRequest: request),
                    ShareQrCode(paymentRequest: request),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.paddingOf(context).bottom + 24,
                ),
                child: CpTextButton(
                  text: context.l10n.paymentRequestCancel,
                  onPressed: () => showConfirmationDialog(
                    context,
                    title:
                        context.l10n.paymentRequest_lblCancelConfirmationTitle,
                    message: context
                        .l10n.paymentRequest_lblCancelConfirmationSubtitle,
                    onConfirm: () {
                      sl<PaymentRequestRepository>().delete(request.id);
                      context.pop();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
