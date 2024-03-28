import 'package:solana/solana_pay.dart';

extension SolanaPayRequestExt on SolanaPayRequest {
  String get headerTitle {
    final name = label;
    final amount = this.amount ?? 0;

    return name == null
        ? 'You have a request of $amount USDC'
        : '$name is requesting $amount USDC';
  }
}
