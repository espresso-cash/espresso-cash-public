import 'package:freezed_annotation/freezed_annotation.dart';

part 'escrow_exception.freezed.dart';

@freezed
sealed class EscrowException with _$EscrowException implements Exception {
  const factory EscrowException.notReady() = _NotReady;
  const factory EscrowException.alreadyWithdrawn() = _AlreadyWithdrawn;
  const factory EscrowException.invalidEscrow() = _InvalidEscrow;
  const factory EscrowException.other() = _Other;
}
