import 'package:flutter/material.dart';

class AppLockWidget extends StatelessWidget {
  const AppLockWidget({
    Key? key,
    required this.onBiometricUnlock,
    required this.onPinUnlock,
  }) : super(key: key);

  final VoidCallback onBiometricUnlock;
  final VoidCallback onPinUnlock;

  @override
  Widget build(BuildContext context) => Container();
}
