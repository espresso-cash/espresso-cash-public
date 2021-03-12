enum TxStatus { processed, confirmed, finalized }

class SignatureStatus {
  SignatureStatus({
    this.slot,
    this.confirmations,
    this.err,
    this.confirmationStatus,
  });

  factory SignatureStatus.fromJson(Map<String, dynamic> json) {
    TxStatus confirmationStatus;
    switch (json['confirmationStatus']) {
      case 'processed':
        confirmationStatus = TxStatus.processed;
        break;
      case 'confirmed':
        confirmationStatus = TxStatus.confirmed;
        break;
      case 'finalized':
        confirmationStatus = TxStatus.finalized;
        break;
    }
    return SignatureStatus(
      slot: json['slot'],
      confirmations: json['confirmations'],
      err: json['err'],
      confirmationStatus: confirmationStatus,
    );
  }

  final int slot;
  final int confirmations;
  final dynamic err;
  final TxStatus confirmationStatus;

  String toString() => confirmationStatus.toString();
}
