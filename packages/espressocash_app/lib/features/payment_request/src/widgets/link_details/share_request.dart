import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../di.dart';
import '../../../../../l10n/l10n.dart';
import '../../../../../ui/app_bar.dart';
import '../../../../../ui/back_button.dart';
import '../../../../../ui/dialogs.dart';
import '../../../../../ui/tab_bar.dart';
import '../../../../../ui/text_button.dart';
import '../../../../../ui/theme.dart';
import '../../../models/payment_request.dart';
import '../../bl/repository.dart';
import 'components/share_link.dart';
import 'components/share_qr_code.dart';

@RoutePage()
class SharePaymentRequestScreen extends StatelessWidget {
  const SharePaymentRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final request = context.watch<PaymentRequest>();
    final title = Text(
      context.l10n.sharePaymentRequestTitle.toUpperCase(),
      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
    );

    return CpTheme.dark(
      child: Scaffold(
        appBar: CpAppBar(
          title: title,
          leading: CpBackButton(onPressed: () => context.router.pop()),
        ),
        body: DefaultTabController(
          length: 2,
          initialIndex: 0,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(48, 32, 48, 16),
                child: CpTabBar(
                  variant: CpTabBarVariant.inverted,
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
                  bottom: MediaQuery.of(context).padding.bottom + 24,
                ),
                child: CpTextButton(
                  text: context.l10n.paymentRequestCancel,
                  onPressed: () => showConfirmationDialog(
                    context,
                    title: context.l10n.cancelPaymentRequestConfirmationTitle,
                    message:
                        context.l10n.cancelPaymentRequestConfirmationSubtitle,
                    onConfirm: () {
                      sl<PaymentRequestRepository>().delete(request.id);
                      context.router.pop();
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
