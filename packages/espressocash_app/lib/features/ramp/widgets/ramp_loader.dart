import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../ui/colors.dart';

class LoadingTextField extends StatelessWidget {
  const LoadingTextField({
    super.key,
    required this.prefix,
    required this.suffix,
  });

  final Widget prefix;
  final Widget suffix;

  @override
  Widget build(BuildContext context) => Container(
        margin: null,
        decoration: const ShapeDecoration(
          color: CpColors.darkBackgroundColor,
          shape: StadiumBorder(),
        ),
        padding: EdgeInsets.only(
          top: 12.h,
          bottom: 12.h,
          right: 24.w,
          left: 17.w,
        ),
        child: Row(
          children: [
            prefix,
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: LoaderAnimation(
                  height: 25.h,
                  width: double.infinity,
                ),
              ),
            ),
            suffix,
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
        child: const ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          child: _ShimmerEffect(),
        ),
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
              colors: const [
                Color(0xFF2A2A2A),
                Color(0xFF3A3A3A),
              ],
              stops: const [0.0, 1.0],
              begin: Alignment(-1.0 + (2 * _controller.value), 0.0),
              end: Alignment(1.0 + (2 * _controller.value), 0.0),
            ),
          ),
        ),
      );
}
