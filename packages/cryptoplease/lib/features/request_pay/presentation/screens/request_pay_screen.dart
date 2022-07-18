import 'package:cryptoplease/app/components/token_fiat_input_widget/enter_amount_keypad.dart';
import 'package:cryptoplease/app/screens/authenticated/components/navigation_bar/navigation_bar.dart';
import 'package:cryptoplease/core/presentation/dialogs.dart';
import 'package:cryptoplease/features/request_pay/bl/request_pay_bloc.dart';
import 'package:cryptoplease/features/request_pay/presentation/components/request_pay_header.dart';
import 'package:cryptoplease/features/request_pay/presentation/components/token_info_widget.dart';
import 'package:cryptoplease/features/request_pay/presentation/request_pay_flow.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RequestPayScreen extends StatefulWidget {
  const RequestPayScreen({Key? key}) : super(key: key);

  @override
  State<RequestPayScreen> createState() => _ScreenState();
}

class _ScreenState extends State<RequestPayScreen> {
  late final RequestPayRouter _router;
  late final TextEditingController _amountController;

  @override
  void initState() {
    _router = context.read<RequestPayRouter>();
    _amountController = TextEditingController();
    _amountController.addListener(_updateValue);
    super.initState();
  }

  @override
  void dispose() {
    _amountController.removeListener(_updateValue);
    super.dispose();
  }

  void _updateValue() {
    final value = _amountController.text;
    _router.onAmountUpdate(value);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: CpAppBar(),
        body: BlocConsumer<RequestPayBloc, RequestPayState>(
          listener: (context, state) => state.processingState.whenOrNull(
            error: (e) => showErrorDialog(context, 'Error', e),
          ),
          builder: (context, state) => Column(
            children: [
              Flexible(
                child: RequestPayHeader(
                  amount: state.amount,
                  onTokenChanged: _router.onTokenSelect,
                  isLoading: state.processingState.isProcessing,
                ),
              ),
              state.processingState.maybeMap(
                orElse: () => const SizedBox.shrink(),
                none: (_) => InfoWidget(token: state.token),
              ),
              Flexible(
                flex: 3,
                child: LayoutBuilder(
                  builder: (context, constraints) => EnterAmountKeypad(
                    height: constraints.maxHeight,
                    width: MediaQuery.of(context).size.width,
                    controller: _amountController,
                    maxDecimals: 2,
                  ),
                ),
              ),
              state.processingState.maybeMap(
                orElse: () => const SizedBox.shrink(),
                none: (_) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CpButton(
                      text: 'Request',
                      onPressed:
                          state.amount.value == 0 ? null : _router.onRequest,
                    ),
                    CpButton(
                      text: 'Pay',
                      onPressed: state.amount.value == 0 ? null : _router.onPay,
                    ),
                  ],
                ),
              ),
              const SizedBox.square(dimension: cpNavigationBarheight),
            ],
          ),
        ),
      );
}
