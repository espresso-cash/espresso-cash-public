part of 'qr_scanner_bloc.dart';

@freezed
class QrScannerState with _$QrScannerState {
  const factory QrScannerState.initial() = QrScannerInitialState;

  const factory QrScannerState.error() = QrScannerErrorState;

  const factory QrScannerState.done(QrScannerRequest request) =
      QrScannerDoneState;
}
