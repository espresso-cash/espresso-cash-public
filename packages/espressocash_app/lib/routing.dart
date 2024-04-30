import 'package:decimal/decimal.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:solana/solana.dart';
import 'package:solana/solana_pay.dart';

import 'di.dart';
import 'features/accounts/services/account_service.dart';
import 'features/activities/screens/activities_screen.dart';
import 'features/analytics/analytics_manager.dart';
import 'features/app_lock/screens/app_lock_disable_screen.dart';
import 'features/app_lock/screens/app_lock_enable_screen.dart';
import 'features/authenticated/screens/authenticated_flow_screen.dart';
import 'features/authenticated/screens/home_screen.dart';
import 'features/authenticated/screens/main_screen.dart';
import 'features/blockchain/models/blockchain.dart';
import 'features/currency/models/amount.dart';
import 'features/currency/models/currency.dart';
import 'features/incoming_link_payments/screens/incoming_link_payment_screen.dart';
import 'features/onboarding/data/onboarding_repository.dart';
import 'features/onboarding/screens/onboarding_screen.dart';
import 'features/onboarding/screens/profile_screen.dart';
import 'features/outgoing_direct_payments/screens/network_picker_screen.dart';
import 'features/outgoing_direct_payments/screens/odp_confirmation_screen.dart';
import 'features/outgoing_direct_payments/screens/odp_details_screen.dart';
import 'features/outgoing_direct_payments/screens/odp_input_screen.dart';
import 'features/outgoing_dln_payments/screens/details_screen.dart';
import 'features/outgoing_link_payments/models/outgoing_link_payment.dart';
import 'features/outgoing_link_payments/screens/olp_confirmation_screen.dart';
import 'features/outgoing_link_payments/screens/olp_screen.dart';
import 'features/outgoing_link_payments/screens/share_link_screen.dart';
import 'features/payment_request/screens/request_payment_status_screen.dart';
import 'features/payment_request/screens/share_payment_request_screen.dart';
import 'features/profile/screens/manage_profile_screen.dart';
import 'features/profile/screens/profile_screen.dart';
import 'features/qr_scanner/screens/qr_scanner_screen.dart';
import 'features/ramp/models/ramp_partner.dart';
import 'features/ramp/models/ramp_type.dart';
import 'features/ramp/screens/off_ramp_order_screen.dart';
import 'features/ramp/screens/on_ramp_order_screen.dart';
import 'features/ramp/screens/ramp_amount_screen.dart';
import 'features/ramp/screens/ramp_more_options_screen.dart';
import 'features/ramp/screens/ramp_onboarding_screen.dart';
import 'features/ramp/screens/ramp_partner_select_screen.dart';
import 'features/tokens/token.dart';
import 'features/transaction_request/screens/confirmation_screen.dart';
import 'features/transaction_request/screens/tr_details_screen.dart';
import 'features/view_phrase/screens/quiz_intro_screen.dart';
import 'features/view_phrase/screens/quiz_screen.dart';
import 'features/wallet_flow/screens/pay_screen.dart';
import 'features/wallet_flow/screens/wallet_screen.dart';

part 'routing.g.dart';

