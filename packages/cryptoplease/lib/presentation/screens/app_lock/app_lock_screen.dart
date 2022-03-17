import 'package:cryptoplease/bl/app_lock/app_lock_bloc.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/components/decorated_window.dart';
import 'package:cryptoplease/presentation/screens/app_lock/components/pin_input_display_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppLockScreen extends StatelessWidget {
  const AppLockScreen({Key? key}) : super(key: key);

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
              onCompleted: (pin) => context.read<AppLockBloc>().add(
                    AppLockEvent.unlock(pin),
                  ),
            ),
          ),
        ),
      );
}
