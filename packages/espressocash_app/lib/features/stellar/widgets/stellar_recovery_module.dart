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
  late final Future<void> _init;

  @override
  void initState() {
    super.initState();
    _init = sl<StellarRecoveryService>().init();
  }

  @override
  Widget build(BuildContext context) => FutureBuilder<void>(
        future: _init,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final hasStellarUsdc = sl<StellarRecoveryService>().hasStellarUsdc;

            if (hasStellarUsdc) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                RecoverStellarScreen.push(
                  context,
                  onConfirmed: () {
                    Navigator.of(context).pop();
                  },
                );
              });
            }
          }

          return widget.child;
        },
      );
}
