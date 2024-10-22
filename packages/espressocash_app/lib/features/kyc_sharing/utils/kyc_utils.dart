import 'package:kyc_client_dart/kyc_client_dart.dart';

extension ValidationStatusExtension on ValidationStatus {
  bool get isApprovedOrPending =>
      this == ValidationStatus.approved || this == ValidationStatus.pending;
}
