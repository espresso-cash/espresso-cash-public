import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../l10n/l10n.dart';
import '../../../ui/decorated_window/decorated_window.dart';
import '../services/app_lock_bloc.dart';
import '../widgets/pin_input_display_widget.dart';

class AppLockScreen extends StatelessWidget {
  const AppLockScreen({super.key});

  @override
  Widget build(BuildContext context) => PopScope(
        canPop: false,
        child: BlocBuilder<AppLockBloc, AppLockState>(
          builder: (context, state) => DecoratedWindow(
            hasLogo: true,
            backgroundStyle: BackgroundStyle.dark,
            child: PinInputDisplayWidget(
              message: switch (state) {
                AppLockStateLocked() => state.isRetrying
                    ? context.l10n.incorrectPasscode
                    : context.l10n.enterPasscode,
                _ => context.l10n.enterPasscode,
              },
              onCompleted: (pin) =>
                  context.read<AppLockBloc>().add(AppLockEvent.unlock(pin)),
            ),
          ),
        ),
      );
}
