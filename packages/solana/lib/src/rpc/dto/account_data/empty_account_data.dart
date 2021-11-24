import 'package:solana/src/rpc/dto/account_data.dart';

class EmptyAccountData implements AccountData {
  const EmptyAccountData();

  @override
  Map<String, dynamic> toJson() {
    throw UnsupportedError('converting account data to json is not supported');
  }
}
