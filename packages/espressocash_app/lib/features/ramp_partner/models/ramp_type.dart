import 'package:kyc_client_dart/kyc_client_dart.dart' as kyc;

enum RampType { onRamp, offRamp }

extension RampTypeExtension on RampType {
  kyc.RampType toKycType() => switch (this) {
        RampType.onRamp => kyc.RampType.onRamp,
        RampType.offRamp => kyc.RampType.offRamp,
      };
}
