import 'package:auto_route/auto_route.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../../../core/accounts/bl/account.dart';
import '../../../../../core/amount.dart';
import '../../../../../core/conversion_rates/bl/repository.dart';
import '../../../../../core/user_preferences.dart';
import '../../../../../di.dart';
import '../../../../../routes.gr.dart';
import '../../../../../ui/dialogs.dart';
import '../../../../../ui/loader.dart';
import '../../bl/create_payment_request/bloc.dart';
import '../../bl/repository.dart';
import 'request_note_screen.dart';

class LinkRequestFlowScreen extends StatefulWidget {
  const LinkRequestFlowScreen({
    Key? key,
    required this.initialAmount,
  }) : super(key: key);

  final CryptoAmount initialAmount;

  @override
  State<LinkRequestFlowScreen> createState() => _LinkRequestFlowScreenState();
}

class _LinkRequestFlowScreenState extends State<LinkRequestFlowScreen> {
  late final CreatePaymentRequestBloc paymentRequestBloc;

  @override
  void initState() {
    super.initState();
    final amount = widget.initialAmount;

    paymentRequestBloc = CreatePaymentRequestBloc(
      userCurrency: context.read<UserPreferences>().fiatCurrency,
      repository: sl<PaymentRequestRepository>(),
      conversionRatesRepository: sl<ConversionRatesRepository>(),
    );

    paymentRequestBloc.add(
      CreatePaymentRequestEvent.tokenAmountUpdated(amount.decimal),
    );
  }

  @override
  Widget build(BuildContext context) =>
      Provider<CreatePaymentRequestBloc>.value(
        value: paymentRequestBloc,
        child: _Content(amount: widget.initialAmount),
      );
}

class _Content extends StatefulWidget {
  const _Content({Key? key, required this.amount}) : super(key: key);

  final Amount amount;

  @override
  State<_Content> createState() => _ContentState();
}

class _ContentState extends State<_Content> implements NoteSetter {
  @override
  void onNoteSubmitted(String name) {
    context
        .read<CreatePaymentRequestBloc>()
        .add(CreatePaymentRequestEvent.labelUpdated(name));

    final state = context.read<CreatePaymentRequestBloc>().state;

    if (state.tokenAmount.value != 0) {
      final event = CreatePaymentRequestEvent.submitted(
        recipient: context.read<MyAccount>().wallet.publicKey,
      );
      context.read<CreatePaymentRequestBloc>().add(event);
    }
  }

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          Provider<NoteSetter>.value(value: this),
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
              context.navigateTo(LinkDetailsFlowRoute(id: request.id));
            },
            orElse: ignore,
          ),
          builder: (context, state) => CpLoader(
            isLoading: state.flow.isProcessing(),
            child: RequestNoteScreen(amount: widget.amount),
          ),
          buildWhen: (s1, s2) => s1.flow != s2.flow,
        ),
      );
}
