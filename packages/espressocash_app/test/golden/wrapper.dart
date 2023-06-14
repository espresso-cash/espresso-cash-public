import 'package:espressocash_app/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(428, 926));

    return CpTheme.light(
      child: Builder(
        builder: (context) => MaterialApp(
          theme: context.watch<CpThemeData>().toMaterialTheme(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          debugShowCheckedModeBanner: false,
          home: child,
        ),
      ),
    );
  }
}
