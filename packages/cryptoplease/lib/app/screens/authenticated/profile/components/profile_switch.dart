import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../ui/colors.dart';

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
      trailing: CupertinoSwitch(
        //TODO update to CpSwitch when merged
        value: value,
        onChanged: onChanged,
        thumbColor: value ? const Color(0xffFCC829) : Colors.white,
        activeColor: const Color(0xff2D2B2B),
        trackColor: const Color(0xffD2D2D2),
      ),
    );
  }
}
