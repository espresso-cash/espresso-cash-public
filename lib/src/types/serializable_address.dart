import 'package:solana_dart/src/base58/base58.dart' as base58;
import 'package:solana_dart/src/types/serializable.dart';

class SerializableAddress extends Serializable {
  SerializableAddress.from(this._address);

  final String _address;

  @override
  List<int> serialize() {
    return base58.decode(_address);
  }
}
