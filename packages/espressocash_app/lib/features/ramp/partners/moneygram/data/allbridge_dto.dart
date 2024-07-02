import 'package:freezed_annotation/freezed_annotation.dart';

part 'allbridge_dto.freezed.dart';
part 'allbridge_dto.g.dart';

@freezed
class BridgeStatusRequestDto with _$BridgeStatusRequestDto {
  const factory BridgeStatusRequestDto({
    required Chain chain,
    required String txId,
  }) = _BridgeStatusRequestDto;

  factory BridgeStatusRequestDto.fromJson(Map<String, dynamic> json) =>
      _$BridgeStatusRequestDtoFromJson(json);
}

@freezed
class BridgeStatusResponseDto with _$BridgeStatusResponseDto {
  const factory BridgeStatusResponseDto({
    required String txId,
    required String senderAddress,
    required String recipientAddress,
    required TransactionStatus? send,
    required TransactionStatus? receive,
  }) = _BridgeStatusResponseDto;

  factory BridgeStatusResponseDto.fromJson(Map<String, dynamic> json) =>
      _$BridgeStatusResponseDtoFromJson(json);
}

@freezed
class TransactionStatus with _$TransactionStatus {
  const factory TransactionStatus({
    required String txId,
    required int sourceChainId,
    required String fee,
    required num feeFormatted,
    required String stableFee,
    required num stableFeeFormatted,
    required String amount,
    required num amountFormatted,
    required int blockTime,
    required String blockId,
    required String hash,
  }) = _TransactionStatus;

  factory TransactionStatus.fromJson(Map<String, dynamic> json) =>
      _$TransactionStatusFromJson(json);
}

@freezed
class RestoreStellarTxRequestDto with _$RestoreStellarTxRequestDto {
  const factory RestoreStellarTxRequestDto({
    required String xdrTx,
    required String sender,
  }) = _RestoreStellarTxRequestDto;

  factory RestoreStellarTxRequestDto.fromJson(Map<String, dynamic> json) =>
      _$RestoreStellarTxRequestDtoFromJson(json);
}

@freezed
class RestoreStellarTxResponseDto with _$RestoreStellarTxResponseDto {
  const factory RestoreStellarTxResponseDto({
    required String tx,
  }) = _RestoreStellarTxResponseDto;

  factory RestoreStellarTxResponseDto.fromJson(Map<String, dynamic> json) =>
      _$RestoreStellarTxResponseDtoFromJson(json);
}

enum Chain {
  @JsonValue('SOL')
  solana,
  @JsonValue('SRB')
  stellar,
}
