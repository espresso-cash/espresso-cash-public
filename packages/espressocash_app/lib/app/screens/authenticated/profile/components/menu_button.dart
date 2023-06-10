import 'package:flutter/material.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../../ui/colors.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String description;
  final SvgGenImage icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => ListTile(
        onTap: onTap,
        visualDensity: VisualDensity.compact,
        minLeadingWidth: 32,
        leading: SizedBox(
          width: 32,
          child: Center(
            child: icon.svg(height: 16, width: 16),
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          description,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        trailing: const Icon(
          Icons.chevron_right,
          color: CpColors.darkBackground,
        ),
      );
}
