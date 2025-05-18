import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:solana/src/rpc/helpers.dart';

part 'context.freezed.dart';

part 'context.g.dart';

class ContextResult<T> {
  const ContextResult({required this.context, required this.value});

  final Context context;
  final T value;
}

@freezed
class Context with _$Context {
  const factory Context({@JsonKey(fromJson: bigIntFromJson) required BigInt slot}) = _Context;

  factory Context.fromJson(Map<String, dynamic> json) => _$ContextFromJson(json);
}
