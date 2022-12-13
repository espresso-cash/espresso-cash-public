import 'package:dfunc/dfunc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/transactions/resign_tx.dart';
import '../../../../core/transactions/tx_sender.dart';
import '../../module.dart';
import '../route_repository.dart';
import '../swap.dart';
import '../swap_route.dart';
import '../swap_seed.dart';

part 'swap_bloc.freezed.dart';

@freezed
class SwapEvent with _$SwapEvent {
  const factory SwapEvent.create(SwapRoute route) = _SwapCreated;
  const factory SwapEvent.process(String id) = _SwapProcess;
}

typedef SwapState = ISet<String>;

typedef _Event = SwapEvent;
typedef _State = SwapState;
typedef _Emitter = Emitter<_State>;

@injectable
class SwapBloc extends Bloc<_Event, _State> {
  SwapBloc({
    required SwapRepository swapRepository,
    required RouteRepository routeRepository,
    required TxSender txSender,
    @factoryParam required Wallet wallet,
  })  : _txSender = txSender,
        _swapRepository = swapRepository,
        _routeRepository = routeRepository,
        _wallet = wallet,
        super(const ISetConst({})) {
    on<_Event>(_handler);
  }

  final TxSender _txSender;
  final SwapRepository _swapRepository;
  final RouteRepository _routeRepository;
  final Wallet _wallet;

  EventHandler<_Event, _State> get _handler => (event, emit) => event.map(
        create: (e) => _onCreate(e, emit),
        process: (e) => _onProcess(e, emit),
      );

  Future<void> _onCreate(_SwapCreated event, _Emitter _) async {
    final status = await _createTx(event.route.encodedTx);
    final swap = Swap(
      id: const Uuid().v4(),
      created: DateTime.now(),
      status: status,
      seed: event.route.seed,
    );

    await _swapRepository.save(swap);

    add(SwapEvent.process(swap.id));
  }

  Future<void> _onProcess(_SwapProcess event, _Emitter emit) async {
    final swap = await _swapRepository.load(event.id);

    if (swap == null) return;
    if (state.contains(swap.id)) return;

    emit(state.add(swap.id));

    final SwapStatus newStatus = await swap.status.map(
      txCreated: (status) => _sendTx(status.tx),
      txSent: (status) => _waitTx(status.tx),
      success: (status) async => status,
      txFailure: (_) async => _reCreateTx(swap.seed),
      txSendFailure: (status) => _sendTx(status.tx),
      txWaitFailure: (status) => _waitTx(status.tx),
    );

    await _swapRepository.save(swap.copyWith(status: newStatus));

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

  Future<SwapStatus> _reCreateTx(SwapSeed seed) async {
    try {
      final route = await _routeRepository.findRoute(
        seed: seed,
        userPublickKey: _wallet.address,
      );

      return _createTx(route.encodedTx);
    } on Exception {
      return const SwapStatus.txFailure();
    }
  }

  Future<SwapStatus> _createTx(String encodedTx) async {
    try {
      return SwapStatus.txCreated(
        await SignedTx.decode(encodedTx).resign(_wallet),
      );
    } on Exception {
      return const SwapStatus.txFailure();
    }
  }

  Future<SwapStatus> _sendTx(SignedTx tx) async {
    final result = await _txSender.send(tx);

    return result.map(
      sent: (_) => SwapStatus.txSent(tx),
      invalidBlockhash: (_) => const SwapStatus.txFailure(),
      failure: (_) => const SwapStatus.txFailure(),
      networkError: (_) => SwapStatus.txSendFailure(tx),
    );
  }

  Future<SwapStatus> _waitTx(SignedTx tx) async {
    final result = await _txSender.wait(tx);

    return result.map(
      success: (_) => SwapStatus.success(txId: tx.id),
      failure: (_) => const SwapStatus.txFailure(),
      networkError: (_) => SwapStatus.txWaitFailure(tx),
    );
  }
}
