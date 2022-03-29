import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/bl/balances/balances_bloc.dart';
import 'package:cryptoplease/bl/conversion_rates/repository.dart';
import 'package:cryptoplease/bl/outgoing_transfers/create_outgoing_transfer_bloc/ft/bloc.dart';
import 'package:cryptoplease/bl/outgoing_transfers/outgoing_payment.dart';
import 'package:cryptoplease/bl/outgoing_transfers/outgoing_transfers_bloc/bloc.dart';
import 'package:cryptoplease/bl/outgoing_transfers/repository.dart';
import 'package:cryptoplease/bl/qr_scanner/qr_scanner_request.dart';
import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:cryptoplease/bl/user_preferences.dart';
import 'package:cryptoplease/presentation/routes.dart';
import 'package:cryptoplease/presentation/screens/authenticated/send_flow/common/send_flow_router.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

abstract class FtSendFlowRouter implements SendFlowRouter {
  void onAmountSubmitted();
}

class SendTokenFlowScreen extends StatefulWidget {
  const SendTokenFlowScreen({
    Key? key,
    this.initialToken,
  }) : super(key: key);

  final Token? initialToken;

  @override
  State<SendTokenFlowScreen> createState() => _State();
}

class _State extends State<SendTokenFlowScreen> implements FtSendFlowRouter {
  late final FtCreateOutgoingTransferBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = FtCreateOutgoingTransferBloc(
      repository: context.read<OutgoingTransferRepository>(),
      balances: context.read<BalancesBloc>().state.balances,
      conversionRatesRepository: context.read<ConversionRatesRepository>(),
      userCurrency: context.read<UserPreferences>().fiatCurrency,
    );

    _reset();
  }

  void _reset() {
    _bloc.add(const FtCreateOutgoingTransferEvent.cleared());
    final initialToken = widget.initialToken;
    if (initialToken != null) {
      _bloc.add(
        FtCreateOutgoingTransferEvent.tokenUpdated(initialToken, lock: true),
      );
    }
  }

  @override
  void onDirectSelected() {
    _reset();

    context.router.navigate(
      EnterAddressRoute(
        initialAddress: _bloc.state.recipientAddress,
      ),
    );
  }

  @override
  Future<void> onQrCodeSelected() async {
    final request =
        await context.router.push<QrScannerRequest>(const QrScannerRoute());

    _reset();

    request?.maybeMap(
      address: (r) {
        _bloc.add(FtCreateOutgoingTransferEvent.recipientUpdated(r.address));

        final currentRoute = context.router.topMatch;
        if (currentRoute.name == PickRecipientTypeRoute.name) {
          onAddressSubmitted(r.address);
        }
      },
      solanaPay: (r) {
        _bloc
          ..add(FtCreateOutgoingTransferEvent.recipientUpdated(r.recipient))
          ..add(
            FtCreateOutgoingTransferEvent.tokenUpdated(r.token, lock: true),
          );
        if (r.reference != null) {
          _bloc.add(
            FtCreateOutgoingTransferEvent.referenceUpdated(r.reference!),
          );
        }

        final amount = r.amount;

        if (amount != null) {
          _bloc.add(FtCreateOutgoingTransferEvent.tokenAmountUpdated(amount));

          onAmountSubmitted();
        } else {
          onAddressSubmitted(r.recipient);
        }
      },
      orElse: () {},
    );
  }

  @override
  void onSplitKeySelected() {
    _reset();

    const event = FtCreateOutgoingTransferEvent.typeUpdated(
      OutgoingTransferType.splitKey,
    );
    _bloc.add(event);

    context.router.navigate(const EnterAmountRoute());
  }

  @override
  void onAddressSubmitted(String address) {
    _bloc.add(FtCreateOutgoingTransferEvent.recipientUpdated(address));

    context.router.navigate(const EnterAmountRoute());
  }

  @override
  void onAmountSubmitted() {
    context.router.navigate(const ConfirmFungibleTokenRoute());
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          BlocProvider.value(value: _bloc),
          // Providing router twice, as some underlying common widgets
          // can use it as SendFlowRouter, while specific FT widgets
          // will look for FtSendFlowRouter.
          Provider<SendFlowRouter>.value(value: this),
          Provider<FtSendFlowRouter>.value(value: this),
        ],
        child: BlocListener<FtCreateOutgoingTransferBloc,
            FtCreateOutgoingTransferState>(
          listenWhen: (s1, s2) => s1.flow != s2.flow,
          listener: (context, state) => state.flow.maybeMap(
            success: (s) {
              Navigator.of(context).pop();
              context.router.navigate(OutgoingTransferFlowRoute(id: s.result));
              context
                  .read<OutgoingTransfersBloc>()
                  .add(OutgoingTransfersEvent.submitted(s.result));
            },
            orElse: ignore,
          ),
          child: const AutoRouter(),
        ),
      );
}
