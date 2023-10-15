import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:solana/solana.dart';

import '../../../../ui/button.dart';
import '../../../../ui/rounded_rectangle.dart';
import '../../../../ui/text_field.dart';
import '../../../core/disclaimer.dart';
import '../../../core/page.dart';
import '../../../routes.gr.dart';
import 'link_screen.dart';

@RoutePage()
class RequestRouterScreen extends AutoRouter {
  const RequestRouterScreen({super.key});
}

@RoutePage()
class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key});

  static const route = RequestRoute.new;

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
    final reference = (await Ed25519HDKeyPair.random()).publicKey;
    final amountA = _amountController.text;

    if (!mounted) return;

    await context.router.push(
      RequestLinkScreen.route(
        amount: amountA,
        receiver: destination,
        reference: reference.toString(),
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
          DisclaimerCheckbox(
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

extension on String {
  bool get isValidNumber => RegExp(r'^[0-9]+(\.[0-9]*)?$').hasMatch(this);
  bool get isNotZero => this != '0';
}
