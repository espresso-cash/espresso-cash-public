import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../feature_flags/services/feature_flags_manager.dart';
import '../models/qr_scanner_request.dart';

part 'qr_scanner_bloc.freezed.dart';
part 'qr_scanner_event.dart';
part 'qr_scanner_state.dart';

typedef _Event = QrScannerEvent;
typedef _State = QrScannerState;
typedef _EventHandler = EventHandler<_Event, _State>;
typedef _Emitter = Emitter<_State>;

@injectable
class QrScannerBloc extends Bloc<_Event, _State> {
  QrScannerBloc(this._featureFlags) : super(const QrScannerState.initial()) {
    on<_Event>(_eventHandler, transformer: sequential());
  }

  final FeatureFlagsManager _featureFlags;

  _EventHandler get _eventHandler => (event, emit) => event.map(
        received: (e) => _onReceived(e, emit),
        initialized: (e) => _onInitialized(e, emit),
      );

  void _onInitialized(QrScannerInitializedEvent _, _Emitter emit) {
    emit(const QrScannerState.initial());
  }

  void _onReceived(QrScannerReceivedEvent event, _Emitter emit) {
    final isTrEnabled = _featureFlags.isTransactionRequestEnabled();

    final newState =
        QrScannerRequest.tryParse(event.code, isTREnabled: isTrEnabled)
            .maybeMap(QrScannerState.done);

    if (newState != null) {
      emit(newState);
    }
  }
}
