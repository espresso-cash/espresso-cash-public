import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension L10nExt on BuildContext {
  // ignore: avoid-non-null-assertion, cannot be null here
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}
