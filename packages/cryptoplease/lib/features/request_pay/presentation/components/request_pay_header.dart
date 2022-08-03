import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease/features/request_pay/presentation/components/input_display.dart';
import 'package:cryptoplease/features/request_pay/presentation/components/token_display.dart';
import 'package:flutter/material.dart';

class RequestPayHeader extends StatelessWidget {
  const RequestPayHeader({
    Key? key,
    required this.inputController,
    required this.token,
    required this.isLoading,
  }) : super(key: key);

  final TextEditingController inputController;
  final Token token;
  final bool isLoading;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
            child: ValueListenableBuilder<TextEditingValue>(
              valueListenable: inputController,
              builder: (context, value, _) => InputDisplay(input: value.text),
            ),
          ),
          const SizedBox.square(dimension: 16),
          TokenDisplay(
            selectedToken: token,
            suffixWidget: isLoading
                ? const CircularProgressIndicator()
                : const SizedBox.shrink(),
          ),
        ],
      );
}
