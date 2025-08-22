//
//  Generated code. Do not modify.
//  source: espressocash/api/referrals/v1/service.proto
//

import "package:connectrpc/connect.dart" as connect;
import "service.pb.dart" as espressocashapireferralsv1service;

abstract final class ReferralService {
  /// Fully-qualified name of the ReferralService service.
  static const name = 'espressocash.api.referrals.v1.ReferralService';

  static const addReferral = connect.Spec(
    '/$name/AddReferral',
    connect.StreamType.unary,
    espressocashapireferralsv1service.AddReferralRequest.new,
    espressocashapireferralsv1service.AddReferralResponse.new,
  );

  static const getStats = connect.Spec(
    '/$name/GetStats',
    connect.StreamType.unary,
    espressocashapireferralsv1service.GetStatsRequest.new,
    espressocashapireferralsv1service.GetStatsResponse.new,
  );

  static const verify = connect.Spec(
    '/$name/Verify',
    connect.StreamType.unary,
    espressocashapireferralsv1service.VerifyRequest.new,
    espressocashapireferralsv1service.VerifyResponse.new,
  );
}
