import 'package:flutter/material.dart';

import 'colors.dart';

class ActivityTile extends StatelessWidget {
  const ActivityTile({
    Key? key,
    required this.title,
    required this.icon,
    required this.subtitle,
    this.amount,
    this.onTap,
  }) : super(key: key);

  final String title;
  final Widget icon;
  final String subtitle;
  final String? amount;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final amount = this.amount;

    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      leading: icon,
      title: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: _titleStyle,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (amount != null)
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(amount, style: _titleStyle),
            ),
        ],
      ),
      subtitle: Text(subtitle, style: _subtitleStyle),
    );
  }
}

const _titleStyle = TextStyle(
  fontSize: 16,
  letterSpacing: .23,
  color: CpColors.menuPrimaryTextColor,
  fontWeight: FontWeight.w500,
);

const _subtitleStyle = TextStyle(
  fontSize: 14,
  color: CpColors.menuPrimaryTextColor,
  letterSpacing: .19,
);
