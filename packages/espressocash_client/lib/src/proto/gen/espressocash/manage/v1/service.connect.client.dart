//
//  Generated code. Do not modify.
//  source: espressocash/manage/v1/service.proto
//

import "package:connectrpc/connect.dart" as connect;
import "service.pb.dart" as espressocashmanagev1service;
import "service.connect.spec.dart" as specs;

extension type ManageServiceClient (connect.Transport _transport) {
  Future<espressocashmanagev1service.UpdateRatesResponse> updateRates(
    espressocashmanagev1service.UpdateRatesRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.ManageService.updateRates,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }

  Future<espressocashmanagev1service.CheckTransactionsResponse> checkTransactions(
    espressocashmanagev1service.CheckTransactionsRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.ManageService.checkTransactions,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }

  Future<espressocashmanagev1service.GetPlatformAccountInfoResponse> getPlatformAccountInfo(
    espressocashmanagev1service.GetPlatformAccountInfoRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.ManageService.getPlatformAccountInfo,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }
}
