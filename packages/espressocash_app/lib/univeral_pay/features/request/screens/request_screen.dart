import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:solana/solana.dart';

import '../../../../ui/button.dart';
import '../../../../ui/rounded_rectangle.dart';
import '../../../../ui/snackbar.dart';
import '../../../../ui/text_field.dart';
import '../../../core/disclaimer.dart';
import '../../../core/page.dart';
import '../../../routes.gr.dart';
import 'link_screen.dart';

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

  String? _validate() {
    if (!_amountController.text.isValidNumber &&
        _amountController.text.isNotZero) {
      return 'Please enter a valid amount.';
    }

    if (!isValidAddress(_destinationController.text)) {
      return 'Please enter a valid Solana address.';
    }

    if (!_isDisclaimerAccepted) {
      return 'Please accept the disclaimer.';
    }
  }

  Future<void> _onSubmit() async {
    final error = _validate();
    if (error != null) {
      showCpErrorSnackbar(context, message: error);

      return;
    }

    final destination = _destinationController.text;
    final reference = (await Ed25519HDKeyPair.random()).publicKey;
    final amountA = _amountController.text;

    if (!mounted) return;

    await context.router.navigate(
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
                backgroundColor: Colors.black,
                inputType: TextInputType.number,
                multiLine: true,
                prefix: const Text(
                  r'$',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 60,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 60,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
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
                backgroundColor: Colors.black,
                fontSize: 16,
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                multiLine: true,
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
              onPressed: _onSubmit,
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
  bool get isNotZero => this != '0' || this != '';
}
