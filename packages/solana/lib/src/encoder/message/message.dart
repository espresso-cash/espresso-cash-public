import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/encoder.dart';
import 'package:solana/src/crypto/ed25519_hd_public_key.dart';
import 'package:solana/src/encoder/message/compiled_keys.dart';
import 'package:solana/src/encoder/message/decompile_legacy.dart';
import 'package:solana/src/encoder/message/decompile_v0.dart';
import 'package:solana/src/encoder/message/message_account_keys.dart';
import 'package:solana/src/encoder/message_header.dart';

part 'message.freezed.dart';

/// This is an implementation of the [Message Format][1].
///
/// [1]: https://docs.solana.com/developing/programming-model/transactions#message-format
@freezed
class Message with _$Message {
  /// Construct a message to send with a transaction to execute the provided
  /// [instructions].
  const factory Message({
    required List<Instruction> instructions,
  }) = _Message;

  const Message._();

  factory Message.only(Instruction instruction) =>
      Message(instructions: [instruction]);

  factory Message.decompile(
    CompiledMessage compiledMessage, {
    List<AddressLookupTableAccount> addressLookupTableAccounts = const [],
  }) =>
      compiledMessage.map(
        legacy: decompileLegacy,
        v0: (compiledMessage) => decompileV0(
          compiledMessage,
          addressLookupTableAccounts,
        ),
      );

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
    required Ed25519HDPublicKey feePayer,
  }) {
    final accounts = instructions.getAccounts(feePayer: feePayer);
    final accountsIndexesMap = accounts.toIndexesMap();
    final header = MessageHeader.fromAccounts(accounts);
    final compiledInstructions =
        instructions.map((i) => i.compile(accountsIndexesMap));

    return CompiledMessage.legacy(
      header: header,
      accountKeys: accounts.map((e) => e.pubKey).toList(),
      recentBlockhash: recentBlockhash,
      instructions: compiledInstructions.toList(),
    );
  }

  CompiledMessage compileV0({
    required String recentBlockhash,
    required Ed25519HDPublicKey feePayer,
    List<AddressLookupTableAccount> addressLookupTableAccounts = const [],
  }) {
    final compiledKeys =
        CompiledKeys.compile(instructions: instructions, payer: feePayer);

    final addressTableLookups = <MessageAddressTableLookup>[];
    final writableKeys = <Ed25519HDPublicKey>[];
    final readonlyKeys = <Ed25519HDPublicKey>[];

    for (final lookupTable in addressLookupTableAccounts) {
      final extractResult = compiledKeys.extractTableLookup(lookupTable);
      if (extractResult != null) {
        final addressTableLookup = extractResult.lookup;
        final writable = extractResult.keys.writable;
        final readonly = extractResult.keys.readonly;

        addressTableLookups.add(addressTableLookup);

        writableKeys.addAll(writable);
        readonlyKeys.addAll(readonly);
      }
    }

    final messageComponents = compiledKeys.getMessageComponents();
    final staticAccountKeys = messageComponents.publicKeys;
    final accountKeys = MessageAccountKeys(
      staticAccountKeys: staticAccountKeys,
      accountKeysFromLookups: LoadedAddresses(
        writable: writableKeys,
        readonly: readonlyKeys,
      ),
    );

    final messageInstructions = accountKeys.compileInstructions(instructions);

    return CompiledMessage.v0(
      header: messageComponents.header,
      accountKeys: staticAccountKeys,
      recentBlockhash: recentBlockhash,
      instructions: messageInstructions,
      addressTableLookups: addressTableLookups,
    );
  }
}
