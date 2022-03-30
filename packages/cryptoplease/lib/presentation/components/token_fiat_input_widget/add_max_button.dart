import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddMaxButton extends StatelessWidget {
  const AddMaxButton({
    Key? key,
    required this.token,
    required this.onPressed,
  }) : super(key: key);

  final Token token;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => CpButton(
        text: 'MAX',
        variant: CpButtonVariant.light,
        onPressed: onPressed,
      );
}
