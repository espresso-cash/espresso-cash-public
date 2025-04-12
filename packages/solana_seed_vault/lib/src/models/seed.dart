import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana_seed_vault/src/models/account.dart';
import 'package:solana_seed_vault/src/models/auth_token.dart';

part 'seed.freezed.dart';

enum Purpose { signSolanaTransaction }

@freezed
class Seed with _$Seed {
  const factory Seed({
    required AuthToken authToken,
    required String name,
    required Purpose purpose,
    required List<Account> accounts,
  }) = _Seed;
}
