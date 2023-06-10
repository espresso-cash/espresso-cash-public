import 'package:flutter/material.dart';

import '../../../../../l10n/l10n.dart';
import '../../../../../ui/button.dart';
import '../../../../../ui/text_field.dart';

class InputAddressBottomSheet extends StatefulWidget {
  const InputAddressBottomSheet({super.key});

  static Future<String?> show(BuildContext context) => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.75,
          builder: (context, _) => const InputAddressBottomSheet(),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(44),
            topRight: Radius.circular(44),
          ),
        ),
      );

  @override
  State<InputAddressBottomSheet> createState() => _InputAddressScreenState();
}

class _InputAddressScreenState extends State<InputAddressBottomSheet> {
  final _controller = TextEditingController();

  void _onSubmit(String address) => Navigator.of(context).pop(address);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              context.l10n.qrInputAddressTitle,
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                context.l10n.qrInputAddressMessage,
                style: const TextStyle(fontSize: 14.5),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 32),
            CpTextField(
              placeholder: context.l10n.qrInputAddressHint,
              border: CpTextFieldBorder.stadium,
              controller: _controller,
              fontSize: 16,
            ),
            const SizedBox(height: 32),
            ValueListenableBuilder<TextEditingValue>(
              valueListenable: _controller,
              builder: (context, value, child) => CpButton(
                text: context.l10n.pay,
                width: 250,
                onPressed: () => _onSubmit(value.text),
              ),
            ),
          ],
        ),
      );
}
