import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CpSwitch extends StatelessWidget {
  const CpSwitch({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final bool value;
  final void Function(bool) onChanged;

  @override
  Widget build(BuildContext context) => CupertinoSwitch(
        value: value,
        onChanged: onChanged,
        thumbColor: value ? const Color(0xffFCC829) : Colors.white,
        activeColor: const Color(0xff2D2B2B),
        trackColor: const Color(0xffD2D2D2),
      );
}
