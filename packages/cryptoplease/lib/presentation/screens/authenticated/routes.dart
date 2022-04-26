import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/presentation/screens/app_lock/routes.dart';
import 'package:cryptoplease/presentation/screens/authenticated/add_funds_flow/add_funds_screen.dart';
import 'package:cryptoplease/presentation/screens/authenticated/backup_phrase_flow/routes.dart';
import 'package:cryptoplease/presentation/screens/authenticated/flow.dart';
import 'package:cryptoplease/presentation/screens/authenticated/home_tabs_screen.dart';
import 'package:cryptoplease/presentation/screens/authenticated/nft/nft_details_screen.dart';
import 'package:cryptoplease/presentation/screens/authenticated/outgoing_transfer_flow/outgoing_transfer_flow.dart';
import 'package:cryptoplease/presentation/screens/authenticated/profile/edit_profile_screen.dart';
import 'package:cryptoplease/presentation/screens/authenticated/profile/help_screen.dart';
import 'package:cryptoplease/presentation/screens/authenticated/puzzle_reminder/routes.dart';
import 'package:cryptoplease/presentation/screens/authenticated/receive_flow/routes.dart';
import 'package:cryptoplease/presentation/screens/authenticated/send_flow/routes.dart';
import 'package:cryptoplease/presentation/screens/authenticated/transaction_details_screen/transaction_details_screen.dart';
import 'package:cryptoplease/presentation/screens/authenticated/transactions_screen/transactions_screen.dart';
import 'package:cryptoplease/presentation/screens/legal/legal_document_view.dart';

const authenticatedFlowRoutes = AutoRoute<void>(
  page: AuthenticatedFlowScreen,
  children: [
    AutoRoute<void>(path: '', page: HomeTabsScreen),
    puzzleReminderFlowRoutes,
    AutoRoute<void>(page: NftDetailsScreen),
    AutoRoute<void>(page: TransactionsScreen),
    AutoRoute<void>(page: TransactionDetailsScreen),
    ...createPaymentFlowRoutes,
    AutoRoute<void>(page: OutgoingTransferFlowScreen),
    ...receiveFlowRoutes,
    AutoRoute<void>(page: AddFundsScreen),
    backupPhraseFlowRoutes,
    appLockSetupFlowRoutes,
    AutoRoute<void>(page: EditProfileScreen),
    AutoRoute<void>(page: TermsOfServiceScreen),
    AutoRoute<void>(page: PrivacyPolicyScreen),
    AutoRoute<void>(page: HelpScreen),
  ],
);
