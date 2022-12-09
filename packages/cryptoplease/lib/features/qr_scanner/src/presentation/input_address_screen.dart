import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:solana/solana.dart';

import '../../../../ui/app_bar.dart';
import '../../../../ui/button.dart';
import '../../../../ui/text_field.dart';

class InputAddressScreen extends StatefulWidget {
  const InputAddressScreen({Key? key}) : super(key: key);

  @override
  State<InputAddressScreen> createState() => _InputAddressScreenState();
}

class _InputAddressScreenState extends State<InputAddressScreen> {
  final controller = TextEditingController();

  void _onSubmit(String address) => context.router.pop(address);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: CpAppBar(
          title: const Text('Input address'),
        ),
        body: Column(
          children: [
            CpTextField(
              placeholder: 'Enter address',
              controller: controller,
            ),
            CpButton(
              text: 'Submit',
              onPressed: isValidAddress(controller.text)
                  ? () => _onSubmit(controller.text)
                  : null,
            ),
          ],
        ),
      );
}
