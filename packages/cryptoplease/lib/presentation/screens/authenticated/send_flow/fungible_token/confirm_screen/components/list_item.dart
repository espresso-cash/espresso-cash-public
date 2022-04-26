import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  const ListItem({
    Key? key,
    required this.label,
    required this.labelStyle,
    this.value,
    this.child,
  }) : super(key: key);

  final String label;
  final String? value;
  final Widget? child;
  final TextStyle labelStyle;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 32),
        child: Column(
          children: [
            Text(label, style: labelStyle),
            const SizedBox(height: 12),
            if (child == null)
              Text(
                value!,
                style: labelStyle,
                textAlign: TextAlign.center,
              )
            else
              child!,
          ],
        ),
      );
}
