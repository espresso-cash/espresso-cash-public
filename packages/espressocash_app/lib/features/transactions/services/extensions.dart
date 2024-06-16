import 'package:borsh_annotation/borsh_annotation.dart';
import 'package:collection/collection.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

extension SignedTxExt on SignedTx {
  BigInt? get computeUnitPrice {
    final message = decompileMessage();

    final ix = message.instructions
        .firstWhereOrNull((ix) => ix.programId == ComputeBudgetProgram.id);
    if (ix == null) return null;

    final data = ix.data;
    final reader =
        BinaryReader(Uint8List.fromList(data.toList()).buffer.asByteData());
    final id = reader.readU8();
    if (id != ComputeBudgetProgram.setComputeUnitPriceIndex.first) return null;

    return reader.readU64();
  }
}
