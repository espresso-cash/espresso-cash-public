import 'package:solana/src/rpc/dto/account_data/account_data.dart';

class EmptyAccountData implements AccountData {
  const EmptyAccountData();

  @override
  List<String> toJson() => const ['', ''];
}
