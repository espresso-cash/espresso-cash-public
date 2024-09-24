import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../ui/chip.dart';
import '../../../ui/colors.dart';

class ErrorChip extends StatelessWidget {
  const ErrorChip({
    super.key,
    required this.text,
    required this.visible,
    required this.margin,
  });

  final String text;
  final bool visible;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) => visible
      ? Container(
          margin: margin,
          child: SizedBox(
            height: 55.h,
            child: CpChip(
              padding: CpChipPadding.small,
              backgroundColor: CpColors.errorChipColor,
              child: Text(
                text.toUpperCase(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        )
      : const SizedBox.shrink();
}
