import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/screens/authenticated/swap_tokens/components/input_widgets/amount_input_widget.dart';
import 'package:cryptoplease/presentation/screens/authenticated/swap_tokens/components/token_dropdown.dart';
import 'package:cryptoplease/tokens/token.dart';
import 'package:flutter/material.dart';

class InputRowWidget extends StatelessWidget {
  const InputRowWidget({
    Key? key,
    required this.label,
    required this.selectedToken,
    required this.onSelectToken,
    required this.value,
    this.onMaxRequested,
    this.isLoadingAmount = false,
  }) : super(key: key);

  final String label;
  final Token? selectedToken;
  final VoidCallback onSelectToken;
  final String value;
  final bool isLoadingAmount;
  final VoidCallback? onMaxRequested;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label.toUpperCase()),
          const SizedBox(height: 4),
          SizedBox(
            height: 56,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  child: AmountInputWidget(
                    text: value,
                    onMaxRequested: onMaxRequested,
                    suffixWidget: isLoadingAmount
                        ? const _LoadingWidget()
                        : onMaxRequested == null
                            ? null
                            : _MaxButton(onMaxRequested: onMaxRequested),
                  ),
                ),
                const SizedBox(width: 12),
                Flexible(
                  child: TokenDropdown(
                    selectedToken: selectedToken,
                    onTap: onSelectToken,
                    suffixWidget: const Icon(Icons.expand_more),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const Center(
        child: SizedBox.square(
          dimension: 18,
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      );
}

class _MaxButton extends StatelessWidget {
  const _MaxButton({
    Key? key,
    required this.onMaxRequested,
  }) : super(key: key);

  final VoidCallback? onMaxRequested;

  @override
  Widget build(BuildContext context) => TextButton(
        onPressed: onMaxRequested,
        child: Text(
          context.l10n.max.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.normal,
          ),
        ),
      );
}
