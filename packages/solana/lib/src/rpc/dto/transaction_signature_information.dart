import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/rpc/dto/commitment.dart';
import 'package:solana/src/rpc/dto/confirmation_status.dart';

part 'transaction_signature_information.g.dart';

/// The information of a transaction signature
@JsonSerializable()
class TransactionSignatureInformation {
  const TransactionSignatureInformation({
    required this.signature,
    required this.slot,
    required this.err,
    required this.memo,
    required this.blockTime,
    this.confirmationStatus,
  });

  factory TransactionSignatureInformation.fromJson(Map<String, dynamic> json) =>
      _$TransactionSignatureInformationFromJson(json);

  /// Transaction signature as base-58 encoded string.
  final String signature;

  /// The slot that contains the block with the transaction.
  final int slot;

  final Map<String, dynamic>? err;

  /// Memo associated with the transaction, null if no memo is
  /// present.
  final String? memo;

  /// Estimated production time, as Unix timestamp (seconds since
  /// the Unix epoch) of when transaction was processed. null if
  /// not available.
  final int? blockTime;

  /// The transaction's cluster confirmation status; either
  /// [Commitment.processed], [Commitment.confirmed], or
  /// [Commitment.finalized]. See
  /// [Commitment](@help/commitment/link) for more on optimistic
  /// confirmation.
  final ConfirmationStatus? confirmationStatus;

  Map<String, dynamic> toJson() =>
      _$TransactionSignatureInformationToJson(this);
}
