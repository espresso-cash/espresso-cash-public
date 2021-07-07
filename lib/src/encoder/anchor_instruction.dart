import 'package:convert/convert.dart';
import 'package:cryptography/cryptography.dart';
import 'package:solana/src/borsh_serializer/borsh_serializer.dart';
import 'package:solana/src/encoder/account_meta.dart';
import 'package:solana/src/encoder/instruction.dart';

class AnchorInstruction extends Instruction {
  const AnchorInstruction._({
    required String programId,
    required List<AccountMeta> accounts,
    required List<int> data,
  }) : super(
          programId: programId,
          accounts: accounts,
          data: data,
        );

  static Future<AnchorInstruction> forMethod({
    required String programId,
    required String namespace,
    required String method,
    required Map<String, dynamic> arguments,
    required List<AccountMeta> accounts,
  }) async {
    final hash = await '$namespace::${method.toCamelCase()}'.signHash();
    return AnchorInstruction._(
      programId: programId,
      accounts: accounts,
      data: [
        ...hash.sublist(0, 8),
        ...arguments.toBorshBytes(),
      ],
    );
  }

  @override
  String toString() => hex.encode(data.toList(growable: false));
}

final _sha256 = Sha256();

extension on String {
  String toCamelCase() => this;

  Future<List<int>> signHash() async {
    final hash = await _sha256.hash(codeUnits);
    return hash.bytes;
  }
}

extension on Map<String, dynamic> {
  List<int> toBorshBytes() {
    final List<int> data = [];
    for (final value in values) {
      if (value is String) {
        data.addAll(value.codeUnits);
      } else if (value is int) {
        final borshInteger = BorshInteger.u64(value);
        data.addAll(borshInteger.serialize());
      } else {
        throw ArgumentError('unsupported type in map');
      }
    }
    return data;
  }
}
