import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

import '../../../../../l10n/l10n.dart';

class BiometricsCheck extends StatefulWidget {
  const BiometricsCheck({
    Key? key,
    required this.shouldAskForBiometric,
    required this.onBiometricUnlock,
    required this.child,
  }) : super(key: key);

  final bool shouldAskForBiometric;
  final VoidCallback onBiometricUnlock;
  final Widget child;

  @override
  State<BiometricsCheck> createState() => _BiometricsCheckState();
}

class _BiometricsCheckState extends State<BiometricsCheck> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _checkLocalAuth(widget.shouldAskForBiometric),
    );
  }

  @override
  void didUpdateWidget(covariant BiometricsCheck oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.shouldAskForBiometric != oldWidget.shouldAskForBiometric) {
      _checkLocalAuth(widget.shouldAskForBiometric);
    }
  }

  Future<void> _checkLocalAuth(bool shouldAskForBiometric) async {
    if (!shouldAskForBiometric) return;

    final authenticated = await _authenticate();

    if (authenticated) widget.onBiometricUnlock();
  }

  Future<bool> _authenticate() async => tryEitherAsync((_) async {
        final localAuth = LocalAuthentication();

        if (!await localAuth.isDeviceSupported() ||
            !await localAuth.canCheckBiometrics) return false;

        await localAuth.stopAuthentication();

        if (!mounted) return false;

        return localAuth.authenticate(
          localizedReason: context.l10n.enableLocalAuth,
        );
      }).foldAsync(F, identity);

  @override
  Widget build(BuildContext context) => widget.child;
}
