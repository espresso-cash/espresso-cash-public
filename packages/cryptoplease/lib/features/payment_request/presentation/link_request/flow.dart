import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/app/components/dialogs.dart';
import 'package:cryptoplease/app/routes.dart';
import 'package:cryptoplease/core/accounts/bl/account.dart';
import 'package:cryptoplease/core/amount.dart';
import 'package:cryptoplease/core/balances/bl/balances_bloc.dart';
import 'package:cryptoplease/core/conversion_rates/bl/repository.dart';
import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease/core/user_preferences.dart';
import 'package:cryptoplease/di.dart';
import 'package:cryptoplease/features/payment_request/bl/create_payment_request/bloc.dart';
import 'package:cryptoplease/features/payment_request/bl/repository.dart';
import 'package:cryptoplease/features/payment_request/presentation/link_details/flow.dart';
import 'package:cryptoplease/features/payment_request/presentation/link_request/payer_name_screen.dart';
import 'package:cryptoplease/features/payment_request/presentation/link_request/request_amount_screen.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class LinkRequestFlowScreen extends StatefulWidget {
  const LinkRequestFlowScreen({
    Key? key,
    required this.initialToken,
    this.initialAmount,
  }) : super(key: key);

  final Token? initialToken;
  final CryptoAmount? initialAmount;

  @override
  State<LinkRequestFlowScreen> createState() => _LinkRequestFlowScreenState();
}

class _LinkRequestFlowScreenState extends State<LinkRequestFlowScreen> {
  late final CreatePaymentRequestBloc paymentRequestBloc;

  @override
  void initState() {
    super.initState();
    final amount = widget.initialAmount;
    final token = amount?.token ?? widget.initialToken;

    paymentRequestBloc = CreatePaymentRequestBloc(
      balances: context.read<BalancesBloc>().state.balances,
      userCurrency: context.read<UserPreferences>().fiatCurrency,
      initialToken: token,
      repository: sl<PaymentRequestRepository>(),
      conversionRatesRepository: sl<ConversionRatesRepository>(),
    );

    if (amount != null) {
      paymentRequestBloc.add(
        CreatePaymentRequestEvent.tokenAmountUpdated(
          amount.decimal,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) =>
      Provider<CreatePaymentRequestBloc>.value(
        value: paymentRequestBloc,
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

    final state = context.read<CreatePaymentRequestBloc>().state;

    if (state.tokenAmount.value != 0) {
      onAmountSubmitted();
    } else {
      context.navigateTo(const RequestAmountRoute());
    }
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
