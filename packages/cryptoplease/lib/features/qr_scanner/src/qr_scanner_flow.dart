import '../module.dart';

abstract class QrScannerFlow {
  void onManualInputRequested();
  void onInputComplete(String address);
  void onScanComplete(QrScannerRequest request);
  void onScanRequested();
  void onCameraPermissionFailure();
  void onClose();
}
