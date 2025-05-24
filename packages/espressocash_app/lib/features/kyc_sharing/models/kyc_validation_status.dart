import 'package:brij_client/brij_client.dart';

enum KycValidationStatus { unverified, pending, approved, rejected }

extension KycValidationStatusX on KycValidationStatus {
  bool get isPending =>
      this == KycValidationStatus.pending || this == KycValidationStatus.unverified;

  bool get isApprovedOrPending =>
      this == KycValidationStatus.approved || this == KycValidationStatus.pending;
}

extension ValidationStatusX on ValidationStatus {
  KycValidationStatus toKycValidationStatus() => switch (this) {
    ValidationStatus.unspecified || ValidationStatus.unverified => KycValidationStatus.unverified,
    ValidationStatus.pending => KycValidationStatus.pending,
    ValidationStatus.approved => KycValidationStatus.approved,
    ValidationStatus.rejected => KycValidationStatus.rejected,
  };
}

extension KycStatusDetailsX on KycStatus {
  KycValidationStatus toKycValidationStatus() => switch (this) {
    KycStatus.unspecified => KycValidationStatus.unverified,
    KycStatus.pending => KycValidationStatus.pending,
    KycStatus.approved => KycValidationStatus.approved,
    KycStatus.rejected => KycValidationStatus.rejected,
  };
}
