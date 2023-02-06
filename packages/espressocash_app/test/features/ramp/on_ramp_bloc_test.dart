import 'package:bloc_test/bloc_test.dart';
import 'package:espressocash_app/core/tokens/token.dart';
import 'package:espressocash_app/features/ramp/src/bl/on_ramp_bloc.dart';
import 'package:espressocash_app/features/ramp/src/bl/repository.dart';
import 'package:solana/solana.dart';

void main() {
  late Wallet wallet;

  blocTest<OnRampBloc, OnRampState>(
    'Creates correct payment URL',
    setUp: () async => wallet = await Wallet.random(),
    build: () => OnRampBloc(
      repository: _ConstantAddFundsRepository(),
      token: Token.usdc,
      wallet: wallet,
    ),
    act: (bloc) => bloc.add(const OnRampEvent.moonpayRequested()),
    expect: () => [
      const OnRampState.processing(),
      const OnRampState.success('SIGNED_URL'),
    ],
  );

  blocTest<OnRampBloc, OnRampState>(
    'Emits failure state on signature error',
    setUp: () async => wallet = await Wallet.random(),
    build: () => OnRampBloc(
      repository: _ThrowAddFundsRepository(),
      token: Token.usdc,
      wallet: wallet,
    ),
    act: (bloc) => bloc.add(const OnRampEvent.moonpayRequested()),
    expect: () => [
      const OnRampState.processing(),
      OnRampState.failure(_testException),
    ],
  );
}

final _testException = Exception();

class _ConstantAddFundsRepository implements OnRampRepository {
  @override
  Future<String> signFundsRequest({
    required String address,
    required Token token,
  }) async =>
      'SIGNED_URL';
}

class _ThrowAddFundsRepository implements OnRampRepository {
  @override
  Future<String> signFundsRequest({
    required String address,
    required Token token,
  }) async {
    throw _testException;
  }
}
