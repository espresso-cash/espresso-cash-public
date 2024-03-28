import 'package:flutter/material.dart';

class EcBackButton extends StatelessWidget {
  const EcBackButton({
    super.key,
    this.onPressed,
  });

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final canPop = ModalRoute.of(context)?.impliesAppBarDismissal ?? false;

    return !canPop ? const SizedBox.shrink() : BackButton(onPressed: onPressed);
  }
}
