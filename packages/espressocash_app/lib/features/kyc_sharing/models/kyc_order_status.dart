enum KycOrderStatus {
  pending('PENDING'),
  accepted('ACCEPTED'),
  rejected('REJECTED'),
  completed('COMPLETED'),
  failed('FAILED');

  const KycOrderStatus(this.value);

  final String value;
}
