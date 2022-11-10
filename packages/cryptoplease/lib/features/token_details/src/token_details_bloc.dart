import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../core/flow.dart';
import '../../../core/tokens/token.dart';
import '../src/repository.dart';
import 'token_details.dart';

part 'token_details_bloc.freezed.dart';

typedef _Event = TokenDetailEvent;
typedef _State = TokenDetailsState;
typedef _EventHandler = EventHandler<_Event, _State>;
typedef _Emitter = Emitter<_State>;

@injectable
class TokenDetailsBloc extends Bloc<_Event, _State> {
  TokenDetailsBloc({
    @factoryParam required this.token,
    required TokenDetailsRepository repository,
  })  : _repository = repository,
        super(const Flow.initial()) {
    on<_Event>(_eventHandler, transformer: droppable());
  }

  final Token token;

  final TokenDetailsRepository _repository;

  _EventHandler get _eventHandler => (event, emit) => event.map(
        infoRequested: (event) => _onRefreshRequested(event, emit),
      );

  Future<void> _onRefreshRequested(_, _Emitter emit) async {
    emit(const Flow.processing());

    final _State newState = await _repository
        .getTokenDetails(token)
        .foldAsync(Flow.failure, Flow.success);

    emit(newState);
  }
}

@freezed
class TokenDetailEvent with _$TokenDetailEvent {
  const factory TokenDetailEvent.infoRequested() = FetchDetailsRequested;
}

typedef TokenDetailsState = Flow<Exception, TokenDetails>;
