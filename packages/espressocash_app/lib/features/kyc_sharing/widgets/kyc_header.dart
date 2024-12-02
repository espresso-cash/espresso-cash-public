import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import 'styles.dart';

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
            MarkdownBody(
              data: title.toUpperCase(),
              styleSheet: kycMarkdownStyleSheet,
            ),
            if (description case final description?) ...[
              const SizedBox(height: 8),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 16,
                  height: 21 / 16,
                  letterSpacing: .19,
                ),
              ),
            ],
          ],
        ),
      );
}
