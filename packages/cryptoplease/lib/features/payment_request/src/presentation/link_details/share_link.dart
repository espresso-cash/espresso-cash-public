import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share/share.dart';

import '../../../../../core/presentation/format_amount.dart';
import '../../../../../core/presentation/utils.dart';
import '../../../../../core/tokens/token_list.dart';
import '../../../../../di.dart';
import '../../../../../l10n/l10n.dart';
import '../../../../../ui/app_bar.dart';
import '../../../../../ui/button.dart';
import '../../../../../ui/colors.dart';
import '../../../../../ui/content_padding.dart';
import '../../../../../ui/rounded_rectangle.dart';
import '../../../../../ui/share_message/share_message_bubble.dart';
import '../../../../../ui/share_message/share_message_header.dart';
import '../../../../../ui/tab_bar.dart';
import '../../../../../ui/theme.dart';
import '../../bl/payment_request.dart';

part 'components/share_link.dart';
part 'components/share_qr_code.dart';

class SharePaymentRequestLinkScreen extends StatelessWidget {
  const SharePaymentRequestLinkScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final request = context.watch<PaymentRequest>();
    final title = Text(
      context.l10n.sharePaymentRequestLinkTitle.toUpperCase(),
      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
    );

    return CpTheme.dark(
      child: Scaffold(
        appBar: CpAppBar(
          title: title,
          leading: BackButton(onPressed: () => context.router.pop()),
        ),
        body: DefaultTabController(
          length: 2,
          initialIndex: 0,
          child: CpContentPadding(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(24, 8, 24, 16),
                  child: CpTabBar(
                    variant: CpTabBarVariant.inverted,
                    tabs: [
                      Tab(text: 'Share Link'),
                      Tab(text: 'Share QR Code'),
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
                // Flexible(child: messageBubble),
                // const SizedBox(height: 24),
                // shareButton,
              ],
            ),
          ),
        ),
      ),
    );
  }
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
