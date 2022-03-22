import 'package:flutter/material.dart';

class AmountView extends StatelessWidget {
  const AmountView({
    Key? key,
    required this.amount,
  }) : super(key: key);

  final String amount;

  @override
  Widget build(BuildContext context) => Text(
        amount,
        style: const TextStyle(
          fontSize: 45,
          fontWeight: FontWeight.w600,
        ),
      );
}
