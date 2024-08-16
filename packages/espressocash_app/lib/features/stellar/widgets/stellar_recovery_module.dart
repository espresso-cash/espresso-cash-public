import 'package:flutter/widgets.dart';

import '../../../di.dart';
import '../screens/recover_stellar_screen.dart';
import '../service/recovery_service.dart';

class StellarRecoveryModule extends StatefulWidget {
  const StellarRecoveryModule({super.key, required this.child});

  final Widget child;

  @override
  State<StellarRecoveryModule> createState() => _StellarRecoveryModuleState();
}

class _StellarRecoveryModuleState extends State<StellarRecoveryModule> {
  @override
  void initState() {
    super.initState();

    final hasStellarUsdc = sl<StellarRecoveryService>().hasStellarUsdc;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (hasStellarUsdc) {
        RecoverStellarScreen.push(
          context,
          onConfirmed: () {
            Navigator.of(context).pop();
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
