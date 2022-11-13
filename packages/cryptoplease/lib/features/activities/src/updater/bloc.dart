import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:solana/solana.dart';

import '../../../../core/processing_state.dart';
import 'tx_updater_repository.dart';

part 'bloc.freezed.dart';

typedef _Event = TxUpdaterEvent;
typedef _State = TxUpdaterState;
typedef _EventHandler = EventHandler<_Event, _State>;
typedef _Emitter = Emitter<_State>;

@injectable
class TxUpdaterBloc extends Bloc<_Event, _State> {
  TxUpdaterBloc({
    @factoryParam required Wallet wallet,
    required TxUpdaterRepository fetchedRepository,
  })  : _wallet = wallet,
        _fetchedRepository = fetchedRepository,
        super(const TxUpdaterState.none()) {
    on<_Event>(
      _handler,
      transformer: (events, mapper) => sequential<TxUpdaterEvent>().call(
        droppable<TxUpdaterEvent>()
            .call(events.where((event) => event is _Fetch), mapper)
            .mergeWith([events.where((event) => event is _Clear)]),
        mapper,
      ),
    );
  }

  final Wallet _wallet;
  final TxUpdaterRepository _fetchedRepository;

  _EventHandler get _handler => (event, emit) => event.map(
        fetch: (e) => _onFetch(e, emit),
        clear: (e) => _onClear(e, emit),
      );

  Future<void> _onFetch(_Fetch _, _Emitter emit) async {
    emit(const TxUpdaterState.processing());

    try {
      await _fetchedRepository.update(_wallet.publicKey);

      emit(const TxUpdaterState.none());
    } on Exception catch (e) {
      emit(TxUpdaterState.error(e));
      emit(const TxUpdaterState.none());
    }
  }

  Future<void> _onClear(_Clear _, _Emitter __) async {
    await _fetchedRepository.clear();
  }
}

typedef TxUpdaterState = ProcessingState<Exception>;

@freezed
class TxUpdaterEvent with _$TxUpdaterEvent {
  const factory TxUpdaterEvent.fetch() = _Fetch;
  const factory TxUpdaterEvent.clear() = _Clear;
}

extension TransactionBlocExt on TxUpdaterBloc {
  Future<void> update() {
    add(const TxUpdaterEvent.fetch());

    return stream.firstWhere((s) => s is ProcessingStateNone);
  }
}
