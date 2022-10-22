import 'package:flutter/material.dart';

class ShareMessageHeader extends StatelessWidget {
  const ShareMessageHeader({
    Key? key,
    required this.intro,
    required this.amount,
  }) : super(key: key);

  final String intro;
  final String amount;

  @override
  Widget build(BuildContext context) => Text.rich(
        TextSpan(
          text: intro,
          children: [
            TextSpan(
              text: amount,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
          style: const TextStyle(fontSize: 18, color: Colors.white),
        ),
      );
}
