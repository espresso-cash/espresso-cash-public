import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../l10n/l10n.dart';
import '../../../../ui/navigation_bar/navigation_bar.dart';
import '../../../ui/markdown_text.dart';

class NoActivity extends StatelessWidget {
  const NoActivity({super.key});

  @override
  Widget build(BuildContext context) => Column(
        children: [
          SizedBox(height: 60.h),
          Assets.icons.money.svg(height: 78.h),
          SizedBox(height: 30.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 44),
            child: EcMarkdownText(
              text: context.l10n.noActivityTitle.toUpperCase(),
            ),
          ),
          SizedBox(height: 12.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 44),
            child: Text(
              context.l10n.noActivityDescription,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                height: 1.3,
              ),
            ),
          ),
          const SizedBox(height: cpNavigationBarheight),
        ],
      );
}
