import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../l10n/l10n.dart';
import '../../../../routes.gr.dart';
import '../../../../ui/back_button.dart';
import '../../../../ui/decorated_window/decorated_window.dart';
import '../services/app_lock_bloc.dart';
import '../widgets/pin_input_display_widget.dart';

@RoutePage<bool>()
class AppLockDisableScreen extends StatelessWidget {
  const AppLockDisableScreen({
    super.key,
    required this.onFinished,
    required this.onCanceled,
  });

  final VoidCallback onFinished;
  final VoidCallback onCanceled;

  static const route = AppLockDisableRoute.new;

  @override
  Widget build(BuildContext context) => BlocConsumer<AppLockBloc, AppLockState>(
        listener: (context, state) => state.mapOrNull(
          disabled: (_) => onFinished(),
        ),
        builder: (context, state) => DecoratedWindow(
          backButton: CpBackButton(
            onPressed: onCanceled,
          ),
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
