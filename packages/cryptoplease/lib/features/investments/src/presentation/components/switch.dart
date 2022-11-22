import 'package:flutter/material.dart';

import '../../../../../ui/colors.dart';
import '../../../../../ui/switch.dart';

class ProfileSwitch extends StatelessWidget {
  const ProfileSwitch({
    Key? key,
    required this.label,
    this.color = CpColors.primaryTextColor,
    required this.value,
    required this.onChanged,
    this.subtitle,
  }) : super(key: key);

  final String label;
  final String? subtitle;
  final Color color;
  final bool value;
  final void Function(bool) onChanged;

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
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: TextStyle(
                color: color,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            )
          : null,
      trailing: CpSwitch(
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}
