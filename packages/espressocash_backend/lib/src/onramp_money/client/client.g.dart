// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GenerateTokenRequestDto _$$_GenerateTokenRequestDtoFromJson(
        Map<String, dynamic> json) =>
    _$_GenerateTokenRequestDto(
      messageToSign: json['messageToSign'] as String,
      signedMessage: json['signedMessage'] as String,
      walletAddress: json['walletAddress'] as String,
      quantity: json['quantity'] as String,
      appId: json['appId'] as String,
      coinId: json['coinId'] as String,
      chainId: json['chainId'] as String,
    );

Map<String, dynamic> _$$_GenerateTokenRequestDtoToJson(
        _$_GenerateTokenRequestDto instance) =>
    <String, dynamic>{
      'messageToSign': instance.messageToSign,
      'signedMessage': instance.signedMessage,
      'walletAddress': instance.walletAddress,
      'quantity': instance.quantity,
      'appId': instance.appId,
      'coinId': instance.coinId,
      'chainId': instance.chainId,
    };

_$_GenerateTokenResponseDto _$$_GenerateTokenResponseDtoFromJson(
        Map<String, dynamic> json) =>
    _$_GenerateTokenResponseDto(
      token: json['token'] as String,
      depositAddress: json['depositAddress'] as String,
    );

Map<String, dynamic> _$$_GenerateTokenResponseDtoToJson(
        _$_GenerateTokenResponseDto instance) =>
    <String, dynamic>{
      'token': instance.token,
      'depositAddress': instance.depositAddress,
    };

_$_OnRampResponseDto<T> _$$_OnRampResponseDtoFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    _$_OnRampResponseDto<T>(
      data: fromJsonT(json['data']),
    );

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _OnRampMoneyApiClient implements OnRampMoneyApiClient {
  _OnRampMoneyApiClient(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://api.onramp.money/onramp/api/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<OnRampResponseDto<GenerateTokenResponseDto>> generateToken({
    required body,
    required signature,
    required apiKey,
    required payload,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'X-ONRAMP-SIGNATURE': signature,
      r'X-ONRAMP-APIKEY': apiKey,
      r'X-ONRAMP-PAYLOAD': payload,
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = body;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<OnRampResponseDto<GenerateTokenResponseDto>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/v2/sell/transaction/generateToken',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = OnRampResponseDto<GenerateTokenResponseDto>.fromJson(
      _result.data!,
      (json) => GenerateTokenResponseDto.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<OnRampResponseDto<GenerateTokenResponseDto>> getTransaction({
    required body,
    required signature,
    required apiKey,
    required payload,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'X-ONRAMP-SIGNATURE': signature,
      r'X-ONRAMP-APIKEY': apiKey,
      r'X-ONRAMP-PAYLOAD': payload,
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = body;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<OnRampResponseDto<GenerateTokenResponseDto>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/v1/transaction/merchantHistory',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = OnRampResponseDto<GenerateTokenResponseDto>.fromJson(
      _result.data!,
      (json) => GenerateTokenResponseDto.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
