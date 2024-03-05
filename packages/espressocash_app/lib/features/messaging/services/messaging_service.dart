import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';

@Singleton()
class MessagingService {
  MessagingService._();

  static MessagingService? _instance;

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @FactoryMethod(preResolve: true)
  static Future<MessagingService> create() async {
    if (_instance == null) {
      await FirebaseMessaging.instance.requestPermission();
    }

    return _instance ??= MessagingService._();
  }

  Future<String?> getToken() async => Platform.isIOS
      ? await _firebaseMessaging.getAPNSToken()
      : await _firebaseMessaging.getToken();
}
