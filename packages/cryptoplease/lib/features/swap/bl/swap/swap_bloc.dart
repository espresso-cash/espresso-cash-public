import 'package:cryptoplease/core/transactions/resign_tx.dart';
import 'package:cryptoplease/core/transactions/tx_sender.dart';
import 'package:cryptoplease/features/swap/bl/swap.dart';
import 'package:cryptoplease/features/swap/bl/swap/swap_repository.dart';
import 'package:cryptoplease_api/cryptoplease_api.dart';
import 'package:dfunc/dfunc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';
import 'package:uuid/uuid.dart';

part 'swap_bloc.freezed.dart';

@freezed
class SwapEvent with _$SwapEvent {
  const factory SwapEvent.create(JupiterRoute route) = _SwapCreated;
  const factory SwapEvent.process(String id) = _SwapProcess;
}

typedef SwapState = ISet<String>;

typedef _Event = SwapEvent;
typedef _State = SwapState;
typedef _Emitter = Emitter<_State>;

@injectable
class SwapBloc extends Bloc<_Event, _State> {
  SwapBloc({
    required CryptopleaseClient client,
    required SwapRepository repository,
    @factoryParam required Ed25519HDKeyPair account,
    required TxSender txSender,
  })  : _client = client,
        _account = account,
        _txSender = txSender,
        _repository = repository,
        super(const ISetConst({})) {
    on<_Event>(_handler);
  }

  final CryptopleaseClient _client;
  final Ed25519HDKeyPair _account;
  final TxSender _txSender;
  final SwapRepository _repository;

  EventHandler<_Event, _State> get _handler => (event, emit) => event.map(
        create: (e) => _onCreate(e, emit),
        process: (e) => _onProcess(e, emit),
      );

  Future<void> _onCreate(_SwapCreated event, _Emitter _) async {
    final status = await _createTx(event.route);
    final swap = Swap(
      id: const Uuid().v4(),
      created: DateTime.now(),
      status: status,
    );

    await _repository.save(swap);

    if (status is SwapStatusTxCreated) {
      add(SwapEvent.process(swap.id));
    }
  }

  Future<void> _onProcess(_SwapProcess event, _Emitter emit) async {
    final swap = await _repository.load(event.id);

    if (swap == null) return;
    if (state.contains(swap.id)) return;

    emit(state.add(swap.id));

    final SwapStatus newStatus = await swap.status.map(
      txCreated: (status) => _sendTx(status.tx),
      txSent: (status) => _waitTx(status.txId),
      success: (status) async => status,
      txFailure: (status) async => status,
      txSendFailure: (status) => _sendTx(status.tx),
      txWaitFailure: (status) => _waitTx(status.txId),
    );

    await _repository.save(swap.copyWith(status: newStatus));

    emit(state.remove(swap.id));

    newStatus.map(
      txCreated: (_) => add(SwapEvent.process(swap.id)),
      txSent: (_) => add(SwapEvent.process(swap.id)),
      success: ignore,
      txFailure: ignore,
      txSendFailure: ignore,
      txWaitFailure: ignore,
    );
  }

  Future<SwapStatus> _createTx(JupiterRoute route) async {
    try {
      final dto = SwapRequestDto(
        userPublicKey: _account.publicKey.toBase58(),
        route: route,
      );
      final tx = await _client
          .createSwapTransaction(dto)
          .then((r) => r.swapTransaction)
          .then(SignedTx.decode)
          .then((swap) => swap.resign(_account));

      return SwapStatus.txCreated(tx);
    } on Exception {
      return const SwapStatus.txFailure();
    }
  }

  Future<SwapStatus> _sendTx(SignedTx tx) async {
    final result = await _txSender.send(tx);

    return result.map(
      sent: (_) => SwapStatus.txSent(tx.id),
      invalidBlockhash: (_) => const SwapStatus.txFailure(),
      failure: (_) => const SwapStatus.txFailure(),
      networkError: (_) => SwapStatus.txSendFailure(tx),
    );
  }

  Future<SwapStatus> _waitTx(String txId) async {
    final result = await _txSender.wait(txId);

    return result.map(
      success: (_) => SwapStatus.success(txId: txId),
      failure: (_) => const SwapStatus.txFailure(),
      networkError: (_) => SwapStatus.txWaitFailure(txId),
    );
  }
}
