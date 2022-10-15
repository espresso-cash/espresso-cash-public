import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/app/components/tx_result_screen.dart';
import 'package:cryptoplease/app/routes.dart';
import 'package:cryptoplease/core/presentation/format_amount.dart';
import 'package:cryptoplease/di.dart';
import 'package:cryptoplease/features/payment_request/bl/payment_request.dart';
import 'package:cryptoplease/features/payment_request/bl/payment_request_verifier/bloc.dart';
import 'package:cryptoplease/features/payment_request/bl/repository.dart';
import 'package:cryptoplease/gen/assets.gen.dart';
import 'package:cryptoplease/l10n/device_locale.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

extension LinkDetailsFlowExt on BuildContext {
  void navigateToPaymentRequest(String id) =>
      navigateTo(LinkDetailsFlowRoute(id: id));
}

class LinkDetailsFlowScreen extends StatefulWidget {
  const LinkDetailsFlowScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  final String id;

  @override
  State<LinkDetailsFlowScreen> createState() => _LinkDetailsFlowScreenState();
}

class _LinkDetailsFlowScreenState extends State<LinkDetailsFlowScreen> {
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
          if (data == null) return const _Loader();

          return data.state.when(
            initial: () => BlocProvider<PaymentRequestVerifierBloc>(
              create: (_) => sl<PaymentRequestVerifierBloc>(param1: data),
              lazy: false,
              child: Provider<PaymentRequest>.value(
                value: data,
                child: const AutoRouter(),
              ),
            ),
            completed: (_) => _Success(request: data),
            failure: () => _Failure(request: data),
          );
        },
      );
}

class _Loader extends StatelessWidget {
  const _Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: CpAppBar(
          leading: BackButton(onPressed: () => context.router.pop()),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
}

class _Success extends StatelessWidget {
  const _Success({
    Key? key,
    required this.request,
  }) : super(key: key);

  final PaymentRequest request;

  @override
  Widget build(BuildContext context) => TxResultScreen(
        icon: Assets.icons.txSucceeded,
        text: context.l10n.paymentRequestSuccessNotificationTitle(
          request.formattedAmount(DeviceLocale.localeOf(context)),
          request.payerName,
        ),
        signature: null,
      );
}

class _Failure extends StatelessWidget {
  const _Failure({
    Key? key,
    required this.request,
  }) : super(key: key);

  final PaymentRequest request;

  @override
  Widget build(BuildContext context) => TxResultScreen(
        icon: Assets.icons.txFailed,
        text: context.l10n.paymentRequestFailureNotificationTitle(
          request.formattedAmount(DeviceLocale.localeOf(context)),
          request.payerName,
        ),
        signature: null,
      );
}
