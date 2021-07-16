import 'package:borsh/borsh.dart';
import 'package:convert/convert.dart';
import 'package:cryptography/cryptography.dart';
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
    BorshStruct arguments = const EmptyBorshStruct(),
  }) async {
    final serializedArguments = arguments.toBorsh();
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
    final discriminator = await computeDiscriminator(ns, name);
    return discriminator.followedBy(this).toList(growable: false);
  }
}

Future<List<int>> computeDiscriminator(String namespace, String name) async {
  final identifier = '$namespace:$name';
  final hash = await _sha256.hash(identifier.codeUnits);
  final hashBytes = hash.bytes;
  return hashBytes.sublist(0, 8);
}
