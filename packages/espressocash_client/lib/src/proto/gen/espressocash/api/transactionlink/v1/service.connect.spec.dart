//
//  Generated code. Do not modify.
//  source: espressocash/api/transactionlink/v1/service.proto
//

import "package:connectrpc/connect.dart" as connect;
import "service.pb.dart" as espressocashapitransactionlinkv1service;

/// TransactionLinkService manages transaction signing links and wallet onboarding
abstract final class TransactionLinkService {
  /// Fully-qualified name of the TransactionLinkService service.
  static const name = 'espressocash.api.transactionlink.v1.TransactionLinkService';

  /// Creates a link for user onboarding (Privy auth + SWIG wallet creation)
  static const getOnboardingLink = connect.Spec(
    '/$name/GetOnboardingLink',
    connect.StreamType.unary,
    espressocashapitransactionlinkv1service.GetOnboardingLinkRequest.new,
    espressocashapitransactionlinkv1service.GetOnboardingLinkResponse.new,
  );

  /// Creates a transaction signing link with JWT
  static const createTransactionLink = connect.Spec(
    '/$name/CreateTransactionLink',
    connect.StreamType.unary,
    espressocashapitransactionlinkv1service.CreateTransactionLinkRequest.new,
    espressocashapitransactionlinkv1service.CreateTransactionLinkResponse.new,
  );

  /// Gets the status of a transaction from blockchain
  static const getTransactionStatus = connect.Spec(
    '/$name/GetTransactionStatus',
    connect.StreamType.unary,
    espressocashapitransactionlinkv1service.GetTransactionStatusRequest.new,
    espressocashapitransactionlinkv1service.GetTransactionStatusResponse.new,
  );
}
