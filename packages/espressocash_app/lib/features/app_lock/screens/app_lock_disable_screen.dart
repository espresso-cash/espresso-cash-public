import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../l10n/l10n.dart';
import '../../../ui/back_button.dart';
import '../../../ui/decorated_window/decorated_window.dart';
import '../../authenticated/authenticated_navigator_key.dart';
import '../src/services/app_lock_bloc.dart';
import '../src/widgets/pin_input_display_widget.dart';

class AppLockDisableScreen extends StatelessWidget {
  const AppLockDisableScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocConsumer<AppLockBloc, AppLockState>(
        listener: (context, state) => switch (state) {
          AppLockStateDisabled() => context.pop(),
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

class AppLockDisableRoute extends GoRouteData {
  const AppLockDisableRoute();

  static final GlobalKey<NavigatorState> $parentNavigatorKey =
      authenticatedNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const AppLockDisableScreen();
}
