import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../l10n/l10n.dart';
import '../../../ui/back_button.dart';
import '../../../ui/decorated_window/decorated_window.dart';
import '../services/app_lock_bloc.dart';
import '../widgets/pin_input_display_widget.dart';

class AppLockDisableScreen extends StatelessWidget {
  const AppLockDisableScreen({super.key});

  static void push(BuildContext context) => Navigator.of(context).push<void>(
        MaterialPageRoute(
          builder: (context) => const AppLockDisableScreen(),
        ),
      );

  @override
  Widget build(BuildContext context) => BlocConsumer<AppLockBloc, AppLockState>(
        listener: (context, state) => switch (state) {
          AppLockStateDisabled() => Navigator.pop(context),
          _ => null,
        },
        builder: (context, state) => DecoratedWindow(
          backButton: const CpBackButton(),
          hasLogo: true,
          backgroundStyle: BackgroundStyle.dark,
          child: PinInputDisplayWidget(
            message: switch (state) {
              AppLockStateEnabled() => state.disableFailed
                  ? context.l10n.incorrectPasscode
                  : context.l10n.enterPasscode,
              _ => context.l10n.enterPasscode,
            },
            onCompleted: (pin) =>
                context.read<AppLockBloc>().add(AppLockEvent.disable(pin)),
          ),
        ),
      );
}
