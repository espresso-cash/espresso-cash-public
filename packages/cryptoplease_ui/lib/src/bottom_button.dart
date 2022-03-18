import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';

class CpBottomButton extends StatelessWidget {
  const CpBottomButton({
    Key? key,
    required this.text,
    this.onPressed,
  }) : super(key: key);

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
