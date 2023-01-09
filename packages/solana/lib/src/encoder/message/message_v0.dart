import 'package:collection/collection.dart';
import 'package:solana/encoder.dart';
import 'package:solana/src/crypto/ed25519_hd_public_key.dart';
import 'package:solana/src/encoder/address_lookup_table/address_lookup_table.dart';
import 'package:solana/src/encoder/compact_array.dart';
import 'package:solana/src/encoder/message/account_keys.dart';
import 'package:solana/src/encoder/message/compiled_keys.dart';
import 'package:solana/src/encoder/message_address_table_lookup.dart';
import 'package:solana/src/encoder/signed_tx_v0.dart';

/// This is an implementation of the [Message Format][1].
///
/// [1]: https://docs.solana.com/developing/programming-model/transactions#message-format
class Messagev0 {
  /// Construct a message to send with a transaction to execute the provided
  /// [instructions].
  const Messagev0({
    required this.instructions,
  }) : super();

  Messagev0.only(Instruction instruction) : instructions = [instruction];

  factory Messagev0.decompile(CompiledMessage compiledMessage) {
    final tx = SignedTxV0(messageBytes: compiledMessage.data);

    return tx.message;
  }

  final List<Instruction> instructions;

  /// Compiles a message into the array of bytes that would be interpreted by
  /// solana. The [recentBlockhash] is passed here as this is the final step
  /// before sending the [Messagev0].
  ///
  /// If provided the [feePayer] can be added to the accounts if it's not
  /// present.
  ///
  /// Returns a [CompiledMessage] that can be used to sign the transaction, and
  /// also verify that the number of signers is correct.
  CompiledMessage compile({
    required String recentBlockhash,
    required Ed25519HDPublicKey feePayer,
    List<AddressLookupTableAccount>? addressLookupTableAccounts,
  }) {
    final compiledKeys =
        CompiledKeys.compile(instructions: instructions, payer: feePayer);

    final addressTableLookups = <MessageAddressTableLookup>[];
    final accountKeysFromLookups = LoadedAddresses(writable: [], readonly: []);

    final lookupTableAccounts = addressLookupTableAccounts ?? [];

    for (final lookupTable in lookupTableAccounts) {
      final extractResult = compiledKeys.extractTableLookup(lookupTable);
      if (extractResult != null) {
        final addressTableLookup = extractResult.lookup;
        final writable = extractResult.keys.writable;
        final readonly = extractResult.keys.readonly;
        addressTableLookups.add(addressTableLookup);
        accountKeysFromLookups.writable.addAll(writable);
        accountKeysFromLookups.readonly.addAll(readonly);
      }
    }

    final messageComponents = compiledKeys.getMessageComponents();
    final staticAccountKeys = messageComponents.publicKeys;
    final accountKeys = MessageAccountKeys(
      staticAccountKeys: staticAccountKeys,
      accountKeysFromLookups: accountKeysFromLookups,
    );
    final messageInstructions = accountKeys.compileInstructions(instructions);

    const messageVersion0Prefix = 1 << 7;
    final keys = staticAccountKeys.map((e) => e.toByteArray());
    final compiledInstructions = messageInstructions.map(
      (i) => ByteArray.merge([
        ByteArray.u8(i.programIdIndex),
        CompactArray(ByteArray(i.accountKeyIndexes)).toByteArray(),
        CompactArray(i.data).toByteArray(),
      ]),
    );
    final compiledAddressTableLookups = addressTableLookups.map(
      (e) => ByteArray.merge([
        e.accountKey.toByteArray(),
        CompactArray(ByteArray(e.writableIndexes)).toByteArray(),
        CompactArray(ByteArray(e.readonlyIndexes)).toByteArray(),
      ]),
    );

    return CompiledMessage(
      ByteArray.merge([
        ByteArray.u8(messageVersion0Prefix),
        messageComponents.header.toByteArray(),
        CompactArray.fromIterable(keys).toByteArray(),
        ByteArray.fromBase58(recentBlockhash),
        CompactArray.fromIterable(compiledInstructions).toByteArray(),
        CompactArray.fromIterable(compiledAddressTableLookups).toByteArray(),
      ]),
    );
  }

  @override
  int get hashCode => const DeepCollectionEquality().hash(instructions);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Messagev0 &&
          const DeepCollectionEquality().equals(instructions, instructions);
}
