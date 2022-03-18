import 'package:cryptoplease_ui/src/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class CpTheme extends StatelessWidget {
  const CpTheme({
    Key? key,
    required this.theme,
    required this.child,
  }) : super(key: key);

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
          child: child,
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
        fontFamily: 'DIN2014',
        package: 'cryptoplease_ui',
        height: 1.25,
        color: primaryTextColor,
      );

  ThemeData toMaterialTheme() => ThemeData(
        brightness: brightness,
        splashColor: CpColors.yellowColor.withOpacity(0.25),
        fontFamily: 'packages/cryptoplease_ui/DIN2014',
        textTheme: TextTheme(
          headline1: _baseTextStyle.copyWith(
            fontSize: 72,
            fontWeight: FontWeight.bold,
          ),
          headline2: _baseTextStyle.copyWith(
            fontSize: 42,
            fontWeight: FontWeight.w600,
          ),
          headline3: _baseTextStyle.copyWith(
            fontSize: 26,
            fontWeight: FontWeight.w700,
          ),
          headline4: _baseTextStyle.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          subtitle1: _baseTextStyle.copyWith(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
          subtitle2: _baseTextStyle.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
          bodyText1: _baseTextStyle.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
          button: _baseTextStyle.copyWith(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        colorScheme: ColorScheme.light(
          brightness: brightness,
          primary: CpColors.primaryColor,
          secondary: CpColors.primaryColor,
        ),
        appBarTheme: AppBarTheme(
          systemOverlayStyle: brightness == Brightness.dark
              ? SystemUiOverlayStyle.light
              : SystemUiOverlayStyle.dark,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 22,
            color: primaryTextColor,
            fontWeight: FontWeight.w500,
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
        backgroundColor: backgroundColor,
        canvasColor: backgroundColor,
        scaffoldBackgroundColor: backgroundColor,
        highlightColor: Colors.transparent,
        hintColor: Colors.grey,
        dividerColor: dividerColor,
      );
}
