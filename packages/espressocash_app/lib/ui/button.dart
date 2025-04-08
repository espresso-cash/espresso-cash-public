import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors.dart';

enum CpButtonVariant { secondary, dark, light, inverted, black, muted, grey }

enum CpButtonSize { normal, big, small, micro, wide }

enum CpButtonAlignment { left, center }

class CpButton extends StatelessWidget {
  const CpButton({
    super.key,
    required this.text,
    this.onPressed,
    this.width,
    this.variant = CpButtonVariant.dark,
    this.minWidth,
    this.size = CpButtonSize.normal,
    this.alignment = CpButtonAlignment.center,
    this.trailing,
    this.leading,
  });

  final String text;
  final double? width;
  final VoidCallback? onPressed;
  final CpButtonVariant variant;
  final double? minWidth;
  final CpButtonSize size;
  final CpButtonAlignment alignment;
  final Widget? trailing;
  final Widget? leading;

  Color get _backgroundColor {
    switch (variant) {
      case CpButtonVariant.dark:
        return CpColors.yellowColor;
      case CpButtonVariant.inverted:
        return CpColors.deepGreyColor;
      case CpButtonVariant.light:
        return CpColors.lightButtonBackgroundColor;
      case CpButtonVariant.secondary:
        return CpColors.lightGreyBackground;
      case CpButtonVariant.black:
        return Colors.black;
      case CpButtonVariant.grey:
        return CpColors.blackGreyColor;
      case CpButtonVariant.muted:
        return const Color(0xff97875A);
    }
  }

  Color get _foregroundColor {
    switch (variant) {
      case CpButtonVariant.inverted:
      case CpButtonVariant.black:
      case CpButtonVariant.muted:
        return CpColors.lightGreyBackground;
      case CpButtonVariant.secondary:
      case CpButtonVariant.dark:
      case CpButtonVariant.light:
        return CpColors.primaryTextColor;
      case CpButtonVariant.grey:
        return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    final textStyle =
        (() {
          // ignore: avoid-non-null-assertion, the style should be there
          final style = Theme.of(
            context,
          ).textTheme.labelLarge!.copyWith(overflow: TextOverflow.ellipsis);
          switch (size) {
            case CpButtonSize.normal:
              return style;
            case CpButtonSize.big:
              return style.copyWith(fontSize: 17.sp);
            case CpButtonSize.small:
              return style.copyWith(fontSize: 14.sp, height: 0);
            case CpButtonSize.wide:
            case CpButtonSize.micro:
              return style.copyWith(fontSize: 16.sp, height: 0);
          }
        })();

    final double horizontalPadding;
    switch (size) {
      case CpButtonSize.micro:
        horizontalPadding = 8.w;
      case CpButtonSize.wide:
        horizontalPadding = 4.w;
      case CpButtonSize.normal:
      case CpButtonSize.big:
      case CpButtonSize.small:
        horizontalPadding = 16.w;
    }

    final button = TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        animationDuration: Duration.zero,
        minimumSize: WidgetStateProperty.all(Size(minWidth ?? 100.w, size.height)),
        fixedSize: WidgetStateProperty.all(Size.fromHeight(size.height)),
        shape: WidgetStateProperty.all(const StadiumBorder()),
        alignment: alignment.alignment,
        overlayColor: WidgetStateProperty.all(CpColors.translucentYellowColor),
        padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: horizontalPadding)),
        backgroundColor: WidgetStateProperty.resolveWith(
          (states) =>
              states.contains(WidgetState.disabled)
                  ? _backgroundColor.withOpacity(_disabledOpacity)
                  : _backgroundColor,
        ),
        foregroundColor: WidgetStateProperty.all(_foregroundColor),
        textStyle: WidgetStateProperty.all(textStyle),
      ),
      child: SizedBox(
        width: trailing == null ? null : double.infinity,
        height: size.height,
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (leading case final leading?) Positioned(left: 0, child: leading),
            Text(text),
            if (trailing case final trailing?) Positioned(right: 0, child: trailing),
          ],
        ),
      ),
    );

    return width != null ? SizedBox(width: width, child: button) : button;
  }
}

const _disabledOpacity = 0.25;

extension on CpButtonAlignment {
  Alignment get alignment {
    switch (this) {
      case CpButtonAlignment.left:
        return Alignment.centerLeft;
      case CpButtonAlignment.center:
        return Alignment.center;
    }
  }
}

extension CpButtonSizeExt on CpButtonSize {
  double get height {
    switch (this) {
      case CpButtonSize.normal:
        return 51.h;
      case CpButtonSize.big:
        return 64.h;
      case CpButtonSize.wide:
        return 44.h;
      case CpButtonSize.small:
        return 40.h;
      case CpButtonSize.micro:
        return 31.h;
    }
  }
}
