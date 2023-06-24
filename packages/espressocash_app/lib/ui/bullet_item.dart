import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors.dart';

class CpBulletItemWidget extends StatelessWidget {
  const CpBulletItemWidget({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.only(left: 12.w, right: 39.w),
        child: IntrinsicHeight(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 23.w,
                margin: EdgeInsets.only(right: 19.w, top: 2.h, bottom: 2.h),
                decoration: const ShapeDecoration(
                  color: CpColors.yellowColor,
                  shape: StadiumBorder(),
                ),
                child: const SizedBox(),
              ),
              Expanded(
                child: Text(
                  text,
                  textAlign: TextAlign.start,
                  textHeightBehavior: const TextHeightBehavior(
                    leadingDistribution: TextLeadingDistribution.even,
                  ),
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20.sp,
                  ),
                ),
              )
            ],
          ),
        ),
      );
}
