import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/solana.dart';

import '../../../config.dart';
import '../../link_payments/models/link_payment.dart';

part 'ambassador_referral.freezed.dart';
part 'ambassador_referral.g.dart';

@freezed
class AmbassadorReferral with _$AmbassadorReferral {
  const factory AmbassadorReferral({
    @Ed25519HDPublicKeyConverter() required Ed25519HDPublicKey address,
  }) = _AmbassadorReferral;

  factory AmbassadorReferral.fromJson(Map<String, dynamic> json) =>
      _$AmbassadorReferralFromJson(json);

  const AmbassadorReferral._();

  static AmbassadorReferral? tryParse(String code) {
    try {
      final uri = Uri.parse(code);
      if (uri.scheme != espressoCashLinkProtocol || !uri.path.contains('ambassador')) {
        return null;
      }

      final address = uri.queryParameters['address'];
      if (address == null || !isValidAddress(address)) return null;

      return AmbassadorReferral(address: Ed25519HDPublicKey.fromBase58(address));
    } on Exception {
      return null;
    }
  }

  Uri toLink() => Uri(
    scheme: espressoCashLinkProtocol,
    host: '',
    path: 'ambassador',
    queryParameters: <String, String>{'address': address.toBase58()},
  );
}
