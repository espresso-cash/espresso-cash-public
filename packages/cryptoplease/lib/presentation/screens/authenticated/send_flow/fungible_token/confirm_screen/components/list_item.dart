import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  const ListItem({
    Key? key,
    required this.label,
    required this.labelStyle,
    this.value,
    this.child,
  })  : assert(
          child != null || value != null,
          'Either child or valu should not be null',
        ),
        super(key: key);

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
              // ignore: avoid-non-null-assertion, cannot be null here
              Text(value!, style: labelStyle, textAlign: TextAlign.center)
            else
              // ignore: avoid-non-null-assertion, cannot be null here
              child!,
          ],
        ),
      );
}
