import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:cryptoplease/bl/qr_scanner/qr_scanner_request.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'qr_scanner_bloc.freezed.dart';
part 'qr_scanner_event.dart';
part 'qr_scanner_state.dart';

typedef _Event = QrScannerEvent;
typedef _State = QrScannerState;
typedef _EventHandler = EventHandler<_Event, _State>;
typedef _Emitter = Emitter<_State>;

class QrScannerBloc extends Bloc<_Event, _State> {
  QrScannerBloc() : super(const QrScannerState.initial()) {
    on<_Event>(_eventHandler, transformer: sequential());
  }

  _EventHandler get _eventHandler => (event, emit) => event.map(
        received: (e) => _onReceived(e, emit),
        initialized: (e) => _onInitialized(e, emit),
      );

  void _onInitialized(QrScannerInitializedEvent _, _Emitter emit) {
    emit(const QrScannerState.initial());
  }

  Future<void> _onReceived(QrScannerReceivedEvent event, _Emitter emit) async {
    final newState =
        QrScannerRequest.parse(event.code).maybeMap(QrScannerState.done) ??
            const QrScannerState.error();
    emit(newState);
  }
}
