import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/dto/commitment.dart';

part 'signature_status.g.dart';

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
class SignatureStatusesResponse {
  SignatureStatusesResponse({required this.result});

  factory SignatureStatusesResponse.fromJson(Map<String, dynamic> json) =>
      _$SignatureStatusesResponseFromJson(json);

  final _SignatureStatusesResult result;
}

@JsonSerializable(createToJson: false)
class _SignatureStatusesResult {
  _SignatureStatusesResult({required this.value});

  factory _SignatureStatusesResult.fromJson(Map<String, dynamic> json) =>
      _$SignatureStatusesResultFromJson(json);

  // This is just a workaround for
  // https://github.com/google/json_serializable.dart/issues/956
  @_NullableListConverter()
  final List<SignatureStatus?> value;
}

// This is just a workaround for
// https://github.com/google/json_serializable.dart/issues/956
class _NullableListConverter
    implements JsonConverter<List<SignatureStatus?>, List<dynamic>> {
  const _NullableListConverter();

  @override
  List<SignatureStatus?> fromJson(List<dynamic> json) => json
      .map((dynamic e) => e == null
          ? null
          : SignatureStatus.fromJson(e as Map<String, dynamic>))
      .toList(growable: false);

  @override
  List<dynamic> toJson(List<SignatureStatus?> object) => object;
}
