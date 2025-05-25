import 'package:brij_client/brij_client.dart' as kyc;

enum RampType { onRamp, offRamp }

extension RampTypeExtension on RampType {
  kyc.RampType toKycType() => switch (this) {
    RampType.onRamp => kyc.RampType.onRamp,
    RampType.offRamp => kyc.RampType.offRamp,
  };
}
