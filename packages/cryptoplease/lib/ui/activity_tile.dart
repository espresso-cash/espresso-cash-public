import 'package:flutter/material.dart';

import 'colors.dart';

class ActivityTile extends StatelessWidget {
  const ActivityTile({
    Key? key,
    required this.title,
    required this.icon,
    required this.subtitle,
    this.actions = const <Widget>[],
    this.onTap,
    this.amount,
  }) : super(key: key);

  final String title;
  final Widget icon;
  final String subtitle;
  final List<Widget> actions;
  final VoidCallback? onTap;
  final String? amount;

  @override
  Widget build(BuildContext context) {
    final amount = this.amount;

    return ListTile(
      onTap: onTap,
      leading: icon,
      isThreeLine: actions.isNotEmpty,
      title: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: titleStyle,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (amount != null)
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(amount, style: titleStyle),
            ),
        ],
      ),
      subtitle: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          Text(subtitle, style: subtitleStyle),
          Wrap(spacing: 14, children: actions),
        ],
      ),
    );
  }
}

const titleStyle = TextStyle(
  fontSize: 16,
  letterSpacing: .23,
  color: CpColors.menuPrimaryTextColor,
  fontWeight: FontWeight.w500,
);

const subtitleStyle = TextStyle(
  fontSize: 14,
  color: CpColors.menuPrimaryTextColor,
  letterSpacing: .19,
);
