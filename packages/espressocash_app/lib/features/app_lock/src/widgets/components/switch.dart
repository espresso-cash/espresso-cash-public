import 'package:flutter/material.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../../ui/switch.dart';

class MenuSwitch extends StatelessWidget {
  const MenuSwitch({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final String description;
  final SvgGenImage icon;
  final bool value;
  final ValueSetter<bool> onChanged;

  @override
  Widget build(BuildContext context) => ListTile(
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
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
        trailing: CpSwitch(
          value: value,
          onChanged: onChanged,
        ),
      );
}
