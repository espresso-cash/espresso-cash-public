import 'package:cryptoplease/app/components/token_icon.dart';
import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';

class TokenDropdown extends StatelessWidget {
  const TokenDropdown({
    Key? key,
    required this.selectedToken,
    required this.onTap,
    required this.suffixWidget,
  }) : super(key: key);

  final Token? selectedToken;
  final VoidCallback onTap;
  final Widget suffixWidget;

  @override
  Widget build(BuildContext context) {
    final token = selectedToken;

    return GestureDetector(
      onTap: onTap,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: CpColors.darkBackground,
          borderRadius: BorderRadius.all(Radius.circular(7)),
        ),
        child: Row(
          children: [
            Expanded(
              child: token != null
                  ? _TokenMini(token: token)
                  : const SizedBox.shrink(),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: suffixWidget,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TokenMini extends StatelessWidget {
  const _TokenMini({
    Key? key,
    required this.token,
  }) : super(key: key);

  final Token token;

  @override
  Widget build(BuildContext context) => InkWell(
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: TokenIcon(size: 40, token: token),
            ),
            Flexible(
              child: Text(
                token.symbol,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      );
}
