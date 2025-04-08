import 'package:flutter/material.dart';

import '../../../ui/markdown_text.dart';

class KycHeader extends StatelessWidget {
  const KycHeader({super.key, required this.title, this.description});

  final String title;
  final String? description;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(left: 12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EcMarkdownText(text: title.toUpperCase()),
        if (description case final description?) ...[
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(fontSize: 16, height: 21 / 16, letterSpacing: .19),
          ),
        ],
      ],
    ),
  );
}
