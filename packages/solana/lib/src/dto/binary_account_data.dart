import 'package:solana/src/dto/account_data.dart';

class BinaryAccountData implements AccountData {
  const BinaryAccountData(this.data);

  final List<int> data;

  @override
  Map<String, dynamic> toJson() {
    throw UnsupportedError('converting account data to json is not supported');
  }
}
