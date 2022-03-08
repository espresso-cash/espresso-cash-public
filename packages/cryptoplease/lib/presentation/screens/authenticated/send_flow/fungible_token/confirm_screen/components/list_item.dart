import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  const ListItem({
    Key? key,
    required this.label,
    this.value,
    this.child,
  }) : super(key: key);

  final String label;
  final String? value;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      color: CpColors.primaryTextColor,
      fontWeight: FontWeight.w600,
      fontSize: 21,
    );

    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: Column(
        children: [
          Text(label, style: textStyle),
          const SizedBox(height: 12),
          if (child == null)
            Text(
              value!,
              style: textStyle,
            )
          else
            child!,
        ],
      ),
    );
  }
}
