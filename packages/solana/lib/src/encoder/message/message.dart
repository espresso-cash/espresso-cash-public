import 'package:collection/collection.dart';
import 'package:solana/encoder.dart';
import 'package:solana/src/crypto/ed25519_hd_public_key.dart';
import 'package:solana/src/encoder/address_lookup_table/address_lookup_table.dart';
import 'package:solana/src/encoder/compact_array.dart';
import 'package:solana/src/encoder/message/account_keys.dart';
import 'package:solana/src/encoder/message/compiled_keys.dart';
import 'package:solana/src/encoder/message_address_table_lookup.dart';
import 'package:solana/src/encoder/message_header.dart';

/// This is an implementation of the [Message Format][1].
///
/// [1]: https://docs.solana.com/developing/programming-model/transactions#message-format
class Message {
  /// Construct a message to send with a transaction to execute the provided
  /// [instructions].
  const Message({
    required this.instructions,
  }) : super();

  Message.only(Instruction instruction) : instructions = [instruction];

  factory Message.decompile(CompiledMessage compiledMessage) {
    final tx = SignedTx(messageBytes: compiledMessage.data);

    return tx.message;
  }

  factory Message.decompileV0(
    CompiledMessage compiledMessage, {
    LoadedAddresses? accountKeysFromLookups,
    List<AddressLookupTableAccount>? addressLookupTableAccounts,
  }) {
    final tx = SignedTx(messageBytes: compiledMessage.data);

    return tx.decodeMessage(
      accountKeysFromLookups: accountKeysFromLookups,
      addressLookupTableAccounts: addressLookupTableAccounts,
    );
  }

  final List<Instruction> instructions;

  /// Compiles a message into the array of bytes that would be interpreted by
  /// solana. The [recentBlockhash] is passed here as this is the final step
  /// before sending the [Message].
  ///
  /// If provided the [feePayer] can be added to the accounts if it's not
  /// present.
  ///
  /// Returns a [CompiledMessage] that can be used to sign the transaction, and
  /// also verify that the number of signers is correct.
  CompiledMessage compile({
    required String recentBlockhash,
    Ed25519HDPublicKey? feePayer,
  }) {
    final accounts =
        instructions.getAccountsWithOptionalFeePayer(feePayer: feePayer);
    final keys = accounts.map((e) => e.pubKey.toByteArray());
    final accountsIndexesMap = accounts.toIndexesMap();
    final header = MessageHeader.fromAccounts(accounts);
    final compiledInstructions =
        instructions.map((i) => i.compile(accountsIndexesMap));

    return CompiledMessage(
      ByteArray.merge([
        header.toByteArray(),
        CompactArray.fromIterable(keys).toByteArray(),
        ByteArray.fromBase58(recentBlockhash),
        CompactArray.fromIterable(compiledInstructions).toByteArray(),
      ]),
    );
  }

  CompiledMessage compileToV0Message({
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
      other is Message &&
          const DeepCollectionEquality().equals(instructions, instructions);
}
