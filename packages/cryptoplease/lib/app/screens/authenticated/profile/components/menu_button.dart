import 'package:cryptoplease/app/ui/colors.dart';
import 'package:cryptoplease/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({
    Key? key,
    required this.title,
    required this.description,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

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
          ),
        ),
        trailing: const Icon(
          Icons.chevron_right,
          color: CpColors.darkBackground,
        ),
      );
}
