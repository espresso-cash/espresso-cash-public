import 'package:solana/src/rpc/dto/parsed_account_key.dart';
import 'package:solana/src/rpc/dto/raw_account_key.dart';

/// A commonly used object that stores a single [pubkey]
abstract class AccountKey {
  factory AccountKey.fromJson(dynamic json) => json is String
      ? RawAccountKey(pubkey: json)
      : ParsedAccountKey.fromJson(json as Map<String, dynamic>);

  abstract final String pubkey;
}
