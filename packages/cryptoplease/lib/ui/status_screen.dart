import 'package:cryptoplease/gen/assets.gen.dart';
import 'package:cryptoplease/ui/app_bar.dart';
import 'package:cryptoplease/ui/colors.dart';
import 'package:cryptoplease/ui/content_padding.dart';
import 'package:cryptoplease/ui/status_widget.dart';
import 'package:flutter/material.dart';

class StatusScreen extends StatelessWidget {
  const StatusScreen({
    Key? key,
    required this.statusType,
    this.content,
    this.title,
    this.onBackButtonPressed,
    this.statusTitle,
    required this.statusContent,
  }) : super(key: key);

  final CpStatusType statusType;
  final Widget? content;
  final String? title;
  final Widget? statusTitle;
  final Widget statusContent;
  final VoidCallback? onBackButtonPressed;

  SvgGenImage get backgroundImage {
    switch (statusType) {
      case CpStatusType.success:
        return Assets.icons.logoBgGreen;
      case CpStatusType.info:
        return Assets.icons.logoBgOrange;
      case CpStatusType.error:
        return Assets.icons.logoBgRed;
    }
  }

  @override
  Widget build(BuildContext context) {
    final content = this.content;
    final title = this.title;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CpAppBar(
        title: title != null ? Text(title, style: _titleStyle) : null,
        leading: onBackButtonPressed != null
            ? BackButton(
                onPressed: onBackButtonPressed,
                color: Colors.black,
              )
            : null,
        automaticallyImplyLeading: onBackButtonPressed != null,
      ),
      body: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            child: backgroundImage.svg(alignment: Alignment.bottomCenter),
          ),
          SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                CpContentPadding(
                  bottom: false,
                  child: CpStatusWidget(
                    statusType: statusType,
                    title: statusTitle,
                    content: statusContent,
                  ),
                ),
                if (content != null) Expanded(child: content),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

const _titleStyle = TextStyle(
  fontSize: 17,
  fontWeight: FontWeight.w700,
  color: CpColors.primaryTextColor,
);
