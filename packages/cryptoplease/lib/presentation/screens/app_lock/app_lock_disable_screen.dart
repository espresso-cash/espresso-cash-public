import 'package:cryptoplease/bl/app_lock/app_lock_bloc.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/components/decorated_window.dart';
import 'package:cryptoplease/presentation/screens/app_lock/app_lock_setup_flow_screen.dart';
import 'package:cryptoplease/presentation/screens/app_lock/components/pin_input_display_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppLockDisableScreen extends StatelessWidget {
  const AppLockDisableScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocConsumer<AppLockBloc, AppLockState>(
        listener: (context, state) => state.mapOrNull(
          disabled: (_) =>
              context.read<AppLockSetupRouter>().onDisableFinished(),
        ),
        builder: (context, state) => DecoratedWindow(
          hasLogo: true,
          backgroundStyle: BackgroundStyle.dark,
          child: PinInputDisplayWidget(
            message: state.maybeMap(
              enabled: (state) => state.disableFailed
                  ? context.l10n.incorrectPasscode
                  : context.l10n.enterPasscode,
              orElse: () => context.l10n.enterPasscode,
            ),
            onCompleted: (pin) => context.read<AppLockBloc>().add(
                  AppLockEvent.disable(pin),
                ),
          ),
        ),
      );
}
