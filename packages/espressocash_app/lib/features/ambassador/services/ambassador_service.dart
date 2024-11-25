import 'package:espressocash_api/espressocash_api.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../accounts/auth_scope.dart';

typedef AmbassadorStatus = ({bool isAmbassador, bool isReferral});

@Singleton(scope: authScope)
class AmbassadorService extends ValueNotifier<AmbassadorStatus> {
  AmbassadorService(this._ecClient) : super(_defaultAmbassadorStatus);

  final EspressoCashClient _ecClient;

  @PostConstruct()
  Future<void> init() async {
    try {
      value = await _ecClient.verifyAmbassador().then(
            (e) => (
              isAmbassador: e.isAmbassador,
              isReferral: e.isReferral,
            ),
          );
    } on Exception {
      value = _defaultAmbassadorStatus;
    }
  }
}

const _defaultAmbassadorStatus = (isAmbassador: false, isReferral: false);
