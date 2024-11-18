import 'package:dio/dio.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:flutter/material.dart';

import '../../../di.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/loader.dart';
import '../../../ui/snackbar.dart';
import '../../../utils/errors.dart';
import '../models/ambassador_referral.dart';

extension BuildContextExt on BuildContext {
  Future<void> registerReferral({
    required AmbassadorReferral ambassador,
  }) =>
      runWithLoader(this, () async {
        final client = sl<EspressoCashClient>();

        try {
          await client.addAmbassadorReferral(
            AmbassadorReferralRequestDto(
              ambassadorAddress: ambassador.address.toBase58(),
            ),
          );

          showCpSnackbar(
            this,
            message: 'Ambassador assigned successfully',
          );
        } on Exception catch (error) {
          final message = error is DioException &&
                  error.toEspressoCashError() ==
                      EspressoCashError.ambassadorAlreadyAssigned
              ? 'Ambassador already assigned'
              : l10n.tryAgainLater;

          showCpErrorSnackbar(this, message: message);
        }
      });
}
