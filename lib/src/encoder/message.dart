import 'dart:convert';

import 'package:solana/src/base58/encode.dart';
import 'package:solana/src/crypto/ed25519_hd_keypair.dart';
import 'package:solana/src/encoder/buffer.dart';
import 'package:solana/src/encoder/compact_array.dart';
import 'package:solana/src/encoder/compiled_instruction.dart';
import 'package:solana/src/encoder/compiled_message.dart';
import 'package:solana/src/encoder/extensions.dart';
import 'package:solana/src/encoder/instruction.dart';
import 'package:solana/src/encoder/message_header.dart';

/// This is an implementation of the [Message Format][message format].
///
/// [message format]: https://docs.solana.com/developing/programming-model/transactions#message-format
class Message {
  /// Construct a message to send with a transaction to execute
  /// the provided [instructions].
  const Message({
    required this.instructions,
  }) : super();

  final List<Instruction> instructions;

  String debug(String recentBlockhash, Ed25519HDKeyPair feePayer) {
    final accounts = instructions.getAccountsWithOptionalFeePayer(feePayer);
    final accountsIndexesMap = accounts.toIndexesMap();
    final header = MessageHeader.fromAccounts(accounts);
    final compiledInstructions = instructions
        .map(
          (Instruction instruction) => <String, dynamic>{
            'programIdIndex': accountsIndexesMap[instruction.programId]!,
            'accounts': instruction.accounts
                .map((a) => accountsIndexesMap[a.pubKey]!)
                .toList(growable: false),
            'data': base58encode(instruction.data.toList(growable: false))
          },
        )
        .toList(growable: false);
    const encoder = JsonEncoder.withIndent('  ');

    return encoder.convert(
      <String, dynamic>{
        'header': <String, dynamic>{
          'numRequiredSignatures': header.elementAt(0),
          'numReadonlySignedAccounts': header.elementAt(1),
          'numReadonlyUnsignedAccounts': header.elementAt(2),
        },
        'accounts': accounts.map((a) => a.toString()).toList(growable: false),
        'recentBlockhash': recentBlockhash,
        'instructions': compiledInstructions,
      },
    );
  }

  /// Compiles a message into the array of bytes that would be interpreted
  /// by solana. The [recentBlockhash] is passed here as this is the final
  /// step before sending the [Message].
  ///
  /// If provided the [feePayer] can be added to the accounts if it's not
  /// present.
  ///
  /// Returns a [CompiledMessage] that can be used to sign the transaction,
  /// and also verify that the number of signers is correct.
  CompiledMessage compile({
    required String recentBlockhash,
    required Ed25519HDKeyPair feePayer,
  }) {
    final accounts = instructions.getAccountsWithOptionalFeePayer(feePayer);
    final keys = CompactArray.fromIterable(
      accounts.toSerializablePubKeys(),
    );
    final accountsIndexesMap = accounts.toIndexesMap();
    final header = MessageHeader.fromAccounts(accounts);
    final compiledInstructions = CompactArray.fromIterable(
      instructions.map(
        (Instruction instruction) => CompiledInstruction(
          instruction: instruction,
          accountIndexesMap: accountsIndexesMap,
        ),
      ),
    );

    return CompiledMessage(
      data: Buffer.fromConcatenatedByteArrays([
        header,
        keys,
        Buffer.fromBase58(recentBlockhash),
        compiledInstructions,
      ]),
      requiredSignatureCount: accounts.getNumSigners(),
    );
  }
}
