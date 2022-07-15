import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/app/routes.dart';
import 'package:cryptoplease/core/balances/bl/balances_bloc.dart';
import 'package:cryptoplease/core/conversion_rates/bl/repository.dart';
import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease/core/user_preferences.dart';
import 'package:cryptoplease/features/outgoing_transfer/bl/create_outgoing_transfer_bloc/ft/bloc.dart';
import 'package:cryptoplease/features/outgoing_transfer/bl/outgoing_payment.dart';
import 'package:cryptoplease/features/outgoing_transfer/bl/repository.dart';
import 'package:cryptoplease/features/outgoing_transfer/presentation/send_flow/fungible_token/enter_amount_screen.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class FtLinkTransferFlowScreen extends StatefulWidget {
  const FtLinkTransferFlowScreen({
    Key? key,
    required this.onComplete,
    this.token,
  }) : super(key: key);

  final Token? token;
  final ValueSetter<OutgoingTransferId> onComplete;

  @override
  State<FtLinkTransferFlowScreen> createState() =>
      _FtLinkTransferFlowScreenState();
}

class _FtLinkTransferFlowScreenState extends State<FtLinkTransferFlowScreen> {
  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => FtCreateOutgoingTransferBloc(
          repository: context.read<OutgoingTransferRepository>(),
          balances: context.read<BalancesBloc>().state.balances,
          conversionRatesRepository: context.read<ConversionRatesRepository>(),
          userCurrency: context.read<UserPreferences>().fiatCurrency,
          transferType: OutgoingTransferType.splitKey,
          initialToken: widget.token,
        ),
        child: BlocListener<FtCreateOutgoingTransferBloc,
            FtCreateOutgoingTransferState>(
          listener: (context, state) => state.flow.maybeMap(
            success: (s) => widget.onComplete(s.result),
            orElse: ignore,
          ),
          listenWhen: (s1, s2) => s1.flow != s2.flow,
          child: const _Content(),
        ),
      );
}

class _Content extends StatefulWidget {
  const _Content({Key? key}) : super(key: key);

  @override
  State<_Content> createState() => _ContentState();
}

class _ContentState extends State<_Content> implements AmountSetter {
  @override
  void onAmountSet() {
    context.router.navigate(const FtConfirmRoute());
  }

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          Provider<AmountSetter>.value(value: this),
        ],
        child: const AutoRouter(),
      );
}
