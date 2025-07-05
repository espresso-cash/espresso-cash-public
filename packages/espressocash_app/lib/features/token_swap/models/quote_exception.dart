import 'package:freezed_annotation/freezed_annotation.dart';

part 'quote_exception.freezed.dart';

@Freezed(when: FreezedWhenOptions.none, map: FreezedMapOptions.none)
sealed class QuoteException with _$QuoteException implements Exception {
  const factory QuoteException.routeNotFound() = QuoteRouteNotFoundException;

  const factory QuoteException.rateLimitExceeded() = QuoteRateLimitExceededException;

  const factory QuoteException.generic() = QuoteGenericException;

  const QuoteException._();
}
