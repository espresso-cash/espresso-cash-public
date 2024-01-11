import 'package:solana/src/rpc/dto/account_data/binary_account_data.dart';
import 'package:solana/src/rpc/dto/account_data/empty_account_data.dart';
import 'package:solana/src/rpc/dto/account_data/parsed_account_data.dart';
import 'package:solana/src/rpc/dto/parse_with_encoding.dart';

export 'binary_account_data.dart';
export 'empty_account_data.dart';
export 'parsed_account_data.dart';
export 'spl_token_program/spl_token_program.dart';
export 'stake_program/stake_program.dart';

abstract class AccountData {
  const factory AccountData.binary(List<int> bytes) = BinaryAccountData;

  const factory AccountData.empty() = EmptyAccountData;

  factory AccountData.fromJson(dynamic data) => parseWithEncoding(
        data,
        fromEncoded: AccountData.binary,
        fromParsed: ParsedAccountData.fromJson,
        onUnknownEncoding: (String encoding) => encoding.isEmpty
            ? const AccountData.empty()
            : throw FormatException('unknown encoding $encoding'),
      );

  dynamic toJson();
}
