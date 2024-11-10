enum KycOrderStatus {
  pending('PENDING'),
  accepted('ACCEPTED'),
  rejected('REJECTED'),
  completed('COMPLETED'),
  failed('FAILED'),
  undelivered('UNDELIVERED'),
  unknown('UNKNOWN');

  const KycOrderStatus(this.value);

  final String value;

  static KycOrderStatus fromString(String status) {
    for (final KycOrderStatus kycStatus in KycOrderStatus.values) {
      if (kycStatus.value == status) {
        return kycStatus;
      }
    }

    return KycOrderStatus.unknown;
  }
}
