import 'package:flutter/material.dart';
import 'package:localizely_sdk/localizely_sdk.dart';

import '../ui/splash_screen.dart';

class LocalizelyUpdater extends StatefulWidget {
  const LocalizelyUpdater({super.key, required this.child});

  final Widget child;

  @override
  State<LocalizelyUpdater> createState() => _LocalizelyUpdaterState();
}

class _LocalizelyUpdaterState extends State<LocalizelyUpdater> {
  bool _isUpdating = true;

  @override
  void initState() {
    super.initState();
    Localizely.updateTranslations().then(
      (_) {
        if (!mounted) return;
        setState(() {
          _isUpdating = false;
        });
      },
      onError: (_) {
        if (!mounted) return;
        setState(() {
          _isUpdating = false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) =>
      _isUpdating ? const SplashScreen() : widget.child;
}
