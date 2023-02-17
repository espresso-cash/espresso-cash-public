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

FeeCalculatorForBlockhashResult _$FeeCalculatorForBlockhashResultFromJson(
        Map<String, dynamic> json) =>
    FeeCalculatorForBlockhashResult(
      context: Context.fromJson(json['context'] as Map<String, dynamic>),
      value: json['value'] == null
          ? null
          : FeeCalculatorForBlockhash.fromJson(
              json['value'] as Map<String, dynamic>),
    );
