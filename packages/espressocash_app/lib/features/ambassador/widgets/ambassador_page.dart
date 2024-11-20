import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../gen/assets.gen.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/app_bar.dart';
import '../../../ui/back_button.dart';
import '../../../ui/colors.dart';
import '../../../ui/theme.dart';

class AmbassadorPage extends StatelessWidget {
  const AmbassadorPage({
    super.key,
    this.name,
    required this.child,
  });

  final Widget child;
  final String? name;

  @override
  Widget build(BuildContext context) => CpTheme.black(
        child: Scaffold(
          appBar: CpAppBar(
            scrolledUnderColor: _backgroundColor,
            leading: const CpBackButton(),
            title: Assets.images.logo.image(height: 36.h),
          ),
          backgroundColor: _backgroundColor,
          extendBodyBehindAppBar: true,
          body: Column(
            children: [
              SizedBox(height: 24.h),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final isTablet = constraints.maxWidth > 600;

                    return isTablet
                        ? DecoratedBox(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white,
                                  offset: Offset(0, constraints.maxHeight - 2),
                                ),
                              ],
                            ),
                            child: Assets.images.ambassadorTab.svg(
                              fit: BoxFit.fitWidth,
                              alignment: Alignment.bottomCenter,
                            ),
                          )
                        : Center(
                            child: Assets.images.ambassador.svg(
                              fit: BoxFit.fitWidth,
                            ),
                          );
                  },
                ),
              ),
              Expanded(
                child: ColoredBox(
                  color: Colors.white,
                  child: Column(
                    children: [
                      if (name case final name?) _AmbassadorHeader(name: name),
                      Expanded(child: SafeArea(top: false, child: child)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}

class _AmbassadorHeader extends StatelessWidget {
  const _AmbassadorHeader({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.only(top: 16.h, bottom: 4.h),
        child: Column(
          children: [
            Text(
              context.l10n.ambassador_title,
              style: TextStyle(
                color: CpColors.darkBackgroundColor,
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.23,
              ),
            ),
            if (name.isNotEmpty)
              Text(
                name,
                style: TextStyle(
                  color: CpColors.darkBackgroundColor,
                  fontSize: 26.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
          ],
        ),
      );
}

const _backgroundColor = CpColors.mediumSandColor;
