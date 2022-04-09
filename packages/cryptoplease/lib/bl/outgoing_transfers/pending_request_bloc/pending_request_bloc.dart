import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/solana_pay.dart';

part 'pending_request_event.dart';
part 'pending_request_state.dart';

part 'pending_request_bloc.freezed.dart';

typedef _Event = PendingRequestEvent;
typedef _State = PendingRequestState;
typedef _EventHandler = EventHandler<_Event, _State>;
typedef _Emitter = Emitter<_State>;

class PendingRequestBloc extends Bloc<_Event, _State> {
  PendingRequestBloc() : super(const PendingRequestState(null)) {
    on<_Event>(_eventHandler);
  }

  _EventHandler get _eventHandler => (event, emit) => event.map(
        linkAdded: (event) => _onAdded(event, emit),
        consumed: (event) => _onConsumed(event, emit),
      );

  Future<void> _onAdded(PendingRequestLinkAdded event, _Emitter emit) async {
    final link = event.link.scheme == 'https' &&
            event.link.host == 'solana.cryptoplease.link'
        ? Uri(
            scheme: 'solana',
            path: event.link.pathSegments.firstOrNull,
            queryParameters: event.link.queryParameters,
          )
        : event.link;
    final request = SolanaPayRequest.tryParse(link.toString());
    if (request == null) return;

    emit(state.copyWith(request: request));
  }

  Future<void> _onConsumed(PendingRequestConsumed _, _Emitter emit) async {
    emit(state.copyWith(request: null));
  }
}
