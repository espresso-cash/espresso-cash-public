import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:collection/collection.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../../config.dart';
import '../../../../core/link_shortener.dart';
import '../../../../core/split_key_payments.dart';
import '../../models/qr_scanner_request.dart';

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
    if (event.barcodes.length == 1) {
      final code = event.barcodes.first.rawValue;
      if (code != null) {
        final newState =
            QrScannerRequest.parse(code).maybeMap(QrScannerState.done);

        if (newState != null) {
          emit(newState);
        }
      }
    } else if (event.barcodes.length == 2) {
      final firstLink = event.barcodes
          .firstWhereOrNull(
            (e) => e.rawValue?.contains(cpDeepLinkHost) ?? false,
          )
          ?.rawValue;

      final secondLink = event.barcodes
          .firstWhereOrNull((e) => e.rawValue?.contains(link2Host) ?? false)
          ?.rawValue;

      if (firstLink == null || secondLink == null) return;

      final firstLinkShortened =
          await _linkShortener.reverse(firstLink).then((e) => e);

      if (firstLinkShortened == null) return;

      final firstPart = SplitKeyFirstLink.tryParse(firstLinkShortened);

      if (firstPart == null) return;

      final secondUri = Uri.tryParse(secondLink);

      if (secondUri == null) return;

      final secondPart = SplitKeySecondLink.tryParse(secondUri);

      if (secondPart == null) return;

      emit(
        QrScannerState.done(
          QrScannerRequest.qrPayment(
            first: firstPart,
            second: secondPart,
          ),
        ),
      );
    }
  }
}
