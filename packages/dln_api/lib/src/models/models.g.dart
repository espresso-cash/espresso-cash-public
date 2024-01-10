// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderEstimationImpl _$$OrderEstimationImplFromJson(
        Map<String, dynamic> json) =>
    _$OrderEstimationImpl(
      srcChainTokenIn: TokenWithApproximateOperatingExpense.fromJson(
          json['srcChainTokenIn'] as Map<String, dynamic>),
      srcChainTokenOut: json['srcChainTokenOut'] == null
          ? null
          : TokenWithMaxRefundAmount.fromJson(
              json['srcChainTokenOut'] as Map<String, dynamic>),
      dstChainTokenOut: DstChainTokenOutResponseType.fromJson(
          json['dstChainTokenOut'] as Map<String, dynamic>),
      recommendedSlippage: (json['recommendedSlippage'] as num?)?.toDouble(),
      costsDetails: json['costsDetails'] as List<dynamic>,
    );

Map<String, dynamic> _$$OrderEstimationImplToJson(
    _$OrderEstimationImpl instance) {
  final val = <String, dynamic>{
    'srcChainTokenIn': instance.srcChainTokenIn.toJson(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('srcChainTokenOut', instance.srcChainTokenOut?.toJson());
  val['dstChainTokenOut'] = instance.dstChainTokenOut.toJson();
  writeNotNull('recommendedSlippage', instance.recommendedSlippage);
  val['costsDetails'] = instance.costsDetails;
  return val;
}

_$TokenWithMaxRefundAmountImpl _$$TokenWithMaxRefundAmountImplFromJson(
        Map<String, dynamic> json) =>
    _$TokenWithMaxRefundAmountImpl(
      address: json['address'] as String,
      name: json['name'] as String,
      symbol: json['symbol'] as String,
      decimals: json['decimals'] as int,
      amount: json['amount'] as String,
      maxRefundAmount: json['maxRefundAmount'] as String,
    );

Map<String, dynamic> _$$TokenWithMaxRefundAmountImplToJson(
        _$TokenWithMaxRefundAmountImpl instance) =>
    <String, dynamic>{
      'address': instance.address,
      'name': instance.name,
      'symbol': instance.symbol,
      'decimals': instance.decimals,
      'amount': instance.amount,
      'maxRefundAmount': instance.maxRefundAmount,
    };

_$TokenWithApproximateOperatingExpenseImpl
    _$$TokenWithApproximateOperatingExpenseImplFromJson(
            Map<String, dynamic> json) =>
        _$TokenWithApproximateOperatingExpenseImpl(
          address: json['address'] as String,
          name: json['name'] as String,
          symbol: json['symbol'] as String,
          decimals: json['decimals'] as int,
          amount: json['amount'] as String,
          approximateOperatingExpense:
              json['approximateOperatingExpense'] as String,
          mutatedWithOperatingExpense:
              json['mutatedWithOperatingExpense'] as bool,
        );

Map<String, dynamic> _$$TokenWithApproximateOperatingExpenseImplToJson(
        _$TokenWithApproximateOperatingExpenseImpl instance) =>
    <String, dynamic>{
      'address': instance.address,
      'name': instance.name,
      'symbol': instance.symbol,
      'decimals': instance.decimals,
      'amount': instance.amount,
      'approximateOperatingExpense': instance.approximateOperatingExpense,
      'mutatedWithOperatingExpense': instance.mutatedWithOperatingExpense,
    };

_$DstChainTokenOutResponseTypeImpl _$$DstChainTokenOutResponseTypeImplFromJson(
        Map<String, dynamic> json) =>
    _$DstChainTokenOutResponseTypeImpl(
      address: json['address'] as String,
      name: json['name'] as String,
      symbol: json['symbol'] as String,
      decimals: json['decimals'] as int,
      amount: json['amount'] as String,
      recommendedAmount: json['recommendedAmount'] as String,
      withoutAdditionalTakerRewardsAmount:
          json['withoutAdditionalTakerRewardsAmount'] as String?,
    );

Map<String, dynamic> _$$DstChainTokenOutResponseTypeImplToJson(
    _$DstChainTokenOutResponseTypeImpl instance) {
  final val = <String, dynamic>{
    'address': instance.address,
    'name': instance.name,
    'symbol': instance.symbol,
    'decimals': instance.decimals,
    'amount': instance.amount,
    'recommendedAmount': instance.recommendedAmount,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('withoutAdditionalTakerRewardsAmount',
      instance.withoutAdditionalTakerRewardsAmount);
  return val;
}

_$TxQuoteImpl _$$TxQuoteImplFromJson(Map<String, dynamic> json) =>
    _$TxQuoteImpl(
      allowanceTarget: json['allowanceTarget'] as String,
      allowanceValue: json['allowanceValue'] as String,
    );

Map<String, dynamic> _$$TxQuoteImplToJson(_$TxQuoteImpl instance) =>
    <String, dynamic>{
      'allowanceTarget': instance.allowanceTarget,
      'allowanceValue': instance.allowanceValue,
    };

_$OrderImpl _$$OrderImplFromJson(Map<String, dynamic> json) => _$OrderImpl(
      approximateFulfillmentDelay:
          (json['approximateFulfillmentDelay'] as num).toDouble(),
    );

Map<String, dynamic> _$$OrderImplToJson(_$OrderImpl instance) =>
    <String, dynamic>{
      'approximateFulfillmentDelay': instance.approximateFulfillmentDelay,
    };

_$DlnTxImpl _$$DlnTxImplFromJson(Map<String, dynamic> json) => _$DlnTxImpl(
      data: json['data'] as String,
      to: json['to'] as String?,
      value: json['value'] as String?,
      gasLimit: (json['gasLimit'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$DlnTxImplToJson(_$DlnTxImpl instance) {
  final val = <String, dynamic>{
    'data': instance.data,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('to', instance.to);
  writeNotNull('value', instance.value);
  writeNotNull('gasLimit', instance.gasLimit);
  return val;
}

_$OfferImpl _$$OfferImplFromJson(Map<String, dynamic> json) => _$OfferImpl(
      chainId: json['chainId'] as int,
      tokenAddress: json['tokenAddress'] as String,
      amount: json['amount'] as String,
    );

Map<String, dynamic> _$$OfferImplToJson(_$OfferImpl instance) =>
    <String, dynamic>{
      'chainId': instance.chainId,
      'tokenAddress': instance.tokenAddress,
      'amount': instance.amount,
    };

_$OrderStructImpl _$$OrderStructImplFromJson(Map<String, dynamic> json) =>
    _$OrderStructImpl(
      makerOrderNonce: json['makerOrderNonce'] as int,
      makerSrc: json['makerSrc'] as String,
      giveOffer: Offer.fromJson(json['giveOffer'] as Map<String, dynamic>),
      receiverDst: json['receiverDst'] as String,
      takeOffer: Offer.fromJson(json['takeOffer'] as Map<String, dynamic>),
      givePatchAuthoritySrc: json['givePatchAuthoritySrc'] as String,
      orderAuthorityAddressDst: json['orderAuthorityAddressDst'] as String,
      allowedTakerDst: json['allowedTakerDst'] as String?,
      allowedCancelBeneficiarySrc:
          json['allowedCancelBeneficiarySrc'] as String?,
      externalCall: json['externalCall'] as String?,
    );

Map<String, dynamic> _$$OrderStructImplToJson(_$OrderStructImpl instance) {
  final val = <String, dynamic>{
    'makerOrderNonce': instance.makerOrderNonce,
    'makerSrc': instance.makerSrc,
    'giveOffer': instance.giveOffer.toJson(),
    'receiverDst': instance.receiverDst,
    'takeOffer': instance.takeOffer.toJson(),
    'givePatchAuthoritySrc': instance.givePatchAuthoritySrc,
    'orderAuthorityAddressDst': instance.orderAuthorityAddressDst,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('allowedTakerDst', instance.allowedTakerDst);
  writeNotNull(
      'allowedCancelBeneficiarySrc', instance.allowedCancelBeneficiarySrc);
  writeNotNull('externalCall', instance.externalCall);
  return val;
}
