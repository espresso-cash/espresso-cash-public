import 'package:espressocash_api/espressocash_api.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../accounts/auth_scope.dart';

@Singleton(scope: authScope)
class AmbassadorService extends ValueNotifier<AmbassadorStatus> {
  AmbassadorService(this._ecClient) : super(AmbassadorStatus.none);

  final EspressoCashClient _ecClient;

  @PostConstruct()
  Future<void> init() async {
    try {
      value = await _ecClient.verifyAmbassador().then((e) => e.status);
    } on Exception {
      value = AmbassadorStatus.none;
    }
  }
}
