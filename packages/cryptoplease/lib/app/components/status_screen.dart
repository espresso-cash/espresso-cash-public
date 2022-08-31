import 'package:cryptoplease/gen/assets.gen.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';

class StatusScreen extends StatelessWidget {
  const StatusScreen({
    Key? key,
    required this.status,
    this.content,
    this.title,
    this.onBackButtonPressed,
  }) : super(key: key);

  final CpStatusType status;
  final Widget? content;
  final String? title;
  final VoidCallback? onBackButtonPressed;

  Widget get _backgroundImage {
    switch (status) {
      case CpStatusType.success:
        return Assets.icons.logoBgGreen.svg(alignment: Alignment.bottomCenter);
      case CpStatusType.info:
        return Assets.icons.logoBgOrange.svg(alignment: Alignment.bottomCenter);
      case CpStatusType.error:
        return Assets.icons.logoBgRed.svg(alignment: Alignment.bottomCenter);
    }
  }

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
              ? BackButton(onPressed: onBackButtonPressed)
              : null,
          automaticallyImplyLeading: onBackButtonPressed != null,
        ),
        body: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: _backgroundImage,
            ),
            if (content != null)
              SizedBox(
                width: double.infinity,
                child: content,
              ),
          ],
        ),
      );
}
