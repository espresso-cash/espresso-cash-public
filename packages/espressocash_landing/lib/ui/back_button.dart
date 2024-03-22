import 'package:flutter/material.dart';

class CpBackButton extends StatelessWidget {
  const CpBackButton({
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
