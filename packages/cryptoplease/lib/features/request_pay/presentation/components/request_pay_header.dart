import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease/features/request_pay/presentation/components/equivalent_display.dart';
import 'package:cryptoplease/features/request_pay/presentation/components/input_display.dart';
import 'package:flutter/material.dart';

class RequestPayHeader extends StatelessWidget {
  const RequestPayHeader({
    Key? key,
    required this.inputController,
    required this.token,
  }) : super(key: key);

  final TextEditingController inputController;
  final Token token;

  @override
  Widget build(BuildContext context) =>
      ValueListenableBuilder<TextEditingValue>(
        valueListenable: inputController,
        builder: (context, value, _) => Column(
          children: [
            InputDisplay(
              input: value.text,
              token: token,
            ),
            const SizedBox(height: 8),
            EquivalentDisplay(
              input: value.text,
              token: token,
            )
          ],
        ),
      );
}
