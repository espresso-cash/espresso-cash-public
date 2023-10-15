import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:solana/solana.dart';
import 'package:solana/solana_pay.dart';
import 'package:uuid/uuid.dart';

import '../../../core/amount.dart';
import '../../../core/currency.dart';
import '../../../core/tokens/token.dart';
import '../../../features/payment_request/models/payment_request.dart';
import '../../../gen/assets.gen.dart';
import '../../../l10n/device_locale.dart';
import '../../../ui/button.dart';
import '../../../ui/colors.dart';
import '../../../ui/loader.dart';
import '../../../ui/number_formatter.dart';
import '../../../ui/rounded_rectangle.dart';
import '../../../ui/text_field.dart';
import '../../core/page.dart';
import '../../core/request_helpers.dart';
import 'link_screen.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  final TextEditingController _destinationController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  bool _isDisclaimerAccepted = false;

  @override
  void dispose() {
    _destinationController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  bool get _isValid =>
      isValidAddress(_destinationController.text) &&
      _amountController.text.isValidNumber &&
      _amountController.text.isNotZero &&
      _isDisclaimerAccepted;

  Future<void> _onSubmit() async {
    final destination = _destinationController.text;

    final locale = DeviceLocale.localeOf(context);
    final amount = _amountController.text.toDecimalOrZero(locale);

    final cryptoAmount = Amount.fromDecimal(
      value: amount,
      currency: Currency.usdc,
    ) as CryptoAmount;

    final request = await context.createPayRequest(
      tokenAmount: cryptoAmount,
      recipient: Ed25519HDPublicKey.fromBase58(destination),
    );

    if (!mounted) return;

    await Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (context) => RequestLinkScreen(request),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => PageWidget(
        children: [
          const Text(
            'Destination Address',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: 450,
            child: CpRoundedRectangle(
              padding: const EdgeInsets.all(16),
              backgroundColor: Colors.black,
              child: CpTextField(
                controller: _destinationController,
                placeholder:
                    'Enter the Solana address where you want to\n receive the money.',
                placeholderColor: const Color(0xff9E9E9E),
                padding: const EdgeInsets.all(16),
                textColor: Colors.white,
                backgroundColor: Colors.black,
                fontSize: 16,
                multiLine: true,
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Request Amount',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: 450,
            child: CpRoundedRectangle(
              padding: const EdgeInsets.all(12),
              backgroundColor: Colors.black,
              child: CpTextField(
                controller: _amountController,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                placeholder: '0',
                placeholderColor: Colors.white,
                textColor: Colors.white,
                backgroundColor: Colors.black,
                inputType: TextInputType.number,
                fontSize: 60,
                multiLine: true,
                prefix: const Text(
                  r'$',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 60,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 60,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          _DisclaimerCheckbox(
            value: _isDisclaimerAccepted,
            onChanged: (value) {
              setState(() {
                _isDisclaimerAccepted = value;
              });
            },
          ),
          const SizedBox(height: 32),
          ListenableBuilder(
            listenable:
                Listenable.merge([_destinationController, _amountController]),
            builder: (context, child) => CpButton(
              onPressed: _isValid ? _onSubmit : null,
              text: 'Create Payment Request',
              size: CpButtonSize.big,
              width: 450,
            ),
          ),
        ],
      );
}

class _DisclaimerCheckbox extends StatelessWidget {
  const _DisclaimerCheckbox({
    required this.value,
    required this.onChanged,
  });

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 450,
        child: Column(
          children: [
            const Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text:
                        'Disclaimer for Money Transfer Service Demo\nThis is a demonstration of our money transfer service and involves actual monetary transactions. By using this demo, you acknowledge and agree to the following terms:\n\n',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextSpan(
                    text: '''
1. Educational Purpose: This demo is designed to showcase the functionality and user experience of our money transfer service. It involves real monetary transactions for the purpose of this demonstration.\n
2. Risk of System Error: While we have taken extensive measures to ensure the reliability and accuracy of our systems, there is a small possibility of system error. In the event of such an error, there may be a chance of loss of funds. Any such loss would involve actual money and may not be temporary.\n
3. Code Not Audited: Please note that the underlying code for this demo has not undergone a formal security audit. It is provided for demonstration purposes only and may not reflect the final, audited version.\n
4. Not a Guarantee of Service: The features, functionalities, and processes demonstrated in this platform are subject to change and may not represent the final version of our service.\n
5. Not for Production Use: This demo is not intended for live or production use. Please do not attempt to use this platform for actual financial transactions outside the scope of this demonstration.\n
6. No Liability for Loss: In the event of a system error resulting in the loss of funds, we shall not be held liable for any associated inconvenience or any perceived loss. Any such loss would involve actual money.''',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            InkWell(
              onTap: () {
                onChanged(!value);
              },
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 50),
                      width: 30,
                      height: 30,
                      decoration: ShapeDecoration(
                        color: value
                            ? CpColors.yellowColor
                            : const Color(0xFF7B5100),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                      ),
                      child: Transform.scale(
                        scale: 1.2,
                        child: Theme(
                          data: ThemeData(
                            unselectedWidgetColor: Colors.transparent,
                          ),
                          child: SizedBox.square(
                            child: value ? Assets.images.star.image() : null,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 18),
                    const Expanded(
                      child: Text(
                        'I have read and understood the above disclaimer and agree to use this demo solely for educational and demonstrative purposes.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}

extension on String {
  bool get isValidNumber => RegExp(r'^[0-9]+(\.[0-9]*)?$').hasMatch(this);
  bool get isNotZero => this != '0';
}

extension PaymentRequestExt on BuildContext {
  Future<PaymentRequest> createPayRequest({
    required CryptoAmount tokenAmount,
    required Ed25519HDPublicKey recipient,
  }) =>
      runWithLoader(this, () async {
        final reference = (await Ed25519HDKeyPair.random()).publicKey;
        final Token token = tokenAmount.token;
        final Decimal amount = tokenAmount.decimal;

        final request = SolanaPayRequest(
          recipient: recipient,
          amount: amount,
          splToken: token == Token.sol ? null : token.publicKey,
          reference: [reference],
        );
        final id = const Uuid().v4();

        return PaymentRequest(
          id: id,
          created: DateTime.now(),
          payRequest: request,
          dynamicLink: request.toUniversalPayLink().toString(),
          state: const PaymentRequestState.initial(),
        );
      });
}
