import 'package:bloc_test/bloc_test.dart';
import 'package:cryptoplease/core/amount.dart';
import 'package:cryptoplease/core/currency.dart';
import 'package:cryptoplease/features/add_funds/bl/add_funds_bloc.dart';

void main() {
  final testException = Exception();

  blocTest<AddFundsBloc, AddFundsState>(
    'Creates correct payment URL',
    build: () => AddFundsBloc(
      signRequest: (address, amount) async => 'SIGNED_URL',
    ),
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
    build: () => AddFundsBloc(
      signRequest: (address, amount) async => throw testException,
    ),
    act: (bloc) => bloc.add(
      AddFundsEvent.urlRequested(
        walletAddress: 'walletAddress',
        amount: Amount.zero(currency: Currency.sol),
      ),
    ),
    expect: () => [
      const AddFundsState.processing(),
      AddFundsState.failure(testException),
    ],
  );
}
