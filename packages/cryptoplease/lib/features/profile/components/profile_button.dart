import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton({
    Key? key,
    required this.label,
    this.onPressed,
    this.color = CpColors.primaryTextColor,
  }) : super(key: key);

  final String label;
  final Color color;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) => ListTile(
        onTap: onPressed,
        title: Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Icon(Icons.chevron_right, color: color),
      );
}
