import 'package:flutter/material.dart';

import '../../gen/assets.gen.dart';
import '../../l10n/decimal_separator.dart';
import '../../l10n/device_locale.dart';
import '../theme.dart';

class _NumericKey extends KeypadKey {
  const _NumericKey({required this.number});

  final int number;

  @override
  String get value => '$number';

  @override
  Widget build(BuildContext context) => Text(
        value,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      );
}

class _BackspaceKey extends KeypadKey {
  const _BackspaceKey();

  @override
  String get value => '<';

  @override
  Widget build(BuildContext context) => Assets.icons.keyDelete.svg(
        height: 22,
        color: CpTheme.of(context).primaryTextColor,
      );
}

class _DecimalSeparatorKey extends KeypadKey {
  const _DecimalSeparatorKey();

  @override
  String get value => '.';

  @override
  Widget build(BuildContext context) => Text(
        getDecimalSeparator(DeviceLocale.localeOf(context)),
        style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
      );
}

abstract class KeypadKey extends StatelessWidget {
  const KeypadKey({super.key});

  const factory KeypadKey.number({required int number}) = _NumericKey;

  const factory KeypadKey.backspace() = _BackspaceKey;

  const factory KeypadKey.decimalSeparator() = _DecimalSeparatorKey;

  String get value;
}
