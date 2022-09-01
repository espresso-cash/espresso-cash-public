import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';

class StatusScreen extends StatelessWidget {
  const StatusScreen({
    Key? key,
    required this.statusType,
    this.content,
    this.title,
    this.onBackButtonPressed,
    this.statusTitle,
    this.statusContent,
    this.backgroundImage,
  }) : super(key: key);

  final CpStatusType statusType;
  final Widget? content;
  final String? title;
  final Widget? statusTitle;
  final Widget? statusContent;
  final Widget? backgroundImage;
  final VoidCallback? onBackButtonPressed;

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        appBar: CpAppBar(
          hasBorder: false,
          title: title != null
              ? Text(
                  title ?? '',
                  style: Theme.of(context).textTheme.headline2?.copyWith(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: CpColors.primaryTextColor,
                      ),
                )
              : null,
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
            if (backgroundImage != null)
              SizedBox(
                height: double.infinity,
                child: backgroundImage,
              ),
            SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  if (statusTitle != null || statusContent != null)
                    CpContentPadding(
                      bottom: false,
                      child: CpStatusWidget(
                        statusType: statusType,
                        title: statusTitle,
                        content: statusContent ?? const SizedBox(),
                      ),
                    ),
                  if (content != null) content ?? const SizedBox(),
                ],
              ),
            ),
          ],
        ),
      );
}
