// ignore_for_file: no-object-declaration

import 'package:json_annotation/json_annotation.dart';

part 'logs.g.dart';

/// Logs entry
@JsonSerializable()
class Logs {
  const Logs({
    required this.signature,
    required this.logs,
    required this.err,
  });

  factory Logs.fromJson(Map<String, dynamic> json) => _$LogsFromJson(json);

  final String signature;
  final Object? err;
  final List<String> logs;
}
