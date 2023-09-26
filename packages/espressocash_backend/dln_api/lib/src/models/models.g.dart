// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_OrderEstimation _$$_OrderEstimationFromJson(Map<String, dynamic> json) =>
    _$_OrderEstimation(
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

Map<String, dynamic> _$$_OrderEstimationToJson(_$_OrderEstimation instance) {
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

_$_TokenWithMaxRefundAmount _$$_TokenWithMaxRefundAmountFromJson(
        Map<String, dynamic> json) =>
    _$_TokenWithMaxRefundAmount(
      address: json['address'] as String,
      name: json['name'] as String,
      symbol: json['symbol'] as String,
      decimals: json['decimals'] as int,
      amount: json['amount'] as String,
      maxRefundAmount: json['maxRefundAmount'] as String,
    );

Map<String, dynamic> _$$_TokenWithMaxRefundAmountToJson(
        _$_TokenWithMaxRefundAmount instance) =>
    <String, dynamic>{
      'address': instance.address,
      'name': instance.name,
      'symbol': instance.symbol,
      'decimals': instance.decimals,
      'amount': instance.amount,
      'maxRefundAmount': instance.maxRefundAmount,
    };

_$_TokenWithApproximateOperatingExpense
    _$$_TokenWithApproximateOperatingExpenseFromJson(
            Map<String, dynamic> json) =>
        _$_TokenWithApproximateOperatingExpense(
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

Map<String, dynamic> _$$_TokenWithApproximateOperatingExpenseToJson(
        _$_TokenWithApproximateOperatingExpense instance) =>
    <String, dynamic>{
      'address': instance.address,
      'name': instance.name,
      'symbol': instance.symbol,
      'decimals': instance.decimals,
      'amount': instance.amount,
      'approximateOperatingExpense': instance.approximateOperatingExpense,
      'mutatedWithOperatingExpense': instance.mutatedWithOperatingExpense,
    };

_$_DstChainTokenOutResponseType _$$_DstChainTokenOutResponseTypeFromJson(
        Map<String, dynamic> json) =>
    _$_DstChainTokenOutResponseType(
      address: json['address'] as String,
      name: json['name'] as String,
      symbol: json['symbol'] as String,
      decimals: json['decimals'] as int,
      amount: json['amount'] as String,
      recommendedAmount: json['recommendedAmount'] as String,
      withoutAdditionalTakerRewardsAmount:
          json['withoutAdditionalTakerRewardsAmount'] as String?,
    );

Map<String, dynamic> _$$_DstChainTokenOutResponseTypeToJson(
    _$_DstChainTokenOutResponseType instance) {
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

_$_TxQuote _$$_TxQuoteFromJson(Map<String, dynamic> json) => _$_TxQuote(
      allowanceTarget: json['allowanceTarget'] as String,
      allowanceValue: json['allowanceValue'] as String,
    );

Map<String, dynamic> _$$_TxQuoteToJson(_$_TxQuote instance) =>
    <String, dynamic>{
      'allowanceTarget': instance.allowanceTarget,
      'allowanceValue': instance.allowanceValue,
    };

_$_Order _$$_OrderFromJson(Map<String, dynamic> json) => _$_Order(
      approximateFulfillmentDelay:
          (json['approximateFulfillmentDelay'] as num).toDouble(),
    );

Map<String, dynamic> _$$_OrderToJson(_$_Order instance) => <String, dynamic>{
      'approximateFulfillmentDelay': instance.approximateFulfillmentDelay,
    };

_$_DlnTx _$$_DlnTxFromJson(Map<String, dynamic> json) => _$_DlnTx(
      data: json['data'] as String,
      to: json['to'] as String?,
      value: json['value'] as String?,
      gasLimit: (json['gasLimit'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$_DlnTxToJson(_$_DlnTx instance) {
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

_$_Offer _$$_OfferFromJson(Map<String, dynamic> json) => _$_Offer(
      chainId: json['chainId'] as int,
      tokenAddress: json['tokenAddress'] as String,
      amount: json['amount'] as String,
    );

Map<String, dynamic> _$$_OfferToJson(_$_Offer instance) => <String, dynamic>{
      'chainId': instance.chainId,
      'tokenAddress': instance.tokenAddress,
      'amount': instance.amount,
    };

_$_OrderStruct _$$_OrderStructFromJson(Map<String, dynamic> json) =>
    _$_OrderStruct(
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

Map<String, dynamic> _$$_OrderStructToJson(_$_OrderStruct instance) {
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
