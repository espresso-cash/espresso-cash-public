import 'package:crypto_please_solana_lib/src/base58/base58.dart' as base58;
import 'package:crypto_please_solana_lib/src/types/serializable.dart';

class SerializableAddress extends Serializable {
  SerializableAddress.from(this._address);

  final String _address;

  @override
  List<int> serialize() {
    return base58.decode(_address);
  }
}
