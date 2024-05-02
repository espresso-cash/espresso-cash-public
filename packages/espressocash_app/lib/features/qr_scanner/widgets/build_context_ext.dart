import 'dart:async';

import 'package:flutter/material.dart';

import '../models/qr_address_data.dart';
import '../models/qr_scanner_request.dart';
import '../screens/qr_scanner_screen.dart';

extension BuildContextExt on BuildContext {
  Future<String?> launchQrForAddress() async {
    final request = await QrScannerScreen.push(this);

    if (request == null) return null;
    if (!mounted) return null;

    if (request is QrScannerAddressRequest) {
      return switch (request.addressData) {
        QrAddressDataSolana(:final address) => address.toBase58(),
        QrAddressDataEvm(:final address) => address,
      };
    }
  }
}