@TypedShellRoute<AppRoute>(
  routes: [
    TypedShellRoute<AuthenticatedRoute>(
      routes: [
        TypedStatefulShellRoute<HomeShellRoute>(
          branches: [
            TypedStatefulShellBranch(
              routes: [
                TypedGoRoute<HomeRoute>(
                  path: '/home',
                  routes: [
                    TypedGoRoute<ProfileRoute>(
                      path: 'profile',
                      routes: [
                        TypedGoRoute<ManageProfileRoute>(path: 'manage'),
                        TypedGoRoute<AppLockEnableRoute>(
                          path: 'enable-app-lock',
                        ),
                        TypedGoRoute<AppLockDisableRoute>(
                          path: 'disable-app-lock',
                        ),
                        TypedGoRoute<QuizIntroRoute>(path: 'quiz-intro'),
                        TypedGoRoute<QuizRoute>(path: 'quiz'),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            TypedStatefulShellBranch(
              routes: [
                TypedGoRoute<WalletRoute>(
                  path: '/wallet',
                  routes: [
                    TypedGoRoute<PayRoute>(path: 'pay'),
                  ],
                ),
              ],
            ),
            TypedStatefulShellBranch(
              routes: [
                TypedGoRoute<ActivitiesRoute>(
                  path: '/activities',
                  routes: [
                    TypedGoRoute<OLPRoute>(path: 'olp/:id'),
                    TypedGoRoute<OffRampOrderRoute>(path: 'off-ramp/:id'),
                    TypedGoRoute<OnRampOrderRoute>(path: 'on-ramp/:id'),
                    TypedGoRoute<ODPDetailsRoute>(path: 'odp/:id'),
                    TypedGoRoute<TRDetailsRoute>(path: 'tr/:id'),
                    TypedGoRoute<IncomingLinkPaymentRoute>(
                      path: 'details-ilp/:id',
                    ),
                    TypedGoRoute<ShareLinkRoute>(path: 'share-link'),
                    TypedGoRoute<SharePaymentRequestRoute>(
                      path: 'share-payment-request/:id',
                    ),
                    TypedGoRoute<PaymentRequestStatusRoute>(
                      path: 'payment-request-status/:id',
                    ),
                    TypedGoRoute<OutgoingDlnPaymentDetailsRoute>(
                      path: 'details-outgoing-dln-payment/:id',
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        TypedGoRoute<OnboardingRoute>(
          path: '/onboarding/recovery-phrase',
        ),
        TypedGoRoute<OnboardingProfileRoute>(path: '/onboarding/profile'),
        TypedGoRoute<RampPartnerSelectRoute>(path: '/ramp-select-partner'),
        TypedGoRoute<RampMoreOptionsRoute>(path: '/ramp-more-options'),
        TypedGoRoute<RampAmountRoute>(path: '/ramp-amount'),
        TypedGoRoute<RampOnboardingRoute>(path: '/ramp-onboarding'),
        TypedGoRoute<QrScannerRoute>(path: '/qr-scanner'),
        TypedGoRoute<OLPConfirmationRoute>(path: '/olp-confirmation'),
        TypedGoRoute<ODPInputRoute>(path: '/odp-input'),
        TypedGoRoute<ODPConfirmationRoute>(path: '/odp-confirmation'),
        TypedGoRoute<TRConfirmationRoute>(path: '/tr-confirmation'),
        TypedGoRoute<NetworkPickerRoute>(path: '/network-picker'),
      ],
    ),
  ],
)
class AppRoute extends ShellRouteData {
  const AppRoute();

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) =>
      navigator;
}

final goRouter = GoRouter(
  initialLocation: const HomeRoute().location,
  refreshListenable: sl<AccountService>(),
  redirect: (context, state) {
    final isLoggedIn = sl<AccountService>().value != null;

    if (isLoggedIn) {
      final hasFinishedOnboarding =
          sl<OnboardingRepository>().hasFinishedOnboarding;

      final onboardingLocations = [
        const OnboardingRoute().location,
        const OnboardingProfileRoute().location,
      ];

      if (!hasFinishedOnboarding &&
          !onboardingLocations.contains(state.uri.path)) {
        return const OnboardingRoute().location;
      }
    }

    // if (isLoggedIn && state.uri.path.startsWith(const SignInRoute().location)) {
    //   return const HomeRoute().location;
    // }

    // final urlsSafeForLogIn = [
    // const SignInRoute().location,
    // const RestoreAccountRoute().location,
    // const TermsRoute().location,
    // const PrivacyRoute().location,
    // ];
    // if (!isLoggedIn && !urlsSafeForLogIn.contains(state.uri.path)) {
    //   return const SignInRoute().location;
    // }
  },
  observers: [
    sl<AnalyticsManager>().analyticsObserver,
  ],
  routes: $appRoutes,
);
