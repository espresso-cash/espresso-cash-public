import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/link_shortener.dart';
import 'qr_scanner_request.dart';

part 'qr_scanner_bloc.freezed.dart';
part 'qr_scanner_event.dart';
part 'qr_scanner_state.dart';

typedef _Event = QrScannerEvent;
typedef _State = QrScannerState;
typedef _EventHandler = EventHandler<_Event, _State>;
typedef _Emitter = Emitter<_State>;

@injectable
class QrScannerBloc extends Bloc<_Event, _State> {
  QrScannerBloc({
    required LinkShortener linkShortener,
  })  : _linkShortener = linkShortener,
        super(const QrScannerState.initial()) {
    on<_Event>(_eventHandler, transformer: sequential());
  }

  final LinkShortener _linkShortener;

  _EventHandler get _eventHandler => (event, emit) => event.map(
        received: (e) => _onReceived(e, emit),
        initialized: (e) => _onInitialized(e, emit),
      );

  void _onInitialized(QrScannerInitializedEvent _, _Emitter emit) {
    emit(const QrScannerState.initial());
  }

  Future<void> _onReceived(QrScannerReceivedEvent event, _Emitter emit) async {
    final dynamicLink =
        await _linkShortener.reverse(event.code).then((e) => e?.toString());

    final newState = QrScannerRequest.parse(dynamicLink ?? event.code)
            .maybeMap(QrScannerState.done) ??
        const QrScannerState.error();
    emit(newState);
  }
}
