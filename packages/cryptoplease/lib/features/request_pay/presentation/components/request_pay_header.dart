import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease/features/request_pay/presentation/components/equivalent_display.dart';
import 'package:cryptoplease/features/request_pay/presentation/components/input_display.dart';
import 'package:flutter/material.dart';

class RequestPayHeader extends StatelessWidget {
  const RequestPayHeader({
    Key? key,
    required this.inputController,
    required this.token,
    required this.collapsed,
  }) : super(key: key);

  final TextEditingController inputController;
  final Token token;
  final bool collapsed;

  @override
  Widget build(BuildContext context) =>
      ValueListenableBuilder<TextEditingValue>(
        valueListenable: inputController,
        builder: (context, value, _) => Column(
          children: [
            InputDisplay(
              input: value.text,
              fontSize: collapsed ? 57 : 80,
            ),
            if (!collapsed)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: EquivalentDisplay(
                  input: value.text,
                  token: token,
                ),
              )
          ],
        ),
      );
}
