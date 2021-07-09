import 'package:convert/convert.dart';
import 'package:cryptography/cryptography.dart';
import 'package:solana/src/borsh_serializer/simple.dart';
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
    required String method,
    required String namespace,
    required List<AccountMeta> accounts,
    Map<String, dynamic> arguments = const <String, dynamic>{},
  }) async {
    final serializedArguments = serializeMap(arguments);
    return AnchorInstruction._(
      programId: programId,
      accounts: accounts,
      data: await serializedArguments.addDiscriminator(namespace, method),
    );
  }

  @override
  String toString() => hex.encode(data.toList(growable: false));
}

final _sha256 = Sha256();

extension on List<int> {
  Future<List<int>> addDiscriminator(String ns, String name) async {
    final discriminator = await _createDiscriminator(ns, name);
    return discriminator.followedBy(this).toList(growable: false);
  }
}

Future<List<int>> _createDiscriminator(String ns, String name) async {
  final preImage = '$ns:$name';
  final hash = await _sha256.hash(preImage.codeUnits);
  final hashBytes = hash.bytes;
  return hashBytes.sublist(0, 8);
}
