import 'package:cryptoplease/app/components/token_fiat_input_widget/enter_amount_keypad.dart';
import 'package:cryptoplease/app/screens/authenticated/components/navigation_bar/navigation_bar.dart';
import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease/features/request_pay/presentation/components/qr_scanner_appbar.dart';
import 'package:cryptoplease/features/request_pay/presentation/components/request_pay_header.dart';
import 'package:cryptoplease/features/request_pay/presentation/components/token_info_widget.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';

class RequestPayScreen extends StatefulWidget {
  const RequestPayScreen({Key? key}) : super(key: key);

  @override
  State<RequestPayScreen> createState() => _ScreenState();
}

class _ScreenState extends State<RequestPayScreen> {
  @override
  Widget build(BuildContext context) => CpTheme.dark(
        child: Scaffold(
          appBar: const QrScannerAppBar(),
          body: Column(
            children: [
              const Flexible(
                child: RequestPayHeader(),
              ),
              const InfoWidget(
                selectedToken: Token.usdc,
              ),
              Flexible(
                flex: 3,
                child: LayoutBuilder(
                  builder: (context, constraints) => EnterAmountKeypad(
                    height: constraints.maxHeight,
                    width: MediaQuery.of(context).size.width,
                    controller: TextEditingController(),
                    maxDecimals: 2,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  CpButton(text: 'Request'),
                  CpButton(text: 'Pay'),
                ],
              ),
              const SizedBox.square(dimension: cpNavigationBarheight),
            ],
          ),
        ),
      );
}
