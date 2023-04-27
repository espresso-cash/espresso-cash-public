import 'package:flutter/material.dart';

import '../../bl/app_lock_bloc.dart';

class BiometricsCheck extends StatelessWidget {
  const BiometricsCheck({
    Key? key,
    required this.localBiometrics,
  }) : super(key: key);

  final LocalBiometrics localBiometrics;

  @override
  Widget build(BuildContext context) => Container();
}
