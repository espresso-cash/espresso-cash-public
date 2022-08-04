import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';

class TokenDisplay extends StatelessWidget {
  const TokenDisplay({
    Key? key,
    required this.selectedToken,
  }) : super(key: key);

  final Token selectedToken;

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.only(left: 4),
        padding: const EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 8.0,
        ),
        height: kToolbarHeight + 8,
        decoration: const ShapeDecoration(
          color: CpColors.darkBackground,
          shape: StadiumBorder(),
        ),
        child: Center(
          child: Text(
            selectedToken.symbol,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
}
