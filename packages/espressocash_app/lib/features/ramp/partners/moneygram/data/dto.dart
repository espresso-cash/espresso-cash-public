// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'dto.freezed.dart';
part 'dto.g.dart';

@freezed
class MgWithdrawRequestDto with _$MgWithdrawRequestDto {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory MgWithdrawRequestDto({
    required String assetCode,
    required String account,
    required String lang,
    required String amount,
  }) = _MgWithdrawRequestDto;

  factory MgWithdrawRequestDto.fromJson(Map<String, dynamic> json) =>
      _$MgWithdrawRequestDtoFromJson(json);
}

@freezed
class MgWithdrawResponseDto with _$MgWithdrawResponseDto {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory MgWithdrawResponseDto({
    required String id,
    required String url,
  }) = _MgWithdrawResponseDto;

  factory MgWithdrawResponseDto.fromJson(Map<String, dynamic> json) =>
      _$MgWithdrawResponseDtoFromJson(json);
}

@freezed
class MgFetchTransactionResponseDto with _$MgFetchTransactionResponseDto {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory MgFetchTransactionResponseDto({
    required TransactionStatus transaction,
  }) = _MgFetchTransactionResponseDto;

  factory MgFetchTransactionResponseDto.fromJson(Map<String, dynamic> json) =>
      _$MgFetchTransactionResponseDtoFromJson(json);
}

@freezed
class TransactionStatus with _$TransactionStatus {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory TransactionStatus({
    required String id,
    @JsonKey(unknownEnumValue: MgStatus.unknown) required MgStatus status,
    required String kind,
    String? withdrawAnchorAccount,
    String? withdrawMemo,
    String? amountIn,
    String? amountInAsset,
    String? amountOut,
    String? amountOutAsset,
    String? amountFee,
    String? amountFeeAsset,
    String? moreInfoUrl,
    String? externalTransactionId,
  }) = _TransactionStatus;

  factory TransactionStatus.fromJson(Map<String, dynamic> json) =>
      _$TransactionStatusFromJson(json);
}

@JsonEnum(fieldRename: FieldRename.snake)
enum MgStatus {
  incomplete,
  pendingAnchor,
  pendingUserTransferStart,
  pendingUserTransferComplete,
  refunded,
  expired,
  completed,
  unknown,
}
