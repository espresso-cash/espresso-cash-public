import 'package:cryptoplease/app/components/number_formatter.dart';
import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease/features/request_pay/presentation/components/input_display.dart';
import 'package:cryptoplease/l10n/device_locale.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
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
            _EquivalentWidget(
              input: value.text,
              token: token,
            )
          ],
        ),
      );
}

class _EquivalentWidget extends StatelessWidget {
  const _EquivalentWidget({
    Key? key,
    required this.input,
    required this.token,
  }) : super(key: key);

  final String input;
  final Token token;

  @override
  Widget build(BuildContext context) {
    final locale = DeviceLocale.localeOf(context);
    final value = input.toDecimalOrZero(locale);
    final symbol = token.symbol;
    final shouldDisplay = value.toDouble() != 0;
    final amount = shouldDisplay ? input : '0';
    final formatted = 'Equivalent to $amount $symbol';

    return SizedBox(
      height: 50,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: shouldDisplay ? 1 : 0,
        child: DecoratedBox(
          decoration: const ShapeDecoration(
            color: CpColors.darkBackground,
            shape: StadiumBorder(),
          ),
          child: Center(
            widthFactor: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                formatted.toUpperCase(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
