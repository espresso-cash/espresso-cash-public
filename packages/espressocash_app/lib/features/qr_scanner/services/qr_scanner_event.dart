part of 'qr_scanner_bloc.dart';

@freezed
sealed class QrScannerEvent with _$QrScannerEvent {
  const factory QrScannerEvent.received(String code) = QrScannerReceivedEvent;

  const factory QrScannerEvent.initialized() = QrScannerInitializedEvent;
}
