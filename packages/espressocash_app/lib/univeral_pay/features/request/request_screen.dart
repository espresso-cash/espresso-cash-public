import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:solana/solana.dart';
import 'package:solana/solana_pay.dart';
import 'package:uuid/uuid.dart';

import '../../../core/amount.dart';
import '../../../core/currency.dart';
import '../../../core/tokens/token.dart';
import '../../../features/payment_request/models/payment_request.dart';
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
  void initState() {
    super.initState();

    _amountController.text = '0';
  }

  @override
  void dispose() {
    _destinationController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  bool get _isValid =>
      isValidAddress(_destinationController.text) &&
      _amountController.text.isValidNumber &&
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
          const SizedBox(height: 16),
          ListenableBuilder(
            listenable:
                Listenable.merge([_destinationController, _amountController]),
            builder: (context, child) => CpButton(
              onPressed: _isValid ? _onSubmit : null,
              text: 'Next',
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
        child: InkWell(
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
                    color:
                        value ? CpColors.yellowColor : const Color(0xFF7B5100),
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
                      child: Checkbox(
                        value: value,
                        onChanged: (bool? newValue) {
                          if (newValue != null) {
                            onChanged(newValue);
                          }
                        },
                        activeColor: CpColors.yellowColor,
                        checkColor: Colors.black,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 18),
                const Expanded(
                  child: Text(
                    'Nullam in nisl eu metus tempor suscipit sed ut elit. Maecenas iaculis mi quis ipsum lobortis dapibus. Aliquam ultricies non diam vel lacinia. Ut iaculis, ipsum vitae rutrum tincidunt, ipsum ipsum consectetur leo, quis rhoncus dui urna sed est.',
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
      );
}

extension on String {
  bool get isValidNumber => RegExp(r'^[0-9]+(\.[0-9]*)?$').hasMatch(this);
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
