import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';

import '../../../../../l10n/l10n.dart';
import '../../bl/app_lock_bloc.dart';

class BiometricsCheck extends StatefulWidget {
  const BiometricsCheck({
    Key? key,
    required this.shouldAskForBiometric,
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
      (_) => _checkLocalAuth(widget.localAuth),
    );
  }

  @override
  void didUpdateWidget(covariant BiometricsCheck oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.localAuth != oldWidget.localAuth) {
      _checkLocalAuth(widget.localAuth);
    }
  }

  Future<void> _checkLocalAuth(LocalAuthPreference biometrics) async {
    final shouldCheck = biometrics.maybeMap(orElse: F, enabled: T);
    if (!shouldCheck) return;

    final authenticated = await _authenticate();

    final event = authenticated
        ? const AppLockEvent.unlock(AppUnlockMode.biometrics())
        : const AppLockEvent.usePin();

    if (!mounted) return;
    context.read<AppLockBloc>().add(event);
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
