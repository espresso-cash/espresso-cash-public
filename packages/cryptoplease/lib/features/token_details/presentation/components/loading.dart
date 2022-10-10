import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';

class TokenLoadingIndicator extends StatelessWidget {
  const TokenLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) => const Center(
        child: SizedBox.square(
          dimension: 20,
          child: CircularProgressIndicator(
            color: CpColors.yellowColor,
          ),
        ),
      );
}
