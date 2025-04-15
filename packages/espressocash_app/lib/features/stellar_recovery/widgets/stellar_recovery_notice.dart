import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../di.dart';
import '../../../gen/assets.gen.dart';
import '../../../l10n/device_locale.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/colors.dart';
import '../../../ui/info_widget.dart';
import '../../conversion_rates/widgets/extensions.dart';
import '../../currency/models/amount.dart';
import '../models/recovery_state.dart';
import '../screens/recover_stellar_screen.dart';
import '../service/recovery_service.dart';

class StellarRecoveryNotice extends StatefulWidget {
  const StellarRecoveryNotice({super.key});

  @override
  State<StellarRecoveryNotice> createState() => _StellarRecoveryNoticeState();
}

class _StellarRecoveryNoticeState extends State<StellarRecoveryNotice> {
  bool _isVisible = true;

  void _handleRecoverPressed() => RecoverStellarScreen.push(
    context,
    onConfirmed: () {
      Navigator.of(context).pop();
    },
  );

  void _handleHideNoticePressed() {
    setState(() {
      _isVisible = false;
    });

    if (sl<StellarRecoveryService>().value is RecoveryCompleted) {
      sl<StellarRecoveryService>().dismiss();
    }
  }

  @override
  Widget build(BuildContext context) =>
      _isVisible
          ? ListenableBuilder(
            listenable: sl<StellarRecoveryService>(),
            builder: (context, child) {
              Widget notice(Widget child) =>
                  _RecoveryNoticeContent(onClosePressed: _handleHideNoticePressed, child: child);

              return switch (sl<StellarRecoveryService>().value) {
                RecoveryNone() || RecoveryDismissed() => const SizedBox.shrink(),
                RecoveryPending() => notice(_Pending(onRecoverPressed: _handleRecoverPressed)),
                RecoveryProcessing() => notice(const _Processing()),
                RecoveryCompleted(:final amount) => notice(_Completed(amount: amount)),
                RecoveryFailed() => notice(_Failed(onRecoverPressed: _handleRecoverPressed)),
              };
            },
          )
          : const SizedBox.shrink();
}

class _Pending extends StatelessWidget {
  const _Pending({required this.onRecoverPressed});

  final VoidCallback onRecoverPressed;

  @override
  Widget build(BuildContext context) => Text.rich(
    TextSpan(
      children: <TextSpan>[
        TextSpan(text: '${context.l10n.moneyRecoveryNoticeTitle} '),
        TextSpan(
          text: context.l10n.moneyRecoveryNoticeAction,
          style: const TextStyle(color: CpColors.yellowColor),
          recognizer: TapGestureRecognizer()..onTap = onRecoverPressed,
        ),
      ],
    ),
  );
}

class _Processing extends StatelessWidget {
  const _Processing();

  @override
  Widget build(BuildContext context) => Text(context.l10n.moneyRecoveryPending);
}

class _Completed extends StatelessWidget {
  const _Completed({required this.amount});

  final CryptoAmount amount;

  @override
  Widget build(BuildContext context) =>
      Text(context.l10n.moneyRecoverySuccess(amount.format(context.locale, maxDecimals: 2)));
}

class _Failed extends StatelessWidget {
  const _Failed({required this.onRecoverPressed});

  final VoidCallback onRecoverPressed;

  @override
  Widget build(BuildContext context) => Text.rich(
    TextSpan(
      children: <TextSpan>[
        TextSpan(text: '${context.l10n.moneyRecoveryFailure} '),
        TextSpan(
          text: context.l10n.moneyRecoveryNoticeAction,
          style: const TextStyle(color: CpColors.yellowColor),
          recognizer: TapGestureRecognizer()..onTap = onRecoverPressed,
        ),
      ],
    ),
  );
}

class _RecoveryNoticeContent extends StatelessWidget {
  const _RecoveryNoticeContent({required this.onClosePressed, required this.child});

  final VoidCallback onClosePressed;
  final Widget child;

  @override
  Widget build(BuildContext context) => DefaultTextStyle(
    style: const TextStyle(color: Colors.white, fontSize: 14.5, fontWeight: FontWeight.w500),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Center(
        child: SizedBox(
          width: 360,
          child: CpInfoWidget(
            message: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2),
                    child: Center(child: child),
                  ),
                ),
                GestureDetector(
                  onTap: onClosePressed,
                  child: SizedBox.square(
                    dimension: 12,
                    child: Assets.icons.closeButtonIcon.svg(color: Colors.white),
                  ),
                ),
              ],
            ),
            infoRadius: 12,
            iconSize: 12,
            variant: CpInfoVariant.black,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          ),
        ),
      ),
    ),
  );
}
