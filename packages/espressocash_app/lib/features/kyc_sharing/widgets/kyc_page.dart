import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';
import '../../../ui/app_bar.dart';
import '../../../ui/back_button.dart';
import '../../../ui/theme.dart';

class KycPage extends StatelessWidget {
  const KycPage({
    super.key,
    this.title,
    required this.children,
  });

  final String? title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final title = this.title;

    return CpTheme.black(
      child: Scaffold(
        appBar: CpAppBar(
          leading: const CpBackButton(),
          title: title != null ? Text(title) : null,
        ),
        extendBodyBehindAppBar: true,
        body: Padding(
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: MediaQuery.paddingOf(context).top +
                (title != null ? kToolbarHeight : 32),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
              child: ConstrainedBox(
                constraints: constraints.copyWith(
                  minHeight: constraints.maxHeight,
                  maxHeight: double.infinity,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      Assets.images.profileGraphic.image(height: 80),
                      const SizedBox(height: 24),
                      Expanded(
                        child: SafeArea(
                          top: false,
                          minimum: const EdgeInsets.only(bottom: 40),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: children,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
