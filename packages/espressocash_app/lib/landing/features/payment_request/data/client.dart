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
  Future<GenerateAddressDto> generateEvmAddress({
    @Path('receiver') required String receiver,
    @Path('reference') required String reference,
  });

  @GET('/fee/{chainId}')
  Future<FeeDto> getFees({
    @Path('chainId') required String chainId,
    @Query('amount') required String amount,
    @Query('address') required String address,
  });
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
    required double gasPrice,
    required double takerFeeFixInUsdc,
    required double takerFeeVariableInUsdc,
    required double makerAmount,
    required int makerAmountRounded,
    required double affiliateFee,
    required double makerAmountMinusDeploy,
  }) = _FeeDto;

  factory FeeDto.fromJson(Map<String, dynamic> json) => _$FeeDtoFromJson(json);
}
