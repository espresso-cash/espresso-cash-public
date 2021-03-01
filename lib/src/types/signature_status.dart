enum TxStatus { processed, confirmed, finalized }

class SignatureStatus {
  SignatureStatus.fromDynamic(dynamic value)
      : slot = value['slot'],
        confirmations = value['confirmations'],
        err = value['err'],
        confirmationStatus = getTxStatusFromString(value['confirmationStatus']);
  final int slot;
  final int confirmations;
  final dynamic err;
  final TxStatus confirmationStatus;

  String toString() => confirmationStatus.toString();

  static TxStatus getTxStatusFromString(String status) {
    switch (status) {
      case 'confirmed':
        return TxStatus.confirmed;
      case 'processed':
        return TxStatus.processed;
      case 'finalized':
        return TxStatus.finalized;
      default:
        throw ('unknown status $status');
    }
  }
}
