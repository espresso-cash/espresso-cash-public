import 'package:flutter/material.dart';

import 'colors.dart';

enum CpButtonVariant {
  secondary,
  dark,
  light,
  inverted,
}

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
  });

  final String text;
  final double? width;
  final VoidCallback? onPressed;
  final CpButtonVariant variant;
  final double? minWidth;
  final CpButtonSize size;
  final CpButtonAlignment alignment;

  Color get _backgroundColor {
    switch (variant) {
      case CpButtonVariant.dark:
        return CpColors.yellowColor;
      case CpButtonVariant.inverted:
        return CpColors.darkBackground;
      case CpButtonVariant.light:
        return CpColors.lightButtonBackgroundColor;
      case CpButtonVariant.secondary:
        return CpColors.lightGreyBackground;
    }
  }

  Color get _foregroundColor {
    switch (variant) {
      case CpButtonVariant.inverted:
        return CpColors.lightGreyBackground;
      case CpButtonVariant.secondary:
      case CpButtonVariant.dark:
      case CpButtonVariant.light:
        return CpColors.primaryTextColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = (() {
      // ignore: avoid-non-null-assertion, the style should be there
      final style = Theme.of(context)
          .textTheme
          .labelLarge!
          .copyWith(overflow: TextOverflow.ellipsis);
      switch (size) {
        case CpButtonSize.normal:
          return style;
        case CpButtonSize.big:
          return style.copyWith(fontSize: 17);
        case CpButtonSize.small:
          return style.copyWith(fontSize: 17, height: 1);
        case CpButtonSize.wide:
          return style.copyWith(fontSize: 16, height: 0);
        case CpButtonSize.micro:
          return style.copyWith(fontSize: 15, height: 0);
      }
    })();

    final double horizontalPadding;
    switch (size) {
      case CpButtonSize.micro:
        horizontalPadding = 8;
        break;
      case CpButtonSize.wide:
        horizontalPadding = 4;
        break;
      case CpButtonSize.normal:
      case CpButtonSize.big:
      case CpButtonSize.small:
        horizontalPadding = 16;
        break;
    }

    final button = TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        animationDuration: Duration.zero,
        minimumSize:
            MaterialStateProperty.all(Size(minWidth ?? 100, size.height)),
        fixedSize: MaterialStateProperty.all(
          Size.fromHeight(size.height),
        ),
        shape: MaterialStateProperty.all(const StadiumBorder()),
        alignment: alignment.alignment,
        overlayColor:
            MaterialStateProperty.all(CpColors.translucentYellowColor),
        padding: MaterialStateProperty.all(
          EdgeInsets.symmetric(horizontal: horizontalPadding),
        ),
        backgroundColor: MaterialStateProperty.resolveWith(
          (states) => states.contains(MaterialState.disabled)
              ? _backgroundColor.withOpacity(_disabledOpacity)
              : _backgroundColor,
        ),
        foregroundColor: MaterialStateProperty.resolveWith(
          (states) => states.contains(MaterialState.disabled)
              ? _foregroundColor.withOpacity(_disabledOpacity)
              : _foregroundColor,
        ),
        textStyle: MaterialStateProperty.all(textStyle),
      ),
      child: Text(text),
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

extension on CpButtonSize {
  double get height {
    switch (this) {
      case CpButtonSize.normal:
        return 51;
      case CpButtonSize.big:
        return 63;
      case CpButtonSize.wide:
      case CpButtonSize.small:
        return 44;
      case CpButtonSize.micro:
        return 30;
    }
  }
}
