import 'package:solana_dart/src/base58/base58.dart' as base58;
import 'package:solana_dart/src/solana_serializable/serializable.dart';

class Address extends Serializable {
  Address.from(this._address);

  final String _address;

  @override
  List<int> serialize() => base58.decode(_address);
}
