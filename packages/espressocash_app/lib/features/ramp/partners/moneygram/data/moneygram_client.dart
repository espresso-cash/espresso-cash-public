// ignore_for_file: invalid_annotation_target

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../stellar/constants.dart';

part 'moneygram_client.freezed.dart';
part 'moneygram_client.g.dart';

@RestApi(baseUrl: moneygramBaseUrl)
@injectable
abstract class MoneygramApiClient {
  @factoryMethod
  factory MoneygramApiClient() => _MoneygramApiClient(Dio());

  @GET('/sep24/transaction')
  Future<MgFetchTransactionResponseDto> fetchTransaction(
    @Body() MgFetchTransactionRequestDto body,
    @Header('Authorization') String authHeader,
  );
}

@freezed
class MgFetchTransactionRequestDto with _$MgFetchTransactionRequestDto {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory MgFetchTransactionRequestDto({
    required String id,
  }) = _MgFetchTransactionRequestDto;

  factory MgFetchTransactionRequestDto.fromJson(Map<String, dynamic> json) =>
      _$MgFetchTransactionRequestDtoFromJson(json);
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
    required String status,
    required String kind,
    String? withdrawAnchorAccount,
    String? withdrawMemo,
    String? amountIn,
    String? amountOut,
    String? moreInfoUrl,
    String? externalTransactionId,
  }) = _TransactionStatus;

  factory TransactionStatus.fromJson(Map<String, dynamic> json) =>
      _$TransactionStatusFromJson(json);
}
