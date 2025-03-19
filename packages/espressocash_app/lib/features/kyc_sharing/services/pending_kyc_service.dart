import 'dart:async';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../accounts/auth_scope.dart';
import '../../profile/data/profile_repository.dart';
import '../data/kyc_repository.dart';
import '../models/kyc_validation_status.dart';
import 'kyc_service.dart';

@Singleton(scope: authScope)
class PendingKycService extends ValueNotifier<KycValidationStatus?> {
  PendingKycService(this._sharedPreferences, this._profileRepository,
      this._kycRepository, this._kycService)
      : super(null);

  final SharedPreferences _sharedPreferences;
  final ProfileRepository _profileRepository;
  final KycRepository _kycRepository;
  final KycSharingService _kycService;

  final _controller = BehaviorSubject<DateTime?>();
  Stream<DateTime?> get pendingKycStream => _controller.stream;

  StreamSubscription<void>? _pollingSubscription;

  bool get hasPendingKyc =>
      _sharedPreferences.getString(_kycStartedKey) != null;

  @PostConstruct()
  void init() {
    final currentDate = _getCurrentKycDate();
    _controller.add(currentDate);

    _initializePolling();
  }

  Future<void> _initializePolling() async {
    await _kycService.initialized;

    final activeCountry = _profileRepository.country;
    if (hasPendingKyc && activeCountry != null) {
      _subscribeKycPolling(activeCountry);
    }
  }

  void _subscribeKycPolling(String country) {
    _unsubscribeKycPolling();

    _pollingSubscription = Stream<void>.periodic(const Duration(seconds: 15))
        .startWith(null)
        .exhaustMap(
          (_) => fetchKycStatus(country: country)
              .timeout(
                const Duration(seconds: 8),
                onTimeout: () => null,
              )
              .asStream()
              .onErrorReturn(null),
        )
        .takeWhile((_) => value == KycValidationStatus.pending)
        .listen((_) {});
  }

  void _unsubscribeKycPolling() {
    _pollingSubscription?.cancel();
    _pollingSubscription = null;
  }

  void create() {
    if (hasPendingKyc) return;

    final now = DateTime.now().toIso8601String();
    _sharedPreferences.setString(_kycStartedKey, now);
    _controller.add(_getCurrentKycDate());
  }

  void remove() {
    _sharedPreferences.remove(_kycStartedKey);
    _controller.add(null);
  }

  Future<void> fetchKycStatus({required String country}) async {
    final status = await _kycRepository.fetchKycStatus(country: country);

    value = status;

    notifyListeners();
  }

  DateTime? _getCurrentKycDate() {
    final dateString = _sharedPreferences.getString(_kycStartedKey);

    return dateString != null ? DateTime.parse(dateString) : null;
  }

  @override
  @disposeMethod
  void dispose() {
    _controller.close();
    _unsubscribeKycPolling();
    _sharedPreferences.remove(_kycStartedKey);
    super.dispose();
  }
}

const _kycStartedKey = 'kycStartedKey';
