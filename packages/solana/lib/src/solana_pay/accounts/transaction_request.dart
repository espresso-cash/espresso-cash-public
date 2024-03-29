import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_request.freezed.dart';
part 'transaction_request.g.dart';

@freezed
class TransactionRequestInfo with _$TransactionRequestInfo {
  const factory TransactionRequestInfo({
    required String label,
    required String icon,
  }) = _TransactionRequestInfo;

  factory TransactionRequestInfo.fromJson(Map<String, dynamic> json) =>
      _$TransactionRequestInfoFromJson(json);
}

@freezed
class TransactionRequestResponse with _$TransactionRequestResponse {
  const factory TransactionRequestResponse({
    required String transaction,
    String? message,
    String? redirect,
  }) = _TransactionRequestResponse;

  factory TransactionRequestResponse.fromJson(Map<String, dynamic> json) =>
      _$TransactionRequestResponseFromJson(json);
}
