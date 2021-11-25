// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
      signatures: (json['signatures'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      message: Message.fromJson(json['message'] as Map<String, dynamic>),
    );
