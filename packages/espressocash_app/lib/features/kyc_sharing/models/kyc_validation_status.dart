import 'package:kyc_client_dart/kyc_client_dart.dart';

enum KycValidationStatus {
  unverified,
  pending,
  approved,
  rejected,
}

extension KycValidationStatusX on KycValidationStatus {
  bool get isPending =>
      this == KycValidationStatus.pending ||
      this == KycValidationStatus.unverified;
}

extension ValidationStatusX on ValidationStatus {
  KycValidationStatus toKycValidationStatus() => switch (this) {
        ValidationStatus.unspecified ||
        ValidationStatus.unverified =>
          KycValidationStatus.unverified,
        ValidationStatus.pending => KycValidationStatus.pending,
        ValidationStatus.approved => KycValidationStatus.approved,
        ValidationStatus.rejected => KycValidationStatus.rejected,
      };
}
