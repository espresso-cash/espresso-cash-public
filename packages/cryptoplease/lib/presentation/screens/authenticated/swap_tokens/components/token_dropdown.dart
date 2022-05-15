import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:cryptoplease/presentation/components/token_icon.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';

class TokenDropdown extends StatelessWidget {
  const TokenDropdown({
    Key? key,
    required this.selectedToken,
    required this.onTap,
    required this.isEnabled,
    required this.suffixWidget,
  }) : super(key: key);

  final Token? selectedToken;
  final bool isEnabled;
  final VoidCallback onTap;
  final Widget suffixWidget;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: isEnabled ? onTap : null,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            color: CpColors.darkBackground,
            borderRadius: BorderRadius.all(
              Radius.circular(7),
            ),
          ),
          child: Row(
            children: [
              if (selectedToken != null) TokenMini(token: selectedToken!),
              Flexible(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: suffixWidget,
                  ),
                ),
              )
            ],
          ),
        ),
      );
}

class TokenMini extends StatelessWidget {
  const TokenMini({
    Key? key,
    required this.token,
    this.onTap,
    this.extensive = false,
  }) : super(key: key);

  final Token token;
  final bool extensive;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: TokenIcon(
                size: 40,
                token: token,
              ),
            ),
            Text(extensive ? token.name : token.symbol),
          ],
        ),
      );
}
