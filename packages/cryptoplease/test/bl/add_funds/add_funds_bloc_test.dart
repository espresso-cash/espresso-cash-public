import 'package:bloc_test/bloc_test.dart';
import 'package:cryptoplease/bl/add_funds/add_funds_bloc.dart';
import 'package:decimal/decimal.dart';

void main() {
  final testException = Exception();

  blocTest<AddFundsBloc, AddFundsState>(
    'Creates correct payment URL',
    build: () => AddFundsBloc(
      signRequest: (address, value) async => 'SIGNED_URL',
    ),
    act: (bloc) => bloc.add(
      AddFundsEvent.urlRequested(
        walletAddress: 'walletAddress',
        value: Decimal.one,
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
      signRequest: (address, value) async => throw testException,
    ),
    act: (bloc) => bloc.add(
      AddFundsEvent.urlRequested(
        walletAddress: 'walletAddress',
        value: Decimal.one,
      ),
    ),
    expect: () => [
      const AddFundsState.processing(),
      AddFundsState.failure(testException),
    ],
  );
}
