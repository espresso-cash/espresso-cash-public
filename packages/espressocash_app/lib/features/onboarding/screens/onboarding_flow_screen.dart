import 'dart:async';

import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';

import '../../../di.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/dialogs.dart';
import '../../../ui/loader.dart';
import '../../../ui/picker_screen.dart';
import '../../authenticated/screens/authenticated_flow_screen.dart';
import '../../country_picker/models/country.dart';
import '../../profile/service/update_profile.dart';
import '../data/onboarding_repository.dart';
import 'view_recovery_phrase_screen.dart';

class OnboardingFlowScreen {
  static Future<void> open(BuildContext context, {NavigatorState? navigator}) async {
    final hasConfirmedPassphrase = sl<OnboardingRepository>().hasConfirmedPassphrase;

    if (hasConfirmedPassphrase) {
      await _openCountryPicker(context: navigator?.context ?? context, navigator: navigator);

      if (context.mounted) {
        AuthenticatedFlowScreen.open(context, navigator: navigator);
      }
    } else {
      ViewRecoveryPhraseScreen.open(
        context,
        navigator: navigator,
        onConfirmed: () async {
          await _openCountryPicker(context: navigator?.context ?? context, navigator: navigator);

          if (context.mounted) {
            AuthenticatedFlowScreen.open(context, navigator: navigator);
          }
        },
      );
    }
  }
}

Future<void> _openCountryPicker({
  required BuildContext context,
  required NavigatorState? navigator,
}) async {
  await CustomPickerScreen.open<Country>(
    context,
    navigator: navigator,
    title: context.l10n.selectCountryTitle,
    items: Country.all,
    itemBuilder:
        (context, country, {required bool selected}) =>
            Text(country.name, style: TextStyle(fontSize: selected ? 19 : 17, color: Colors.white)),
    onTap: _updateCountry,
  );
}

Future<void> _updateCountry(Country country, BuildContext context) =>
    runWithLoader(context, () async {
      await sl<UpdateProfile>().call(countryCode: country.code).foldAsync((e) => throw e, ignore);

      if (!context.mounted) return;
    }, onError: (error) => showErrorDialog(context, context.l10n.lblProfileUpdateFailed, error));
