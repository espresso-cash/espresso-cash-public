import 'package:flutter/material.dart';

import '../../../../ui/app_bar.dart';
import '../../../../ui/colors.dart';
import '../../../../ui/theme.dart';
import '../../../core/page.dart';

class TimelineScreen extends StatelessWidget {
  const TimelineScreen({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) => CpTheme.dark(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(44),
            child: Hero(
              tag: 'appbar',
              child: AppBar(
                backgroundColor: Colors.black,
                elevation: 0,
                leading: null,
                automaticallyImplyLeading: false,
                actions: const [SizedBox.shrink()],
                title: const EspressoProjectBranding(),
              ),
            ),
          ),
          backgroundColor: CpColors.darkSplashBackgroundColor,
          body: Column(
            children: [
              CpAppBar(
                title: const Text(
                  'Transfer Status',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              child,
            ],
          ),
        ),
      );
}
