// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_QuoteRequestDto _$$_QuoteRequestDtoFromJson(Map<String, dynamic> json) =>
    _$_QuoteRequestDto(
      srcChainId: json['srcChainId'] as String,
      srcChainTokenIn: json['srcChainTokenIn'] as String,
      srcChainTokenInAmount: json['srcChainTokenInAmount'] as String,
      dstChainId: json['dstChainId'] as String,
      dstChainTokenOut: json['dstChainTokenOut'] as String,
      dstChainTokenOutAmount: json['dstChainTokenOutAmount'] as String?,
      additionalTakerRewardBps: json['additionalTakerRewardBps'] as int?,
      srcIntermediaryTokenAddress:
          json['srcIntermediaryTokenAddress'] as String?,
      dstIntermediaryTokenAddress:
          json['dstIntermediaryTokenAddress'] as String?,
      dstIntermediaryTokenSpenderAddress:
          json['dstIntermediaryTokenSpenderAddress'] as String?,
      intermediaryTokenUSDPrice: json['intermediaryTokenUSDPrice'] as int?,
      slippage: json['slippage'] as int?,
      affiliateFeePercent: (json['affiliateFeePercent'] as num?)?.toDouble(),
      prependOperatingExpenses: json['prependOperatingExpenses'] as bool?,
    );

