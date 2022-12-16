import '../module.dart';

abstract class QrScannerFlow {
  void onManualInputRequested();
  void onScanComplete(QrScannerRequest request);
  void onCameraPermissionFailure();
  void onClose();
}
