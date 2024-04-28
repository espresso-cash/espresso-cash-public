import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/src/crypto/ed25519_hd_public_key.dart';
import 'package:solana/src/encoder/encoder.dart';

/// Taken from [here](https://spl.solana.com/memo#compute-limits).
///
/// An instruction representation that can be converted to a
/// `CompiledInstruction` and included into a message.
@immutable
class Instruction {
  /// Construct a generic instruction for the [programId] program with
  /// [accounts]. These accounts will be interpreted by the specific program
  /// with id [programId].
  ///
  /// Some programs take specific [data]. You can provide raw 8bit bytes arrays
  /// with the [data] parameter.
  const Instruction({
    required this.programId,
    required this.accounts,
    required this.data,
  });

  final Ed25519HDPublicKey programId;
  final List<AccountMeta> accounts;
  final ByteArray data;

  /// Compiles instruction according to the [instruction format][1].
  ///
  /// [1]: https://docs.solana.com/developing/programming-model/transactions#instruction-format
  CompiledInstruction compile(
    Map<Ed25519HDPublicKey, int> accountIndexesMap,
  ) {
    if (!accountIndexesMap.containsKey(programId)) {
      throw const FormatException('programId not found in accountIndexesMap');
    }
    final accountIndexes = accounts.map((a) {
      if (!accountIndexesMap.containsKey(a.pubKey)) {
        throw const FormatException(
          'one of the supplied accounts was not found in the accountIndexesMap',
        );
      }

      return accountIndexesMap[a.pubKey]!;
    });

    return CompiledInstruction(
      programIdIndex: accountIndexesMap[programId]!,
      accountKeyIndexes: accountIndexes.toList(),
      data: data,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other.runtimeType == runtimeType &&
          other is Instruction &&
          const DeepCollectionEquality().equals(other.programId, programId) &&
          const DeepCollectionEquality().equals(other.accounts, accounts) &&
          const DeepCollectionEquality().equals(other.data, data));

  @override
  int get hashCode => Object.hash(
        runtimeType,
        const DeepCollectionEquality().hash(programId),
        const DeepCollectionEquality().hash(accounts),
        const DeepCollectionEquality().hash(data),
      );
}
