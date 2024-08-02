import 'package:flutter/material.dart';

import '../gen/assets.gen.dart';
import 'app_bar.dart';
import 'back_button.dart';
import 'content_padding.dart';
import 'status_widget.dart';
import 'theme.dart';

class StatusScreen extends StatelessWidget {
  const StatusScreen({
    super.key,
    required this.statusType,
    this.content,
    this.title,
    this.onBackButtonPressed,
    this.statusTitle,
    this.statusContent,
  });

  final CpStatusType statusType;
  final Widget? content;
  final String? title;
  final Widget? statusTitle;
  final Widget? statusContent;
  final VoidCallback? onBackButtonPressed;

  @override
  Widget build(BuildContext context) {
    final content = this.content;
    final title = this.title;
    final onBackButtonPressed = this.onBackButtonPressed;

    final logo = CpTheme.of(context) == const CpThemeData.black()
        ? Assets.icons.logoBg.svg(alignment: Alignment.bottomCenter)
        : Assets.icons.logoBgLight.svg(alignment: Alignment.bottomCenter);

    return Scaffold(
      appBar: CpAppBar(
        title: title != null ? Text(title, style: _titleStyle) : null,
        leading: onBackButtonPressed != null
            ? CpBackButton(onPressed: onBackButtonPressed)
            : null,
        automaticallyImplyLeading: onBackButtonPressed != null,
      ),
      body: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            child: logo,
          ),
          SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                if (statusContent case final statusContent?)
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
);
