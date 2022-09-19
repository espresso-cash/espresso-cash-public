// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moonpay_client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MoonpayQuoteDto _$$_MoonpayQuoteDtoFromJson(Map<String, dynamic> json) =>
    _$_MoonpayQuoteDto(
      accountId: json['accountId'] as String,
      baseCurrencyCode: json['baseCurrencyCode'] as String,
      baseCurrencyAmount: json['baseCurrencyAmount'] as int,
      quoteCurrencyCode: json['quoteCurrencyCode'] as String,
      quoteCurrencyAmount: (json['quoteCurrencyAmount'] as num).toDouble(),
      quoteCurrencyPrice: (json['quoteCurrencyPrice'] as num).toDouble(),
      feeAmount: (json['feeAmount'] as num).toDouble(),
      extraFeeAmount: json['extraFeeAmount'] as int,
      extraFeePercentage: json['extraFeePercentage'] as int,
      networkFeeAmount: (json['networkFeeAmount'] as num).toDouble(),
      networkFeeAmountNonRefundable:
          json['networkFeeAmountNonRefundable'] as bool,
      totalAmount: (json['totalAmount'] as num).toDouble(),
      feeDiscountType: json['feeDiscountType'],
      feeAmountDiscount: json['feeAmountDiscount'],
      feeRuleId: json['feeRuleId'] as String,
      baseCurrency: MoonpayCurrency.fromJson(
          json['baseCurrency'] as Map<String, dynamic>),
      currency:
          MoonpayCurrency.fromJson(json['currency'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_MoonpayQuoteDtoToJson(_$_MoonpayQuoteDto instance) =>
    <String, dynamic>{
      'accountId': instance.accountId,
      'baseCurrencyCode': instance.baseCurrencyCode,
      'baseCurrencyAmount': instance.baseCurrencyAmount,
      'quoteCurrencyCode': instance.quoteCurrencyCode,
      'quoteCurrencyAmount': instance.quoteCurrencyAmount,
      'quoteCurrencyPrice': instance.quoteCurrencyPrice,
      'feeAmount': instance.feeAmount,
      'extraFeeAmount': instance.extraFeeAmount,
      'extraFeePercentage': instance.extraFeePercentage,
      'networkFeeAmount': instance.networkFeeAmount,
      'networkFeeAmountNonRefundable': instance.networkFeeAmountNonRefundable,
      'totalAmount': instance.totalAmount,
      'feeDiscountType': instance.feeDiscountType,
      'feeAmountDiscount': instance.feeAmountDiscount,
      'feeRuleId': instance.feeRuleId,
      'baseCurrency': instance.baseCurrency,
      'currency': instance.currency,
    };

_$_MoonpayCurrency _$$_MoonpayCurrencyFromJson(Map<String, dynamic> json) =>
    _$_MoonpayCurrency(
      minBuyAmount: json['minBuyAmount'] as int,
    );

Map<String, dynamic> _$$_MoonpayCurrencyToJson(_$_MoonpayCurrency instance) =>
    <String, dynamic>{
      'minBuyAmount': instance.minBuyAmount,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _MoonpayClient implements MoonpayClient {
  _MoonpayClient(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://api.moonpay.com/v3';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<MoonpayQuoteDto> buyQuote(currencyCode, queries) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(queries);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<MoonpayQuoteDto>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/currencies/${currencyCode}/buy_quote',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = MoonpayQuoteDto.fromJson(_result.data!);
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
