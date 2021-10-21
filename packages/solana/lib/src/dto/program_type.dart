import 'package:freezed_annotation/freezed_annotation.dart';

/// The program type of a transaction instruction
enum ProgramType {
  @JsonValue('system')
  system,
  @JsonValue('spl-memo')
  memo,
  @JsonValue('spl-token')
  splToken,
}
