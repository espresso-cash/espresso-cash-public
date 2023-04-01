import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

import 'callback.dart';

@injectable
class ConnectivityNotifier extends ChangeNotifier {
  ConnectivityNotifier() {
    _init();
  }

  bool? _isOnline;
  StreamSubscription<dynamic>? _subscription;

  void onConnectivityChanged(Callback1<bool> onConnectivityChanged) {
    final isOnline = _isOnline;
    if (isOnline == null) return;

    onConnectivityChanged(isOnline);
  }

  void _notify(ConnectivityResult result) {
    _isOnline = result != ConnectivityResult.none;
    notifyListeners();
  }

  Future<void> _init() async {
    try {
      await Connectivity().checkConnectivity().letAsync(_notify);
      _subscription = Connectivity().onConnectivityChanged.listen(_notify);
    } on PlatformException {
      return;
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
