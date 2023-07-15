import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../core/user_preferences.dart';
import '../../../di.config.dart';
import '../../../di.dart';
import '../../../routes.gr.dart';
import '../../accounts/models/account.dart';
import '../../accounts/services/accounts_bloc.dart';
import '../../activities/module.dart';
import '../../backup_phrase/module.dart';
import '../../conversion_rates/module.dart';
import '../../favorite_tokens/module.dart';
import '../../incoming_split_key_payments/module.dart';
import '../../investments/module.dart';
import '../../mobile_wallet/module.dart';
import '../../outgoing_direct_payments/module.dart';
import '../../outgoing_split_key_payments/module.dart';
import '../../payment_request/module.dart';
import '../../popular_tokens/module.dart';
import '../../swap/module.dart';
import '../auth_scope.dart';

@immutable
class HomeRouterKey {
  const HomeRouterKey(this.value);

  final GlobalKey<AutoRouterState> value;
}

@RoutePage()
class AuthenticatedFlowScreen extends StatefulWidget {
  const AuthenticatedFlowScreen({super.key});

  static const route = AuthenticatedFlowRoute.new;

  @override
  State<AuthenticatedFlowScreen> createState() =>
      _AuthenticatedFlowScreenState();
}

class _AuthenticatedFlowScreenState extends State<AuthenticatedFlowScreen> {
  final _homeRouterKey = GlobalKey<AutoRouterState>();

  @override
  void initState() {
    super.initState();
    sl.initAuthScope();
  }

  @override
  void dispose() {
    sl.dropScope(authScope);
    super.dispose();
  }

  @override
  Widget build(BuildContext _) => MultiProvider(
        providers: [
          Provider<UserPreferences>(create: (_) => sl<UserPreferences>()),
          const ConversionRatesModule(),
        ],
        child: BlocBuilder<AccountsBloc, AccountsState>(
          builder: (context, state) {
            final account = state.account;
            if (account == null) return Container();

            return MultiProvider(
              providers: [
                Provider<MyAccount>.value(value: account),
                const BackupPhraseModule(),
                const PaymentRequestModule(),
                Provider<HomeRouterKey>(
                  create: (_) => HomeRouterKey(_homeRouterKey),
                ),
                const ODPModule(),
                const OSKPModule(),
                const InvestmentModule(),
                const ActivitiesModule(),
                const FavoriteTokensModule(),
                const SwapModule(),
                const PopularTokensModule(),
                const MobileWalletModule(),
              ],
              child: AutoRouter(
                key: _homeRouterKey,
                builder: (context, child) => MultiProvider(
                  providers: const [
                    ISKPModule(),
                  ],
                  child: child,
                ),
              ),
            );
          },
        ),
      );
}
