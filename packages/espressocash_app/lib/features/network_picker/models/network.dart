import 'package:fast_immutable_collections/fast_immutable_collections.dart';

typedef Network = ({
  String name,
  String code,
});

final networks = IList<Network>(const [
  (name: 'Solana', code: 'SOL'),
]);
