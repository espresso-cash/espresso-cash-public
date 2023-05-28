import 'package:solana/src/rpc/dto/account_key.dart';
import 'package:solana/src/rpc/dto/address_table_lookups.dart';
import 'package:solana/src/rpc/dto/instruction.dart';
import 'package:solana/src/rpc/dto/parsed_account_key.dart';
import 'package:solana/src/rpc/dto/parsed_message/parsed_message.dart';
import 'package:solana/src/rpc/dto/raw_message.dart';

abstract class Message {
  factory Message.fromJson(Map<String, dynamic> json) {
    final dynamic accountKeysJson = json['accountKeys'];
    if (accountKeysJson == null) {
      throw const FormatException('cannot find account keys in provided json');
    }

    if (accountKeysJson is! List) {
      throw const FormatException('invalid type for `accountKeys`');
    }

    final accountKeys = accountKeysJson.map(AccountKey.fromJson);

    return accountKeys.every((k) => k is ParsedAccountKey)
        ? ParsedMessage.fromJson(json)
        : RawMessage.fromJson(json);
  }

  abstract final List<AccountKey> accountKeys;
  abstract final Header? header;
  abstract final String recentBlockhash;
  abstract final List<Instruction> instructions;
  abstract final List<AddressTableLookups>? addressTableLookups;
}
