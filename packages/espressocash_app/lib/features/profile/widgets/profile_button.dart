import 'package:flutter/material.dart';

import '../../../../../ui/colors.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton({
    super.key,
    required this.label,
    this.description,
    this.onPressed,
    this.color = CpColors.primaryTextColor,
  });

  final String label;
  final String? description;
  final Color color;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final description = this.description;

    return ListTile(
      onTap: onPressed,
      title: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: description != null
          ? Text(
              description,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            )
          : null,
      trailing: Icon(Icons.chevron_right, color: color),
    );
  }
}
