import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:solana/solana.dart';

import '../../../../ui/app_bar.dart';
import '../../../../ui/button.dart';
import '../../../../ui/text_field.dart';
import '../qr_scanner_flow.dart';

class InputAddressScreen extends StatefulWidget {
  const InputAddressScreen({Key? key}) : super(key: key);

  @override
  State<InputAddressScreen> createState() => _InputAddressScreenState();
}

class _InputAddressScreenState extends State<InputAddressScreen> {
  final controller = TextEditingController();

  void _onClose() => context.read<QrScannerFlow>().onScanRequested();

  void _onPaste() => Clipboard.getData(Clipboard.kTextPlain).then(
        (v) => v?.text?.let((text) => controller.text = text),
      );

  void _onSubmit(String address) =>
      context.read<QrScannerFlow>().onInputComplete(address);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: CpAppBar(
          leading: BackButton(onPressed: _onClose),
          title: const Text('Enter address'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CpTextField(
                placeholder: 'Solana address of the recipient',
                border: CpTextFieldBorder.rounded,
                controller: controller,
                fontSize: 18,
              ),
              CpButton(
                text: 'Paste',
                size: CpButtonSize.micro,
                onPressed: _onPaste,
              ),
              const Spacer(),
              ValueListenableBuilder<TextEditingValue>(
                valueListenable: controller,
                builder: (context, value, child) => CpButton(
                  text: 'Submit',
                  width: double.infinity,
                  onPressed: isValidAddress(value.text)
                      ? () => _onSubmit(value.text)
                      : null,
                ),
              ),
            ],
          ),
        ),
      );
}
