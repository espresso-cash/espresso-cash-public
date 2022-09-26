import 'package:bloc_test/bloc_test.dart';
import 'package:cryptoplease/core/amount.dart';
import 'package:cryptoplease/core/currency.dart';
import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease/features/add_funds/bl/add_funds_bloc.dart';
import 'package:cryptoplease/features/add_funds/bl/add_funds_quote.dart';
import 'package:cryptoplease/features/add_funds/bl/repository.dart';

void main() {
  blocTest<AddFundsBloc, AddFundsState>(
    'Updates amount correctly',
    build: () => AddFundsBloc(repository: _ConstantAddFundsRepository()),
    act: (bloc) => bloc.add(const AddFundsEvent.initialized()),
    wait: _debouceTime,
    expect: () => [
      const AddFundsState.initialized(
        inputAmount: FiatAmount(currency: Currency.usd, value: 0),
        minAmount: FiatAmount(currency: Currency.usd, value: 0),
      ),
    ],
  );

  blocTest<AddFundsBloc, AddFundsState>(
    'Creates correct payment URL',
    build: () => AddFundsBloc(repository: _ConstantAddFundsRepository()),
    act: (bloc) async {
      bloc.add(const AddFundsEvent.initialized());
      await Future<void>.delayed(_debouceTime);
      bloc.add(const AddFundsEvent.urlRequested(walletAddress: 'address'));
    },
    wait: _debouceTime,
    expect: () => [
      const AddFundsState.initialized(
        inputAmount: FiatAmount(currency: Currency.usd, value: 0),
        minAmount: FiatAmount(currency: Currency.usd, value: 0),
      ),
      const AddFundsState.loading(),
      const AddFundsState.success('SIGNED_URL'),
    ],
  );

  blocTest<AddFundsBloc, AddFundsState>(
    'Emits failure state on signature error',
    build: () => AddFundsBloc(repository: _ThrowAddFundsRepository()),
    act: (bloc) async {
      bloc.add(const AddFundsEvent.initialized());
      await Future<void>.delayed(_debouceTime);
      bloc.add(const AddFundsEvent.urlRequested(walletAddress: 'address'));
    },
    wait: _debouceTime,
    expect: () => [
      const AddFundsState.initialized(
        inputAmount: FiatAmount(currency: Currency.usd, value: 0),
        minAmount: FiatAmount(currency: Currency.usd, value: 0),
      ),
      const AddFundsState.loading(),
      const AddFundsState.failure(),
    ],
  );
}

const _debouceTime = Duration(milliseconds: 600);

final _testException = Exception();

class _ConstantAddFundsRepository implements AddFundsRepository {
  @override
  Future<String> signFundsRequest({
    required String address,
    required Amount amount,
    required Token quoteToken,
  }) async =>
      'SIGNED_URL';

  @override
  Future<FiatAmount> fetchLimit({
    required Token quoteToken,
  }) async =>
      const FiatAmount(currency: Currency.usd, value: 0);

  @override
  Future<AddFundsQuote> fetchBuyQuote({
    required Token quoteToken,
    required FiatAmount amount,
  }) async =>
      AddFundsQuote(
        buyAmount: CryptoAmount(
          value: 0,
          currency: CryptoCurrency(token: quoteToken),
        ),
      );
}

class _ThrowAddFundsRepository implements AddFundsRepository {
  @override
  Future<String> signFundsRequest({
    required String address,
    required Amount amount,
    required Token quoteToken,
  }) async =>
      throw _testException;

  @override
  Future<FiatAmount> fetchLimit({
    required Token quoteToken,
  }) async =>
      const FiatAmount(currency: Currency.usd, value: 0);

  @override
  Future<AddFundsQuote> fetchBuyQuote({
    required Token quoteToken,
    required FiatAmount amount,
  }) async =>
      throw _testException;
}
