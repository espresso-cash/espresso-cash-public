import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../ui/colors.dart';

class LoadingTextField extends StatelessWidget {
  const LoadingTextField({
    super.key,
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16.w, bottom: 4.h),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 2.h),
            Container(
              height: 70.h,
              margin: null,
              decoration: const ShapeDecoration(
                color: CpColors.darkBackgroundColor,
                shape: StadiumBorder(),
              ),
              padding: EdgeInsets.symmetric(
                vertical: 16.h,
              ),
              child: Row(
                children: [
                  SizedBox(width: 16.w),
                  SizedBox.square(
                    dimension: 36.h,
                    child: const CircleAvatar(
                      backgroundColor: Colors.grey,
                    ),
                  ),
                  SizedBox(width: 24.w),
                  Expanded(
                    child: LoaderAnimation(
                      height: 30.h,
                      width: double.infinity,
                    ),
                  ),
                  SizedBox(width: 24.w),
                ],
              ),
            ),
          ],
        ),
      );
}

class LoaderAnimation extends StatelessWidget {
  const LoaderAnimation({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: height,
        width: width,
        child: const _ShimmerEffect(),
      );
}

class _ShimmerEffect extends StatefulWidget {
  const _ShimmerEffect();

  @override
  _ShimmerEffectState createState() => _ShimmerEffectState();
}

class _ShimmerEffectState extends State<_ShimmerEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: _controller,
        builder: (context, child) => Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.grey.withOpacity(0.3),
                Colors.grey.withOpacity(0.5),
                Colors.grey.withOpacity(0.3),
              ],
              stops: const [0.0, 0.5, 1.0],
              begin: Alignment(-1.0 + (2 * _controller.value), 0.0),
              end: Alignment(1.0 + (2 * _controller.value), 0.0),
            ),
          ),
        ),
      );
}
