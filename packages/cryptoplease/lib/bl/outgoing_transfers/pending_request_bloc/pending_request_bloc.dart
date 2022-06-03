import 'package:collection/collection.dart';
import 'package:cryptoplease/config.dart';
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
    final request = tryParseDeepLink(event.link);
    if (request == null) return;

    emit(state.copyWith(request: request));
  }

  Future<void> _onConsumed(PendingRequestConsumed _, _Emitter emit) async {
    emit(state.copyWith(request: null));
  }
}

@visibleForTesting
SolanaPayRequest? tryParseDeepLink(Uri link) {
  final linkWithCorrectScheme = link.scheme == 'https' &&
          (link.host == 'solana.$cpLinkDomain' ||
              link.host == 'sol.$cpLinkDomain' ||
              link.host == solanaPayHost) &&
          link.pathSegments.any((s) => s.isNotEmpty)
      ? Uri(
          scheme: 'solana',
          path: link.pathSegments.firstOrNull,
          queryParameters: link.queryParameters,
        )
      : link;

  return SolanaPayRequest.tryParse(linkWithCorrectScheme.toString());
}
