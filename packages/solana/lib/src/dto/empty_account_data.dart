import 'package:solana/src/dto/account_data.dart';

class EmptyAccountData implements AccountData {
  const EmptyAccountData();

  @override
  Map<String, dynamic> toJson() {
    throw UnsupportedError('converting account data to json is not supported');
  }
}
