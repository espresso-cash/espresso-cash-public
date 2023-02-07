import 'package:flutter/material.dart';

import '../../../../l10n/l10n.dart';
import '../token_details.dart';
import 'expandable_text.dart';

class TokenDetailsWidget extends StatelessWidget {
  const TokenDetailsWidget({super.key, required this.data});

  final TokenDetails data;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.aboutTokenLabel(data.name),
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 30,
              ),
            ),
            const SizedBox(height: 12),
            ExpandableText(
              text: TextSpan(
                text: data.description,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                ),
              ),
              maxLines: 8,
            ),
            const SizedBox(height: 24),
            if (data.marketCapRank != null)
              Row(
                children: [
                  _DetailsRowItem(
                    label: context.l10n.marketCapRank,
                    value: Text('#${data.marketCapRank}'),
                  ),
                ],
              )
          ],
        ),
      );
}

class _DetailsRowItem extends StatelessWidget {
  const _DetailsRowItem({required this.label, required this.value});

  final String label;
  final Widget value;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
          ),
          const SizedBox(width: 8),
          DefaultTextStyle(
            style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
            child: value,
          ),
        ],
      );
}
