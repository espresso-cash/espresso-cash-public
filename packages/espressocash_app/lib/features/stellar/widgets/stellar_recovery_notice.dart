import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../di.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/colors.dart';
import '../../../ui/info_widget.dart';
import '../screens/recover_stellar_screen.dart';
import '../service/recovery_service.dart';

class StellarRecoveryNotice extends StatefulWidget {
  const StellarRecoveryNotice({super.key});

  @override
  State<StellarRecoveryNotice> createState() => _StellarRecoveryNoticeState();
}

class _StellarRecoveryNoticeState extends State<StellarRecoveryNotice> {
  late final Future<StellarRecoveryService> _recoveryServiceFuture;

  @override
  void initState() {
    super.initState();
    _recoveryServiceFuture = sl.getAsync<StellarRecoveryService>();
  }

  void _handlePressed() => RecoverStellarScreen.push(
        context,
        onConfirmed: () {
          Navigator.of(context).pop();
        },
      );

  @override
  Widget build(BuildContext context) => FutureBuilder<StellarRecoveryService>(
        future: _recoveryServiceFuture,
        builder: (context, snapshot) {
          final recoveryService = snapshot.data;

          if (snapshot.connectionState != ConnectionState.done) {
            return const SizedBox.shrink();
          }

          return snapshot.hasError || recoveryService == null
              ? const SizedBox.shrink()
              : ListenableBuilder(
                  listenable: recoveryService,
                  builder: (context, child) => recoveryService.hasStellarUsdc
                      ? _Content(onPressed: _handlePressed)
                      : const SizedBox.shrink(),
                );
        },
      );
}

class _Content extends StatelessWidget {
  const _Content({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => Center(
        child: SizedBox(
          height: 60,
          width: 350,
          child: CpInfoWidget(
            message: Text.rich(
              TextSpan(
                text: '${context.l10n.stellarRecoveryNoticeTitle}\n',
                children: <TextSpan>[
                  TextSpan(
                    text: context.l10n.stellarRecoveryNoticeAction,
                    style: const TextStyle(
                      color: CpColors.yellowColor,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = onPressed,
                  ),
                ],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            infoRadius: 32,
            variant: CpInfoVariant.black,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
          ),
        ),
      );
}
