part of 'rpc_client.dart';

/// A type alias which makes [TxStatus] more semantically correct in some
/// context.
typedef TxStatus = Commitment;

/// Response of the [`getSignatureStatuses`][get signature statuses] rpc method.
///
/// [get signature statuses]: https://docs.solana.com/developing/clients/jsonrpc-api#getsignaturestatuses
@JsonSerializable(createToJson: false)
class SignatureStatus {
  SignatureStatus({
    required this.slot,
    this.confirmations,
    this.err,
    this.confirmationStatus,
  });

  factory SignatureStatus.fromJson(Map<String, dynamic> json) =>
      _$SignatureStatusFromJson(json);

  final int slot;
  final int? confirmations;
  final Object? err;
  final TxStatus? confirmationStatus;

  @override
  String toString() => confirmationStatus.toString();
}

@JsonSerializable(createToJson: false)
class _SignatureStatusesResponse
    extends JsonRpcResponse<ValueResponse<Iterable<SignatureStatus?>>> {
  _SignatureStatusesResponse(ValueResponse<Iterable<SignatureStatus?>> result)
      : super(result: result);

  factory _SignatureStatusesResponse.fromJson(Map<String, dynamic> json) =>
      _$_SignatureStatusesResponseFromJson(json);
}
