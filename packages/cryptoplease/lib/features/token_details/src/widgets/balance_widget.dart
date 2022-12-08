import 'package:flutter/material.dart';

class PriceWidget extends StatelessWidget {
  const PriceWidget({
    super.key,
    required this.label,
    required this.amount,
  });
  final String label;
  final String amount;

  @override
  Widget build(BuildContext context) => Text.rich(
        TextSpan(
          text: label,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            color: Color(0xff9D9D9D),
            fontSize: 14,
          ),
          children: [
            TextSpan(
              text: ' $amount',
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.white,
                fontSize: 18,
              ),
            )
          ],
        ),
        maxLines: 1,
      );
}
