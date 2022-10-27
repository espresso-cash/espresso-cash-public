import 'package:bloc_test/bloc_test.dart';
import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease/features/add_funds/bl/add_funds_bloc.dart';
import 'package:cryptoplease/features/add_funds/bl/repository.dart';
import 'package:solana/solana.dart';

void main() {
  late Wallet wallet;

  blocTest<AddFundsBloc, AddFundsState>(
    'Creates correct payment URL',
    setUp: () async => wallet = await Wallet.random(),
    build: () => AddFundsBloc(
      repository: _ConstantAddFundsRepository(),
      token: Token.usdc,
      wallet: wallet,
    ),
    act: (bloc) => bloc.add(const AddFundsEvent.moonpayRequested()),
    expect: () => [
      const AddFundsState.processing(),
      const AddFundsState.success('SIGNED_URL'),
    ],
  );

  blocTest<AddFundsBloc, AddFundsState>(
    'Emits failure state on signature error',
    setUp: () async => wallet = await Wallet.random(),
    build: () => AddFundsBloc(
      repository: _ThrowAddFundsRepository(),
      token: Token.usdc,
      wallet: wallet,
    ),
    act: (bloc) => bloc.add(const AddFundsEvent.moonpayRequested()),
    expect: () => [
      const AddFundsState.processing(),
      AddFundsState.failure(_testException),
    ],
  );
}

final _testException = Exception();

class _ConstantAddFundsRepository implements AddFundsRepository {
  @override
  Future<String> signFundsRequest({
    required String address,
    required Token token,
  }) async =>
      'SIGNED_URL';
}

class _ThrowAddFundsRepository implements AddFundsRepository {
  @override
  Future<String> signFundsRequest({
    required String address,
    required Token token,
  }) async {
    throw _testException;
  }
}
