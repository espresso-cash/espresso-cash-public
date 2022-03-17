import 'package:flutter/widgets.dart';

class DeviceLocale {
  static Locale localeOf(BuildContext context) {
    final installedIntlLocale = Localizations.localeOf(context);
    if (installedIntlLocale.countryCode != null) {
      return installedIntlLocale;
    } else {
      final widgetsBindingInstance = WidgetsBinding.instance;
      if (widgetsBindingInstance == null) {
        return installedIntlLocale;
      }
      final window = widgetsBindingInstance.window;
      final List<Locale> systemLocales = window.locales;

      // NOTE: This locale reflects current user settings preferred locale
      //       as opposed to extracting it from the locales installed by the
      //       cryptoplease application.
      //
      //       The locale that we request from here is needed for
      //       things like, formatting phone numbers, currency values
      //       and dates. The reason why we do this effort is because
      //       the user likes to see things formatted in the way they're
      //       used to.
      return systemLocales.first;
    }
  }
}
