import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'colors.dart';

class CpTheme extends StatelessWidget {
  const CpTheme({
    super.key,
    required this.theme,
    required this.child,
  });

  const CpTheme.light({Key? key, required Widget child})
      : this(
          key: key,
          theme: const CpThemeData.light(),
          child: child,
        );

  const CpTheme.dark({Key? key, required Widget child})
      : this(
          key: key,
          theme: const CpThemeData.dark(),
          child: child,
        );

  static CpThemeData of(BuildContext context) => context.watch<CpThemeData>();

  final CpThemeData theme;
  final Widget child;

  @override
  Widget build(BuildContext context) => Provider.value(
        value: theme,
        child: Theme(
          data: theme.toMaterialTheme(),
          child: AnnotatedRegion<SystemUiOverlayStyle>(
            value: theme.brightness.systemOverlayStyle,
            child: child,
          ),
        ),
      );
}

class CpThemeData {
  const CpThemeData._({
    required this.backgroundColor,
    required this.primaryTextColor,
    required this.secondaryTextColor,
    required this.brightness,
    required this.dividerColor,
  });

  const CpThemeData.light()
      : this._(
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          primaryTextColor: CpColors.primaryTextColor,
          secondaryTextColor: CpColors.secondaryTextColor,
          dividerColor: CpColors.listDividerColor,
        );

  const CpThemeData.dark()
      : this._(
          brightness: Brightness.dark,
          backgroundColor: CpColors.primaryColor,
          primaryTextColor: Colors.white,
          secondaryTextColor: CpColors.secondaryTextColor,
          dividerColor: Colors.white,
        );

  final Color backgroundColor;
  final Color primaryTextColor;
  final Color secondaryTextColor;
  final Brightness brightness;
  final Color dividerColor;

  TextStyle get _baseTextStyle => TextStyle(
        height: 1.25,
        color: primaryTextColor,
        fontFamily: 'RobotoApp',
      );

  ThemeData toMaterialTheme() => ThemeData(
        brightness: brightness,
        splashColor: CpColors.yellowColor.withOpacity(0.25),
        fontFamily: 'RobotoApp',
        textTheme: TextTheme(
          displayLarge: _baseTextStyle.copyWith(
            fontSize: 72,
            fontWeight: FontWeight.bold,
          ),
          displayMedium: _baseTextStyle.copyWith(
            fontSize: 42,
            fontWeight: FontWeight.w600,
          ),
          displaySmall: _baseTextStyle.copyWith(
            fontSize: 26,
            fontWeight: FontWeight.w700,
          ),
          headlineMedium: _baseTextStyle.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          titleMedium: _baseTextStyle.copyWith(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
          titleSmall: _baseTextStyle.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
          bodyLarge: _baseTextStyle.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
          labelLarge: _baseTextStyle.copyWith(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        colorScheme: ColorScheme.light(
          brightness: brightness,
          primary: CpColors.primaryColor,
          secondary: CpColors.primaryColor,
          background: backgroundColor,
        ),
        appBarTheme: AppBarTheme(
          systemOverlayStyle: brightness.systemOverlayStyle,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          titleTextStyle: _baseTextStyle.copyWith(
            fontSize: 17,
            color: primaryTextColor,
            fontWeight: FontWeight.bold,
            letterSpacing: .23,
          ),
          shape: Border(
            bottom: BorderSide(
              width: 1,
              color: brightness == Brightness.dark
                  ? Colors.transparent
                  : dividerColor,
            ),
          ),
          foregroundColor: primaryTextColor,
        ),
        canvasColor: backgroundColor,
        scaffoldBackgroundColor: backgroundColor,
        highlightColor: Colors.transparent,
        hintColor: Colors.grey,
        dividerColor: dividerColor,
      );
}

const twelveWordsTextStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 17,
  color: Colors.white,
  letterSpacing: 0.09,
  wordSpacing: 2,
  height: 1.411,
);

const dashboardSectionTitleTextStyle = TextStyle(
  fontWeight: FontWeight.w500,
  fontSize: 19,
  color: CpColors.menuPrimaryTextColor,
);

extension on Brightness {
  SystemUiOverlayStyle get systemOverlayStyle => this == Brightness.dark
      ? SystemUiOverlayStyle.light.copyWith(
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: Colors.transparent,
        )
      : SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: Colors.transparent,
        );
}
