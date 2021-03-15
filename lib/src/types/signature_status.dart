import 'package:meta/meta.dart';

enum TxStatus { processed, confirmed, finalized, invalid }

class SignatureStatus {
  SignatureStatus({
    @required this.slot,
    @required this.confirmations,
    @required this.err,
    @required this.confirmationStatus,
  });

  factory SignatureStatus.fromJson(Map<String, dynamic> json) {
    TxStatus confirmationStatus = TxStatus.invalid;
    if (json == null) {
      return SignatureStatus(
        slot: 0,
        confirmations: 0,
        confirmationStatus: TxStatus.invalid,
        err: null,
      );
    }
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
