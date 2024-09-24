import 'package:flutter/material.dart';

import '../../../../../ui/colors.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton({
    super.key,
    required this.label,
    this.description,
    this.onPressed,
    this.textColor = CpColors.lightGreyBackground,
    this.iconColor,
    this.backgroundColor,
    this.showIcon = true,
    this.centerText = false,
  });

  final String label;
  final String? description;
  final VoidCallback? onPressed;
  final Color textColor;
  final Color? backgroundColor;
  final Color? iconColor;
  final bool showIcon;
  final bool centerText;

  @override
  Widget build(BuildContext context) {
    final description = this.description;

    return ListTile(
      tileColor: backgroundColor,
      onTap: onPressed,
      title: Text(
        label,
        textAlign: centerText ? TextAlign.center : TextAlign.start,
        style: TextStyle(
          color: textColor,
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
      trailing: showIcon ? Icon(Icons.chevron_right, color: iconColor) : null,
    );
  }
}
