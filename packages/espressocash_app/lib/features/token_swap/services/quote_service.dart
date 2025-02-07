import 'dart:async';

import 'package:decimal/decimal.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../accounts/auth_scope.dart';
import '../../accounts/models/ec_wallet.dart';
import '../../currency/models/amount.dart';
import '../../currency/models/currency.dart';
import '../../tokens/token.dart';
import '../data/route_repository.dart';
import '../models/swap_seed.dart';

@Singleton(scope: authScope)
class QuoteService extends ValueNotifier<SwapQuote?> {
  QuoteService(this._repository, this._wallet) : super(null);

  final RouteRepository _repository;
  final ECWallet _wallet;

  static const _quoteValidityDuration = Duration(seconds: 15);

  Timer? _refreshTimer;
  Timer? _debounceTimer;

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
          output: Amount.zero(
            currency: CryptoCurrency(token: outputToken),
          ) as CryptoAmount,
          input: inputAmount,
          slippage: slippage,
          // TODO: make nullable
          platformFeeBps: 0,
          priceImpact: '0',
          providerLabel: '0',
        ),
      ),
    );
  }

  Future<void> _handleInputChanged(SwapSeed input) async {
    _refreshTimer?.cancel();

    if (input.input.decimal == Decimal.zero) {
      value = null;

      return;
    }

    await _fetchQuote(input);

    _refreshTimer = Timer.periodic(_quoteValidityDuration, (_) {
      _fetchQuote(input);
    });
  }

  Future<void> _fetchQuote(SwapSeed input) async {
    try {
      final quote = await _repository.findRoute(
        seed: input,
        userPublicKey: _wallet.address,
      );

      value = SwapQuote(
        input: quote.seed.input,
        output: quote.seed.output,
        fee: quote.fee,
        expiresAt: DateTime.now().add(_quoteValidityDuration),
      );
    } catch (e) {
      //TODO
      value = null;
    }
    notifyListeners();
  }

  void clear() {
    _refreshTimer?.cancel();
    _debounceTimer?.cancel();
    value = null;
  }

  @override
  @disposeMethod
  void dispose() {
    _refreshTimer?.cancel();
    _debounceTimer?.cancel();

    super.dispose();
  }
}

class SwapQuote {
  const SwapQuote({
    required this.input,
    required this.output,
    required this.fee,
    required this.expiresAt,
  });

  final CryptoAmount input;
  final CryptoAmount output;
  final CryptoAmount fee;
  final DateTime expiresAt;
}
