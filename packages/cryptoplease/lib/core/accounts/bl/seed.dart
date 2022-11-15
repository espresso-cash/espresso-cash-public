import 'package:dfunc/dfunc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'seed.freezed.dart';

@freezed
class Seed with _$Seed {
  const factory Seed.empty() = _SeedEmpty;

  const factory Seed.typed(String mnemonic) = _SeedTyped;

  const factory Seed.generated(String mnemonic) = _SeedGenerated;
}

extension SeedExt on Seed {
  String get phrase => when(
        empty: always(''),
        typed: identity,
        generated: identity,
      );
}
