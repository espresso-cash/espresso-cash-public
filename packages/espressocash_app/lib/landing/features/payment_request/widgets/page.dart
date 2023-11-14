import 'package:flutter/material.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../ui/app_bar.dart';
import '../../../../ui/back_button.dart';

class RequestMobilePage extends StatelessWidget {
  const RequestMobilePage({
    super.key,
    required this.header,
    required this.content,
  });

  final Widget header;
  final Widget content;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: CpAppBar(
          leading: const CpBackButton(),
        ),
        extendBodyBehindAppBar: true,
        body: LayoutBuilder(
          builder: (context, viewportConstraints) => SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    _Header(
                      content: header,
                    ),
                    Expanded(child: content),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}

class _Header extends StatelessWidget {
  const _Header({
    required this.content,
  });

  final Widget content;

  @override
  Widget build(BuildContext context) => AspectRatio(
        aspectRatio: 428 / 400,
        child: Container(
          color: const Color(0xffB4A270),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Assets.images.dollarBg.image(
                fit: BoxFit.fitWidth,
                width: double.infinity,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.paddingOf(context).top,
                    ),
                    content,
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
