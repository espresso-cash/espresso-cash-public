import 'package:flutter/material.dart';

import 'button.dart';

class CpBottomButton extends StatelessWidget {
  const CpBottomButton({
    super.key,
    required this.text,
    this.onPressed,
  });

  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.symmetric(vertical: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CpButton(
              key: keyBottomButton,
              onPressed: onPressed,
              minWidth: 250,
              text: text,
            ),
          ],
        ),
      );
}

const keyBottomButton = Key('bottomButton');
