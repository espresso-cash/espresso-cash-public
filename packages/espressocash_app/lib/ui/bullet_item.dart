import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'colors.dart';

class CpBulletItemWidget extends StatelessWidget {
  const CpBulletItemWidget({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.only(left: 2.w, right: 16.w),
        child: IntrinsicHeight(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 23.w,
                margin: EdgeInsets.only(right: 8.w, top: 4.h, bottom: 2.h),
                decoration: const ShapeDecoration(
                  color: CpColors.yellowColor,
                  shape: CircleBorder(),
                ),
                child: SizedBox(height: 14.h, width: 14.w),
              ),
              Expanded(child: child),
            ],
          ),
        ),
      );
}
