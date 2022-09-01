import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';

enum CpStatusType { success, info, error }

class CpStatusWidget extends StatelessWidget {
  const CpStatusWidget({
    Key? key,
    this.title,
    required this.content,
    this.statusType = CpStatusType.info,
    this.padding = const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
  }) : super(key: key);

  final Widget? title;
  final Widget content;
  final CpStatusType statusType;
  final EdgeInsetsGeometry padding;

  static const _radius = Radius.circular(32);

  Color get _backgroundColor {
    switch (statusType) {
      case CpStatusType.success:
        return CpColors.successBackgroundColor;
      case CpStatusType.info:
        return CpColors.infoBackgroundColor;
      case CpStatusType.error:
        return CpColors.errorBackgroundColor;
    }
  }

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: BoxDecoration(
          color: _backgroundColor,
          borderRadius: const BorderRadius.only(
            bottomLeft: _radius,
            bottomRight: _radius,
            topLeft: _radius,
          ),
        ),
        child: Padding(
          padding: padding,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (title != null)
                  DefaultTextStyle(
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.w800,
                    ),
                    textAlign: TextAlign.center,
                    child: title ?? const SizedBox(),
                  ),
                DefaultTextStyle(
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                  child: content,
                ),
              ],
            ),
          ),
        ),
      );
}
