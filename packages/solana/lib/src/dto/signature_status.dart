import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/dto/confirmation_status.dart';

part 'signature_status.g.dart';

/// The status of a signature
@JsonSerializable(createFactory: true, includeIfNull: false)
class SignatureStatus {
  const SignatureStatus({
    required this.slot,
    required this.confirmations,
    required this.err,
    required this.confirmationStatus,
  });

  factory SignatureStatus.fromJson(Map<String, dynamic> json) =>
      _$SignatureStatusFromJson(json);

  Map<String, dynamic> toJson() => _$SignatureStatusToJson(this);

  /// The slot the transaction was processed.
  final int slot;

  /// Number of blocks since signature confirmation, null if
  /// rooted, as well as finalized.
  final int? confirmations;

  final Map<String, dynamic>? err;

  /// The transaction's cluster confirmation status; either
  /// [Commitment.processed], [Commitment.confirmed], or
  /// [Commitment.finalized]. See
  /// [Commitment](@help/commitment/link) for more on optimistic
  /// confirmation.
  final ConfirmationStatus confirmationStatus;
}
