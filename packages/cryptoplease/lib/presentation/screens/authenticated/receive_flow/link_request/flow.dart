import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/bl/accounts/account.dart';
import 'package:cryptoplease/bl/balances/balances_bloc.dart';
import 'package:cryptoplease/bl/conversion_rates/repository.dart';
import 'package:cryptoplease/bl/payment_requests/create_payment_request/bloc.dart';
import 'package:cryptoplease/bl/payment_requests/repository.dart';
import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:cryptoplease/bl/user_preferences.dart';
import 'package:cryptoplease/presentation/dialogs.dart';
import 'package:cryptoplease/presentation/routes.dart';
import 'package:cryptoplease/presentation/screens/authenticated/receive_flow/link_details/flow.dart';
import 'package:cryptoplease/presentation/screens/authenticated/receive_flow/link_request/payer_name_screen.dart';
import 'package:cryptoplease/presentation/screens/authenticated/receive_flow/link_request/request_amount_screen.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class LinkRequestFlowScreen extends StatefulWidget {
  const LinkRequestFlowScreen({
    Key? key,
    required this.initialToken,
  }) : super(key: key);

  final Token? initialToken;

  @override
  State<LinkRequestFlowScreen> createState() => _LinkRequestFlowScreenState();
}

class _LinkRequestFlowScreenState extends State<LinkRequestFlowScreen> {
  @override
  Widget build(BuildContext context) => BlocProvider<CreatePaymentRequestBloc>(
        create: (context) => CreatePaymentRequestBloc(
          balances: context.read<BalancesBloc>().state.balances,
          userCurrency: context.read<UserPreferences>().fiatCurrency,
          initialToken: widget.initialToken,
          repository: context.read<PaymentRequestRepository>(),
          conversionRatesRepository: context.read<ConversionRatesRepository>(),
        ),
        child: const _Content(),
      );
}

class _Content extends StatefulWidget {
  const _Content({Key? key}) : super(key: key);

  @override
  State<_Content> createState() => _ContentState();
}

class _ContentState extends State<_Content>
    implements PayerNameSetter, RequestAmountSetter {
  @override
  void onAmountSubmitted() {
    final event = CreatePaymentRequestEvent.submitted(
      recipient: context.read<MyAccount>().wallet.publicKey,
    );
    context.read<CreatePaymentRequestBloc>().add(event);
  }

  @override
  void onPayerNameSubmitted(String name) {
    context
        .read<CreatePaymentRequestBloc>()
        .add(CreatePaymentRequestEvent.payerNameUpdated(name));
    context.navigateTo(const RequestAmountRoute());
  }

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          Provider<PayerNameSetter>.value(value: this),
          Provider<RequestAmountSetter>.value(value: this),
        ],
        child:
            BlocConsumer<CreatePaymentRequestBloc, CreatePaymentRequestState>(
          listenWhen: (s1, s2) => s1.flow != s2.flow,
          listener: (context, state) => state.flow.maybeWhen(
            failure: (error) => showErrorDialog(
              context,
              'Failed to send money',
              error,
            ),
            success: (request) {
              context.router.popUntilRoot();
              context.navigateToPaymentRequest(request.id);
            },
            orElse: ignore,
          ),
          builder: (context, state) => CpLoader(
            isLoading: state.flow.isProcessing(),
            child: const AutoRouter(),
          ),
          buildWhen: (s1, s2) => s1.flow != s2.flow,
        ),
      );
}
