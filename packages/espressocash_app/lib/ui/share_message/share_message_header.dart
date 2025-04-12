import 'package:flutter/material.dart';

class ShareMessageHeader extends WidgetSpan {
  ShareMessageHeader({required String intro, required String amount})
    : super(
        child: Text.rich(
          TextSpan(
            text: intro,
            children: [TextSpan(text: amount, style: const TextStyle(fontWeight: FontWeight.bold))],
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      );
}
