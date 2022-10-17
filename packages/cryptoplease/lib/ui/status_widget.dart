import 'package:cryptoplease/ui/colors.dart';
import 'package:cryptoplease/ui/rounded_rectangle.dart';
import 'package:flutter/material.dart';

enum CpStatusType { success, info, error }

class CpStatusWidget extends StatelessWidget {
  const CpStatusWidget({
    Key? key,
    this.title,
    required this.content,
    this.statusType = CpStatusType.info,
  }) : super(key: key);

  final Widget? title;
  final Widget content;
  final CpStatusType statusType;

  @override
  Widget build(BuildContext context) {
    final title = this.title;

    return CpRoundedRectangle(
      backgroundColor: statusType.backgroundColor,
      padding: const EdgeInsets.all(24),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (title != null)
              DefaultTextStyle.merge(
                style: _titleStyle,
                textAlign: TextAlign.center,
                child: title,
              ),
            DefaultTextStyle.merge(
              style: _contentStyle,
              textAlign: TextAlign.center,
              child: content,
            ),
          ],
        ),
      ),
    );
  }
}

extension on CpStatusType {
  Color get backgroundColor {
    switch (this) {
      case CpStatusType.success:
        return CpColors.successBackgroundColor;
      case CpStatusType.info:
        return CpColors.infoBackgroundColor;
      case CpStatusType.error:
        return CpColors.errorBackgroundColor;
    }
  }
}

const _titleStyle = TextStyle(
  color: Colors.white,
  fontSize: 40,
  fontWeight: FontWeight.w800,
);

const _contentStyle = TextStyle(
  color: Colors.white,
  fontSize: 18,
  fontWeight: FontWeight.w500,
);
