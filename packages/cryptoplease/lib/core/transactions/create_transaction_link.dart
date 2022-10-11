import 'package:cryptoplease/config.dart';

String createTransactionLink(String signature) {
  final sb = StringBuffer()
    ..write('https://explorer.solana.com/tx/')
    ..write(signature);
  if (!isProd) sb.write('?cluster=devnet');

  return sb.toString();
}
