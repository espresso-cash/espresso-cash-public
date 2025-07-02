// ignore_for_file: avoid-type-casts

import 'dart:async';

import 'package:decimal/decimal.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../../utils/flow.dart';
import '../../accounts/auth_scope.dart';
import '../../currency/models/amount.dart';
import '../../currency/models/currency.dart';
import '../../tokens/token.dart';
import '../data/route_repository.dart';
import '../models/quote_exception.dart';
import '../models/swap_route.dart';
import '../models/swap_seed.dart';

typedef QuoteState = Flow<QuoteException, SwapRoute>;

@Singleton(scope: authScope)
class QuoteService extends ValueNotifier<QuoteState> {
  QuoteService(this._repository) : super(const Flow.initial());

  final RouteRepository _repository;

  static const _quoteValidityDuration = Duration(seconds: 15);

  Timer? _refreshTimer;
  Timer? _debounceTimer;
  SwapSeed? _currentSeed;

  DateTime? _expiresAt;

  DateTime? get expiresAt => _expiresAt;

  void updateInput({
    required CryptoAmount inputAmount,
    required Token outputToken,
    required Slippage slippage,
  }) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(
      const Duration(milliseconds: 500),
      () => _handleInputChanged(
        SwapSeed(
          output: Amount.zero(currency: CryptoCurrency(token: outputToken)) as CryptoAmount,
          input: inputAmount,
          slippage: slippage,
        ),
      ),
    );
  }

  Future<void> _handleInputChanged(SwapSeed input) async {
    _refreshTimer?.cancel();
    _refreshTimer = null;

    if (input.input.decimal == Decimal.zero) {
      value = const Flow.initial();
      _currentSeed = null;

      return;
    }

    _currentSeed = input;
    await _fetchQuote(input);

    if (_currentSeed == input) {
      _refreshTimer = Timer.periodic(_quoteValidityDuration, (_) {
        if (_currentSeed == input && !value.isProcessing) {
          _fetchQuote(input);
        }
      });
    }
  }

  Future<void> _fetchQuote(SwapSeed input) async {
    if (value.isProcessing) {
      return;
    }

    value = const Flow.processing();

    try {
      if (_currentSeed == input) {
        final route = await _repository.findRoute(seed: input);
        _expiresAt = DateTime.now().add(_quoteValidityDuration);
        value = Flow.success(route);
      }
    } on Exception catch (error) {
      if (_currentSeed == input) {
        final quoteError = _mapError(error);
        value = Flow.failure(quoteError);
      }
    }
  }

  QuoteException _mapError(Exception error) {
    final errorStr = error.toString().toLowerCase();
    if (errorStr.contains('no_routes_found') || errorStr.contains('could_not_find_any_route')) {
      return const QuoteException.routeNotFound();
    }

    return errorStr.contains('rate limit') || errorStr.contains('too many requests')
        ? const QuoteException.rateLimitExceeded()
        : const QuoteException.generic();
  }

  void clear() {
    _refreshTimer?.cancel();
    _refreshTimer = null;
    _debounceTimer?.cancel();
    _currentSeed = null;
    value = const Flow.initial();
  }

  @override
  @disposeMethod
  void dispose() {
    super.dispose();

    _refreshTimer?.cancel();
    _debounceTimer?.cancel();
    _currentSeed = null;
  }
}
