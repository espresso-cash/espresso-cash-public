class SignatureStatus {
  SignatureStatus.fromDynamic(dynamic value)
      : slot = value['slot'],
        confirmations = value['confirmations'],
        err = value['err'],
        confirmationStatus = value['confirmationStatus'];
  final int slot;
  final int confirmations;
  final dynamic err;
  final String confirmationStatus;
}
