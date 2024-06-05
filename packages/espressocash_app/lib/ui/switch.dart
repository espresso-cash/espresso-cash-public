import 'package:flutter/cupertino.dart';
import 'colors.dart';

class CpSwitch extends StatelessWidget {
  const CpSwitch({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final bool value;
  final ValueSetter<bool> onChanged;

  @override
  Widget build(BuildContext context) => CupertinoSwitch(
        value: value,
        onChanged: onChanged,
        thumbColor: value ? const Color(0xffFCC829) : const Color(0xff555151),
        activeColor: const Color(0xff2D2B2B),
        trackColor: CpColors.dashboardBackgroundColor,
      );
}
