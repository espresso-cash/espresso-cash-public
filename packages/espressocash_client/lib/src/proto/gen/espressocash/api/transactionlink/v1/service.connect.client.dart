//
//  Generated code. Do not modify.
//  source: espressocash/api/transactionlink/v1/service.proto
//

import "package:connectrpc/connect.dart" as connect;
import "service.pb.dart" as espressocashapitransactionlinkv1service;
import "service.connect.spec.dart" as specs;

/// TransactionLinkService manages transaction signing links and wallet onboarding
extension type TransactionLinkServiceClient (connect.Transport _transport) {
  /// Creates a link for user onboarding (Privy auth + SWIG wallet creation)
  Future<espressocashapitransactionlinkv1service.GetOnboardingLinkResponse> getOnboardingLink(
    espressocashapitransactionlinkv1service.GetOnboardingLinkRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.TransactionLinkService.getOnboardingLink,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }

  /// Creates a transaction signing link with JWT
  Future<espressocashapitransactionlinkv1service.CreateTransactionLinkResponse> createTransactionLink(
    espressocashapitransactionlinkv1service.CreateTransactionLinkRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.TransactionLinkService.createTransactionLink,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }

  /// Gets the status of a transaction from blockchain
  Future<espressocashapitransactionlinkv1service.GetTransactionStatusResponse> getTransactionStatus(
    espressocashapitransactionlinkv1service.GetTransactionStatusRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.TransactionLinkService.getTransactionStatus,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }
}
