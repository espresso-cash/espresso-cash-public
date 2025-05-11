enum BrijOrderStatus {
  pending('PENDING'),
  accepted('ACCEPTED'),
  rejected('REJECTED'),
  completed('COMPLETED'),
  failed('FAILED'),
  unknown('UNKNOWN');

  const BrijOrderStatus(this.value);

  final String value;

  static BrijOrderStatus fromString(String status) {
    for (final BrijOrderStatus brijStatus in values) {
      if (brijStatus.value == status) {
        return brijStatus;
      }
    }

    return unknown;
  }
}
