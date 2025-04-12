import 'package:flutter/material.dart';

import 'colors.dart';

class CpRadioButton extends StatelessWidget {
  const CpRadioButton({super.key, required this.value, required this.onChanged});

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: () => onChanged(!value),
    child: Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: value ? CpColors.yellowColor : CpColors.blackGreyColor,
      ),
    ),
  );
}
