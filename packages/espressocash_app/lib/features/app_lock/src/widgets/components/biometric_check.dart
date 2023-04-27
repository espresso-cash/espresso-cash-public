import 'dart:developer';

import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';

import '../../bl/app_lock_bloc.dart';

class BiometricsCheck extends StatefulWidget {
  const BiometricsCheck({
    Key? key,
    required this.localBiometrics,
    required this.child,
  }) : super(key: key);

  final LocalBiometrics localBiometrics;
  final Widget child;

  @override
  State<BiometricsCheck> createState() => _BiometricsCheckState();
}

class _BiometricsCheckState extends State<BiometricsCheck> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _checkBiometrics(widget.localBiometrics),
    );
  }

  @override
  void didUpdateWidget(covariant BiometricsCheck oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.localBiometrics != oldWidget.localBiometrics) {
      _checkBiometrics(widget.localBiometrics);
    }
  }

  Future<void> _checkBiometrics(LocalBiometrics biometrics) async {
    print('Calling bio checker');
    final shouldCheck = biometrics.maybeMap(orElse: F, enabled: T);
    print('Should check: $shouldCheck');
    if (!shouldCheck) return;

    final authenticated = await _useLocalBiometrics();
    print('authenticated: $authenticated');

    final event = authenticated
        ? const AppLockEvent.unlock(AppUnlockMode.biometrics())
        : const AppLockEvent.usePin();

    print('mounted: $mounted');
    if (!mounted) return;
    context.read<AppLockBloc>().add(event);
  }

  Future<bool> _useLocalBiometrics() async => tryEitherAsync((_) async {
        final localAuth = LocalAuthentication();

        if (!await localAuth.isDeviceSupported() ||
            !await localAuth.canCheckBiometrics) return false;

        await localAuth.stopAuthentication();

        final authed = await localAuth.authenticate(localizedReason: 'Unlock');

        log('Checking result: $authed');

        return authed;
      }).foldAsync(F, identity);

  @override
  Widget build(BuildContext context) => widget.child;
}
