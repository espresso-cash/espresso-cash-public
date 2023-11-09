import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';

import '../../../../config.dart';

part 'client.freezed.dart';
part 'client.g.dart';

@Injectable(scope: 'landing')
@RestApi(baseUrl: espressoCashApiUrl)
abstract class UniversalPayApiClient {
  @factoryMethod
  factory UniversalPayApiClient(Dio dio) = _UniversalPayApiClient;

  @GET('/generate/{receiver}/{reference}')
  Future<GenerateAddressDto> generateEvmAddress(
    @Path('receiver') String receiver,
    @Path('reference') String reference,
  );

  @GET('/fee/{chainId}')
  Future<FeeDto> getFees(
    @Path('chainId') String chainId,
    @Query('amount') String amount,
  );
}

@Freezed(toJson: false)
class GenerateAddressDto with _$GenerateAddressDto {
  const factory GenerateAddressDto({
    required String result,
  }) = _GenerateAddressDto;

  factory GenerateAddressDto.fromJson(Map<String, dynamic> json) =>
      _$GenerateAddressDtoFromJson(json);
}

@Freezed(toJson: false)
class FeeDto with _$FeeDto {
  const factory FeeDto({
    required double dlnFeeInUsdc,
    required double relayerFeesToDeploy,
    required double relayerFeesToForward,
    required double takerFeeFix,
    required double takerFeeVariable,
    required double gasPriceInWei,
    required double totalVariableFee,
    required double totalFees,
  }) = _FeeDto;

  factory FeeDto.fromJson(Map<String, dynamic> json) => _$FeeDtoFromJson(json);
}
