import 'package:solana/src/rpc/dto/account_key.dart';

class RawAccountKey implements AccountKey {
  const RawAccountKey({
    required this.pubkey,
  });

  @override
  final String pubkey;

  @override
  String toJson() => pubkey;
}
