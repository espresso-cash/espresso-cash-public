import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../authenticated/auth_scope.dart';

@Singleton(scope: authScope)
class OnboardingRepository implements Disposable {
  OnboardingRepository(this._storage) {
    _storage.read(key: _onboardingKey).then((value) {
      if (value == 'true') {
        hasFinishedOnboarding = true;
      }
    });
  }

  final FlutterSecureStorage _storage;

  final BehaviorSubject<bool> _subject = BehaviorSubject.seeded(false);

  ValueStream<bool> get hasFinishedOnboardingStream => _subject.stream;

  set hasFinishedOnboarding(bool value) {
    _subject.add(value);
    _storage.write(key: _onboardingKey, value: value.toString());
  }

  @override
  FutureOr<void> onDispose() {
    _subject.add(false);
    _storage.delete(key: _onboardingKey);
  }
}

const _onboardingKey = 'onboarding';
