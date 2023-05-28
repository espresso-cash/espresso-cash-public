import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/rpc/dto/commitment.dart';
import 'package:solana/src/rpc/dto/confirmation_status.dart';
import 'package:solana/src/rpc/dto/context.dart';

part 'signature_status.g.dart';

/// The status of a signature
@JsonSerializable(createToJson: false)
class SignatureStatus {
  const SignatureStatus({
    required this.slot,
    required this.confirmationStatus,
    this.confirmations,
    this.err,
  });

  factory SignatureStatus.fromJson(Map<String, dynamic> json) =>
      _$SignatureStatusFromJson(json);

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

@JsonSerializable(createToJson: false)
class SignatureStatusesResult extends ContextResult<List<SignatureStatus?>> {
  const SignatureStatusesResult({required super.context, required super.value});

  factory SignatureStatusesResult.fromJson(Map<String, dynamic> json) =>
      _$SignatureStatusesResultFromJson(json);
}
