import 'package:bloc_test/bloc_test.dart';
import 'package:cryptoplease/core/amount.dart';
import 'package:cryptoplease/core/currency.dart';
import 'package:cryptoplease/features/add_funds/bl/add_funds_bloc.dart';
import 'package:cryptoplease/features/add_funds/bl/repository.dart';

void main() {
  blocTest<AddFundsBloc, AddFundsState>(
    'Creates correct payment URL',
    build: () => AddFundsBloc(repository: _ConstantAddFundsRepository()),
    act: (bloc) => bloc.add(
      AddFundsEvent.urlRequested(
        walletAddress: 'walletAddress',
        amount: Amount.zero(currency: Currency.sol),
      ),
    ),
    expect: () => [
      const AddFundsState.processing(),
      const AddFundsState.success('SIGNED_URL'),
    ],
  );

  blocTest<AddFundsBloc, AddFundsState>(
    'Emits failure state on signature error',
    build: () => AddFundsBloc(repository: _ThrowAddFundsRepository()),
    act: (bloc) => bloc.add(
      AddFundsEvent.urlRequested(
        walletAddress: 'walletAddress',
        amount: Amount.zero(currency: Currency.sol),
      ),
    ),
    expect: () => [
      const AddFundsState.processing(),
      AddFundsState.failure(_testException),
    ],
  );
}

final _testException = Exception();

class _ConstantAddFundsRepository implements AddFundsRepository {
  @override
  Future<String> signFundsRequest(
    String address,
    Amount amount,
  ) async =>
      'SIGNED_URL';
}

class _ThrowAddFundsRepository implements AddFundsRepository {
  @override
  Future<String> signFundsRequest(
    String address,
    Amount amount,
  ) async {
    throw _testException;
  }
}
