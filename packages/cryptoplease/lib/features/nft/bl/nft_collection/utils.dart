import 'package:solana/dto.dart';

extension ProgramAccountExt on ProgramAccount {
  /// Parses data and returns SplTokenAccountDataInfo if it corresponds to the
  /// NFT account data. Otherwise, it returns null.
  ///
  /// For a SPL token to be a NFT, 2 conditions apply
  ///
  /// 1. decimals MUST BE exactly zero
  /// 2. amount MUST BE exactly 1
  ///
  /// There are scenarios where, amount could be zero if you had sent the NFT to
  /// someone else. We have to filter these cases.
  SplTokenAccountDataInfo? toNftAccountDataOrNull() {
    final data = account.data;
    if (data is ParsedAccountData) {
      return data.maybeMap(
        orElse: () => null,
        splToken: (data) => data.parsed.maybeMap(
          orElse: () => null,
          account: (data) {
            final info = data.info;
            final tokenAmount = info.tokenAmount;
            final amount = int.parse(tokenAmount.amount);

            if (tokenAmount.decimals != 0 || amount != 1) {
              return null;
            }

            return info;
          },
        ),
      );
    } else {
      return null;
    }
  }
}
