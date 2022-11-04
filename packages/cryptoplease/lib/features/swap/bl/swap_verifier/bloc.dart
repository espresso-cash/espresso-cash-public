import 'package:cryptoplease/core/flow.dart';
import 'package:cryptoplease/core/transactions/resign_tx.dart';
import 'package:cryptoplease/core/transactions/tx_sender.dart';
import 'package:cryptoplease/features/swap/bl/swap_exception.dart';
import 'package:cryptoplease_api/cryptoplease_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

part 'bloc.freezed.dart';

@freezed
class SwapVerifierEvent with _$SwapVerifierEvent {
  const factory SwapVerifierEvent.create(JupiterRoute route) = SwapCreated;
}

typedef SwapVerifierState = Flow<SwapException, String>;

typedef _Event = SwapVerifierEvent;
typedef _State = SwapVerifierState;
typedef _Emitter = Emitter<_State>;

@injectable
class SwapVerifierBloc extends Bloc<_Event, _State> {
  SwapVerifierBloc({
    required CryptopleaseClient client,
    @factoryParam required Ed25519HDKeyPair account,
    required TxSender txSender,
  })  : _client = client,
        _account = account,
        _txSender = txSender,
        super(const SwapVerifierState.initial()) {
    on<_Event>(_handler);
  }

  final CryptopleaseClient _client;
  final Ed25519HDKeyPair _account;
  final TxSender _txSender;

  EventHandler<_Event, _State> get _handler => (event, emit) => event.map(
        create: (e) => _onCreate(e, emit),
      );

  Future<void> _onCreate(SwapCreated event, _Emitter _) async {
    try {
      final dto = SwapRequestDto(
        userPublicKey: _account.publicKey.toBase58(),
        route: event.route,
      );
      final tx = await _client
          .createSwapTransaction(dto)
          .then((r) => r.swapTransaction)
          .then(SignedTx.decode)
          .then((swap) => swap.resign(_account));

      final result = await _txSender.send(tx);
      final status = await _txSender.wait(tx.id);

      emit(SwapVerifierState.success(tx.id));
    } on Exception catch (e) {
      emit(SwapVerifierState.failure(SwapException.other(e)));
    }
  }
}
