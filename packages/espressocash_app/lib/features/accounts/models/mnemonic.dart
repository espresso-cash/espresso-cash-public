import 'package:dfunc/dfunc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'mnemonic.freezed.dart';

@freezed
class Mnemonic with _$Mnemonic {
  const factory Mnemonic.empty() = _MnemonicEmpty;

  const factory Mnemonic.typed(String phrase) = _MnemonicTyped;

  const factory Mnemonic.generated(String phrase) = _MnemonicGenerated;
}

extension MnemonicExt on Mnemonic {
  String get phrase => when(
        empty: always(''),
        typed: identity,
        generated: identity,
      );
}

@freezed
class AccountSource with _$AccountSource {
  const factory AccountSource.local(Mnemonic mnemonic) = AccountSourceLocal;
}
