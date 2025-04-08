import 'package:flutter/material.dart';

import '../../../../../ui/colors.dart';
import '../models/kyc_validation_status.dart';
import 'kyc_status_widget.dart';

class KycButton extends StatelessWidget {
  const KycButton({
    super.key,
    required this.label,
    this.description,
    this.onPressed,
    this.textColor = CpColors.lightGreyBackground,
    this.iconColor,
    this.backgroundColor,
    this.icon = Icons.chevron_right,
    this.showIcon = true,
    this.centerText = false,
    this.status,
  });

  final String label;
  final String? description;
  final VoidCallback? onPressed;
  final Color textColor;
  final Color? backgroundColor;
  final Color? iconColor;
  final IconData? icon;
  final bool showIcon;
  final bool centerText;
  final KycValidationStatus? status;

  @override
  Widget build(BuildContext context) {
    final description = this.description;
    final status = this.status;

    return ListTile(
      tileColor: backgroundColor,
      onTap: onPressed,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: centerText ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: [
          Flexible(
            child: Text(
              label,
              style: TextStyle(color: textColor, fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 8),
          if (status != null) KycStatusWidget(status),
        ],
      ),
      subtitle:
          description != null
              ? Text(
                description,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              )
              : null,
      trailing: showIcon ? Icon(icon, color: iconColor) : null,
    );
  }
}
