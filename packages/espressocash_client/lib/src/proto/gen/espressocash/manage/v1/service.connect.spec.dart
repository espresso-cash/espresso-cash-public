//
//  Generated code. Do not modify.
//  source: espressocash/manage/v1/service.proto
//

import "package:connectrpc/connect.dart" as connect;
import "service.pb.dart" as espressocashmanagev1service;

abstract final class ManageService {
  /// Fully-qualified name of the ManageService service.
  static const name = 'espressocash.manage.v1.ManageService';

  static const updateRates = connect.Spec(
    '/$name/UpdateRates',
    connect.StreamType.unary,
    espressocashmanagev1service.UpdateRatesRequest.new,
    espressocashmanagev1service.UpdateRatesResponse.new,
  );

  static const checkTransactions = connect.Spec(
    '/$name/CheckTransactions',
    connect.StreamType.unary,
    espressocashmanagev1service.CheckTransactionsRequest.new,
    espressocashmanagev1service.CheckTransactionsResponse.new,
  );

  static const getPlatformAccountInfo = connect.Spec(
    '/$name/GetPlatformAccountInfo',
    connect.StreamType.unary,
    espressocashmanagev1service.GetPlatformAccountInfoRequest.new,
    espressocashmanagev1service.GetPlatformAccountInfoResponse.new,
  );
}
