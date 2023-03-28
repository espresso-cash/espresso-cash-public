part of 'qr_scanner_bloc.dart';

@freezed
class QrScannerEvent with _$QrScannerEvent {
  const factory QrScannerEvent.received(List<Barcode> barcodes) =
      QrScannerReceivedEvent;

  const factory QrScannerEvent.initialized() = QrScannerInitializedEvent;
}
