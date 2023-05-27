import 'package:flutter/material.dart';

import 'colors.dart';
import 'switch.dart';

class ProfileSwitch extends StatelessWidget {
  const ProfileSwitch({
    super.key,
    required this.label,
    this.color = CpColors.primaryTextColor,
    required this.value,
    required this.onChanged,
    required this.subtitle,
  });

  final String label;
  final String subtitle;
  final Color color;
  final bool value;
  final ValueSetter<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final subtitle = this.subtitle;

    return ListTile(
      title: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        subtitle,
        maxLines: 2,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
      trailing: CpSwitch(value: value, onChanged: onChanged),
    );
  }
}
