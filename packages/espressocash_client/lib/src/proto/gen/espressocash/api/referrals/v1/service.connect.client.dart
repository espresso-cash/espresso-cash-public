//
//  Generated code. Do not modify.
//  source: espressocash/api/referrals/v1/service.proto
//

import "package:connectrpc/connect.dart" as connect;
import "service.pb.dart" as espressocashapireferralsv1service;
import "service.connect.spec.dart" as specs;

extension type ReferralServiceClient (connect.Transport _transport) {
  Future<espressocashapireferralsv1service.AddReferralResponse> addReferral(
    espressocashapireferralsv1service.AddReferralRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.ReferralService.addReferral,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }

  Future<espressocashapireferralsv1service.GetStatsResponse> getStats(
    espressocashapireferralsv1service.GetStatsRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.ReferralService.getStats,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }

  Future<espressocashapireferralsv1service.VerifyResponse> verify(
    espressocashapireferralsv1service.VerifyRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.ReferralService.verify,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }
}
