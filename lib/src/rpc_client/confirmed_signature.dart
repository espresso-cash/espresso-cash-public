part of 'rpc_client.dart';

/// Each item in the response of [`getConfirmedSignaturesForAddress2`][get confirmed transactions] rpc method.
///
/// [get confirmed transactions]: https://docs.solana.com/developing/clients/jsonrpc-api#getconfirmedsignaturesforaddress2
@JsonSerializable(createToJson: false)
class ConfirmedSignature {
  ConfirmedSignature({
    required this.signature,
    required this.slot,
    this.err,
    this.memo,
    this.blockTime,
  });

  factory ConfirmedSignature.fromJson(Map<String, dynamic> json) =>
      _$ConfirmedSignatureFromJson(json);

  final String signature;
  final int slot;
  final Object? err;
  final String? memo;
  final int? blockTime;

  @override
  String toString() => signature;
}

@JsonSerializable(createToJson: false)
class _ConfirmedSignaturesResponse
    extends JsonRpcResponse<Iterable<ConfirmedSignature>> {
  _ConfirmedSignaturesResponse(Iterable<ConfirmedSignature> result)
      : super(result: result);

  factory _ConfirmedSignaturesResponse.fromJson(Map<String, dynamic> json) =>
      _$_ConfirmedSignaturesResponseFromJson(json);
}
