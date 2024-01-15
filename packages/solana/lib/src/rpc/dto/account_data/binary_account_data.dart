import 'dart:convert';

import 'package:solana/src/rpc/dto/account_data/account_data.dart';

class BinaryAccountData implements AccountData {
  const BinaryAccountData(this.data);

  final List<int> data;

  @override
  List<String> toJson() => [base64.encode(data), 'base64'];
}
