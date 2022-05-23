import 'package:cryptoplease/bl/activities/tx_details/load_tx_details.dart';
import 'package:solana/solana.dart';

Future<void> main() async {
  final client = RpcClient('https://api.devnet.solana.com');
  const id =
      '2HnG9sV97C6ih2qaYcAw5vdHYwcNYkS88F8YXnr84GZoCynQyWK665GAxtwD4WT8rCWy3auAesMKNnxLk46v84Hz';

  final tx = await loadTxDetails(id, client: client);
  print(tx);
}
