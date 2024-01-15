// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fee_calculator_for_blockhash.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeeCalculatorForBlockhash _$FeeCalculatorForBlockhashFromJson(
        Map<String, dynamic> json) =>
    FeeCalculatorForBlockhash(
      feeCalculator:
          FeeCalculator.fromJson(json['feeCalculator'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FeeCalculatorForBlockhashToJson(
        FeeCalculatorForBlockhash instance) =>
    <String, dynamic>{
      'feeCalculator': instance.feeCalculator.toJson(),
    };

FeeCalculatorForBlockhashResult _$FeeCalculatorForBlockhashResultFromJson(
        Map<String, dynamic> json) =>
    FeeCalculatorForBlockhashResult(
      context: Context.fromJson(json['context'] as Map<String, dynamic>),
      value: json['value'] == null
          ? null
          : FeeCalculatorForBlockhash.fromJson(
              json['value'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FeeCalculatorForBlockhashResultToJson(
        FeeCalculatorForBlockhashResult instance) =>
    <String, dynamic>{
      'context': instance.context.toJson(),
      'value': instance.value?.toJson(),
    };
