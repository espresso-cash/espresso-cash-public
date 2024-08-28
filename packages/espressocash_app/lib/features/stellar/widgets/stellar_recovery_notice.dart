import 'package:flutter/material.dart';

import '../../../di.dart';
import '../../../ui/button.dart';
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
                      ? AspectRatio(
                          aspectRatio: 450 / 100,
                          child: GestureDetector(
                            onTap: _handlePressed,
                            child: RepaintBoundary(
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: _Content(onPressed: _handlePressed),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                );
        },
      );
}

class _Content extends StatelessWidget {
  const _Content({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: 150,
            child: FittedBox(
              child: Text(
                'USDC Found!',
                maxLines: 2,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          CpButton(
            text: 'Recover USDC',
            size: CpButtonSize.micro,
            onPressed: onPressed,
          ),
          const SizedBox(width: 24),
        ],
      );
}
