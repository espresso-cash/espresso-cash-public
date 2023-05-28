import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../l10n/l10n.dart';
import '../../../../ui/decorated_window/decorated_window.dart';
import '../bl/app_lock_bloc.dart';
import 'components/pin_input_display_widget.dart';

class AppLockScreen extends StatelessWidget {
  const AppLockScreen({super.key});

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () => Future.value(false),
        child: BlocBuilder<AppLockBloc, AppLockState>(
          builder: (context, state) => DecoratedWindow(
            hasLogo: true,
            backgroundStyle: BackgroundStyle.dark,
            child: PinInputDisplayWidget(
              message: state.maybeMap(
                locked: (state) => state.isRetrying
                    ? context.l10n.incorrectPasscode
                    : context.l10n.enterPasscode,
                orElse: () => context.l10n.enterPasscode,
              ),
              onCompleted: (pin) =>
                  context.read<AppLockBloc>().add(AppLockEvent.unlock(pin)),
            ),
          ),
        ),
      );
}