Map<String, dynamic> _$$_QuoteRequestDtoToJson(_$_QuoteRequestDto instance) {
  final val = <String, dynamic>{
    'srcChainId': instance.srcChainId,
    'srcChainTokenIn': instance.srcChainTokenIn,
    'srcChainTokenInAmount': instance.srcChainTokenInAmount,
    'dstChainId': instance.dstChainId,
    'dstChainTokenOut': instance.dstChainTokenOut,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('dstChainTokenOutAmount', instance.dstChainTokenOutAmount);
  writeNotNull('additionalTakerRewardBps', instance.additionalTakerRewardBps);
  writeNotNull(
      'srcIntermediaryTokenAddress', instance.srcIntermediaryTokenAddress);
  writeNotNull(
      'dstIntermediaryTokenAddress', instance.dstIntermediaryTokenAddress);
  writeNotNull('dstIntermediaryTokenSpenderAddress',
      instance.dstIntermediaryTokenSpenderAddress);
  writeNotNull('intermediaryTokenUSDPrice', instance.intermediaryTokenUSDPrice);
  writeNotNull('slippage', instance.slippage);
  writeNotNull('affiliateFeePercent', instance.affiliateFeePercent);
  writeNotNull('prependOperatingExpenses', instance.prependOperatingExpenses);
  return val;
}

_$_QuoteResponseDto _$$_QuoteResponseDtoFromJson(Map<String, dynamic> json) =>
    _$_QuoteResponseDto(
      estimation:
          OrderEstimation.fromJson(json['estimation'] as Map<String, dynamic>),
      prependedOperatingExpenseCost:
          json['prependedOperatingExpenseCost'] as String?,
      tx: TxQuote.fromJson(json['tx'] as Map<String, dynamic>),
      order: Order.fromJson(json['order'] as Map<String, dynamic>),
      fixFee: json['fixFee'] as String,
    );

Map<String, dynamic> _$$_QuoteResponseDtoToJson(_$_QuoteResponseDto instance) {
  final val = <String, dynamic>{
    'estimation': instance.estimation.toJson(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'prependedOperatingExpenseCost', instance.prependedOperatingExpenseCost);
  val['tx'] = instance.tx.toJson();
  val['order'] = instance.order.toJson();
  val['fixFee'] = instance.fixFee;
  return val;
}

_$_CreateTxRequestDto _$$_CreateTxRequestDtoFromJson(
        Map<String, dynamic> json) =>
    _$_CreateTxRequestDto(
      srcChainId: json['srcChainId'] as String,
      srcChainTokenIn: json['srcChainTokenIn'] as String,
      srcChainTokenInAmount: json['srcChainTokenInAmount'] as String,
      dstChainId: json['dstChainId'] as String,
      dstChainTokenOut: json['dstChainTokenOut'] as String,
      dstChainTokenOutRecipient: json['dstChainTokenOutRecipient'] as String,
      srcChainOrderAuthorityAddress:
          json['srcChainOrderAuthorityAddress'] as String,
      dstChainOrderAuthorityAddress:
          json['dstChainOrderAuthorityAddress'] as String,
      dstChainTokenOutAmount: json['dstChainTokenOutAmount'] as String?,
      additionalTakerRewardBps:
          (json['additionalTakerRewardBps'] as num?)?.toDouble(),
      srcIntermediaryTokenAddress:
          json['srcIntermediaryTokenAddress'] as String?,
      dstIntermediaryTokenAddress:
          json['dstIntermediaryTokenAddress'] as String?,
      dstIntermediaryTokenSpenderAddress:
          json['dstIntermediaryTokenSpenderAddress'] as String?,
      intermediaryTokenUSDPrice:
          (json['intermediaryTokenUSDPrice'] as num?)?.toDouble(),
      slippage: (json['slippage'] as num?)?.toDouble(),
      senderAddress: json['senderAddress'] as String?,
      referralCode: (json['referralCode'] as num?)?.toDouble(),
      affiliateFeePercent: (json['affiliateFeePercent'] as num?)?.toDouble(),
      affiliateFeeRecipient: json['affiliateFeeRecipient'] as String?,
      srcChainTokenInSenderPermit:
          json['srcChainTokenInSenderPermit'] as String?,
      enableEstimate: json['enableEstimate'] as bool?,
      allowedTaker: json['allowedTaker'] as String?,
      externalCall: json['externalCall'] as String?,
      prependOperatingExpenses: json['prependOperatingExpenses'] as bool?,
    );

Map<String, dynamic> _$$_CreateTxRequestDtoToJson(
    _$_CreateTxRequestDto instance) {
  final val = <String, dynamic>{
    'srcChainId': instance.srcChainId,
    'srcChainTokenIn': instance.srcChainTokenIn,
    'srcChainTokenInAmount': instance.srcChainTokenInAmount,
    'dstChainId': instance.dstChainId,
    'dstChainTokenOut': instance.dstChainTokenOut,
    'dstChainTokenOutRecipient': instance.dstChainTokenOutRecipient,
    'srcChainOrderAuthorityAddress': instance.srcChainOrderAuthorityAddress,
    'dstChainOrderAuthorityAddress': instance.dstChainOrderAuthorityAddress,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('dstChainTokenOutAmount', instance.dstChainTokenOutAmount);
  writeNotNull('additionalTakerRewardBps', instance.additionalTakerRewardBps);
  writeNotNull(
      'srcIntermediaryTokenAddress', instance.srcIntermediaryTokenAddress);
  writeNotNull(
      'dstIntermediaryTokenAddress', instance.dstIntermediaryTokenAddress);
  writeNotNull('dstIntermediaryTokenSpenderAddress',
      instance.dstIntermediaryTokenSpenderAddress);
  writeNotNull('intermediaryTokenUSDPrice', instance.intermediaryTokenUSDPrice);
  writeNotNull('slippage', instance.slippage);
  writeNotNull('senderAddress', instance.senderAddress);
  writeNotNull('referralCode', instance.referralCode);
  writeNotNull('affiliateFeePercent', instance.affiliateFeePercent);
  writeNotNull('affiliateFeeRecipient', instance.affiliateFeeRecipient);
  writeNotNull(
      'srcChainTokenInSenderPermit', instance.srcChainTokenInSenderPermit);
  writeNotNull('enableEstimate', instance.enableEstimate);
  writeNotNull('allowedTaker', instance.allowedTaker);
  writeNotNull('externalCall', instance.externalCall);
  writeNotNull('prependOperatingExpenses', instance.prependOperatingExpenses);
  return val;
}

_$_CreateTxResponseDto _$$_CreateTxResponseDtoFromJson(
        Map<String, dynamic> json) =>
    _$_CreateTxResponseDto(
      estimation:
          OrderEstimation.fromJson(json['estimation'] as Map<String, dynamic>),
      tx: DlnTx.fromJson(json['tx'] as Map<String, dynamic>),
      prependedOperatingExpenseCost:
          json['prependedOperatingExpenseCost'] as String?,
      order: Order.fromJson(json['order'] as Map<String, dynamic>),
      fixFee: json['fixFee'] as String,
    );

Map<String, dynamic> _$$_CreateTxResponseDtoToJson(
    _$_CreateTxResponseDto instance) {
  final val = <String, dynamic>{
    'estimation': instance.estimation.toJson(),
    'tx': instance.tx.toJson(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'prependedOperatingExpenseCost', instance.prependedOperatingExpenseCost);
  val['order'] = instance.order.toJson();
  val['fixFee'] = instance.fixFee;
  return val;
}

_$_OrderResponseDto _$$_OrderResponseDtoFromJson(Map<String, dynamic> json) =>
    _$_OrderResponseDto(
      orderId: json['orderId'] as String,
      status: json['status'] as String,
      externalCallState: json['externalCallState'] as String,
      orderStruct:
          OrderStruct.fromJson(json['orderStruct'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_OrderResponseDtoToJson(_$_OrderResponseDto instance) =>
    <String, dynamic>{
      'orderId': instance.orderId,
      'status': instance.status,
      'externalCallState': instance.externalCallState,
      'orderStruct': instance.orderStruct.toJson(),
    };

_$_OrderStatusResponseDto _$$_OrderStatusResponseDtoFromJson(
        Map<String, dynamic> json) =>
    _$_OrderStatusResponseDto(
      orderId: json['orderId'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$$_OrderStatusResponseDtoToJson(
        _$_OrderStatusResponseDto instance) =>
    <String, dynamic>{
      'orderId': instance.orderId,
      'status': instance.status,
    };

_$_OrderIdTxResponseDto _$$_OrderIdTxResponseDtoFromJson(
        Map<String, dynamic> json) =>
    _$_OrderIdTxResponseDto(
      orderIds:
          (json['orderIds'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$_OrderIdTxResponseDtoToJson(
        _$_OrderIdTxResponseDto instance) =>
    <String, dynamic>{
      'orderIds': instance.orderIds,
    };

_$_CancelTxResponseDto _$$_CancelTxResponseDtoFromJson(
        Map<String, dynamic> json) =>
    _$_CancelTxResponseDto(
      to: json['to'] as String,
      data: json['data'] as String,
      value: json['value'] as String,
      chainId: (json['chainId'] as num).toDouble(),
      from: json['from'] as String,
      cancelBeneficiary: json['cancelBeneficiary'] as String?,
    );

Map<String, dynamic> _$$_CancelTxResponseDtoToJson(
    _$_CancelTxResponseDto instance) {
  final val = <String, dynamic>{
    'to': instance.to,
    'data': instance.data,
    'value': instance.value,
    'chainId': instance.chainId,
    'from': instance.from,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('cancelBeneficiary', instance.cancelBeneficiary);
  return val;
}
