import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../di.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/app_bar.dart';
import '../../../ui/back_button.dart';
import '../../../ui/loader.dart';
import '../../../ui/tab_bar.dart';
import '../../../ui/theme.dart';
import '../../authenticated/authenticated_navigator_key.dart';
import '../../tokens/token_list.dart';
import '../data/repository.dart';
import '../models/payment_request.dart';
import '../widgets/invoice.dart';
import '../widgets/share_link.dart';
import '../widgets/share_qr_code.dart';

class SharePaymentRequestScreen extends StatefulWidget {
  const SharePaymentRequestScreen({
    super.key,
    required this.id,
  });

  final String id;

  @override
  State<SharePaymentRequestScreen> createState() =>
      _SharePaymentRequestScreenState();
}

class _SharePaymentRequestScreenState extends State<SharePaymentRequestScreen> {
  late final Stream<PaymentRequest> _stream;

  @override
  void initState() {
    super.initState();
    _stream = sl<PaymentRequestRepository>().watchById(widget.id);
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<PaymentRequest>(
        stream: _stream,
        builder: (context, snapshot) {
          final data = snapshot.data;

          return data == null
              ? const LoadingIndicator()
              : SharePaymentRequestContent(request: data);
        },
      );
}

class SharePaymentRequestContent extends StatelessWidget {
  const SharePaymentRequestContent({
    super.key,
    required this.request,
  });

  final PaymentRequest request;

  @override
  Widget build(BuildContext context) {
    final title = Text(
      context.l10n.requestPaymentTitle.toUpperCase(),
      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
    );

    final tokenList = sl<TokenList>();
    final amount = request.payRequest.cryptoAmount(tokenList);

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
                    ShareLink(amount: amount, link: request.shortLink),
                    ShareQrCode(amount: amount, link: request.dynamicLink),
                  ],
                ),
              ),
              _Footer(request: request),
            ],
          ),
        ),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer({required this.request});

  final PaymentRequest request;

  @override
  Widget build(BuildContext context) {
    final status = switch (request.state) {
      PaymentRequestState.initial => context.l10n.notReceived,
      PaymentRequestState.completed => context.l10n.received,
      PaymentRequestState.error => context.l10n.failed,
    };

    return DefaultTextStyle(
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: 16,
          bottom: MediaQuery.paddingOf(context).bottom + 24,
        ),
        child: Column(
          children: [
            Text(context.l10n.requestPaymentStatus(status)),
            const SizedBox(height: 4),
            if (request.payRequest.invoice case final reference?)
              InvoiceTextWidget(reference: reference),
          ],
        ),
      ),
    );
  }
}

class SharePaymentRequestRoute extends GoRouteData {
  const SharePaymentRequestRoute(this.id);

  final String id;

  static final GlobalKey<NavigatorState> $parentNavigatorKey =
      authenticatedNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      SharePaymentRequestScreen(
        id: id,
      );
}
