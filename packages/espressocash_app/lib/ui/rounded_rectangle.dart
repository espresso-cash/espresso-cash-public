import 'package:flutter/material.dart';

import 'colors.dart';

/// Container that has all but top-right corner rounded.
class CpRoundedRectangle extends StatefulWidget {
  const CpRoundedRectangle({
    super.key,
    required this.child,
    this.backgroundColor,
    this.margin,
    this.padding,
    this.scrollable = false,
  });

  final Widget child;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final bool scrollable;

  @override
  State<CpRoundedRectangle> createState() => _CpRoundedRectangleState();
}

class _CpRoundedRectangleState extends State<CpRoundedRectangle> {
  late final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Container(
        margin: widget.margin,
        padding: widget.padding,
        decoration: BoxDecoration(
          color: widget.backgroundColor ?? CpColors.darkBackground,
          borderRadius: const BorderRadius.only(
            bottomLeft: _radius,
            bottomRight: _radius,
            topLeft: _radius,
          ),
        ),
        child: widget.scrollable
            ? RawScrollbar(
                thumbVisibility: true,
                thickness: 8,
                thumbColor: const Color(0xff525252),
                crossAxisMargin: -24,
                radius: const Radius.circular(9),
                controller: _scrollController,
                child: SingleChildScrollView(
                  padding: EdgeInsets.zero,
                  controller: _scrollController,
                  child: widget.child,
                ),
              )
            : widget.child,
      );
}

const _radius = Radius.circular(39);
