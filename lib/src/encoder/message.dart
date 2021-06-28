part of 'encoder.dart';

/// This is an implementation of the [Message Format][message format].
///
/// [message format]: https://docs.solana.com/developing/programming-model/transactions#message-format
class Message {
  /// Construct a message to send with a transaction to execute
  /// the provided [instructions].
  const Message({
    required this.instructions,
  }) : super();

  int countRequiredSignatures(String? feePayer) {
    final accounts = instructions.getAccounts(feePayer);
    return accounts.getNumReadonlySigners() + accounts.getNumSigners();
  }

  final List<Instruction> instructions;

  String debug(
    Blockhash recentBlockhash, {
    String? feePayer,
  }) {
    final accounts = instructions.getAccounts(feePayer);
    final accountsIndexesMap = accounts.toIndexesMap();
    final header = _MessageHeader.fromAccounts(accounts);
    final compiledInstructions = instructions
        .map(
          (Instruction instruction) => <String, dynamic>{
            'programIdIndex': accountsIndexesMap[instruction.programId]!,
            'accounts': instruction.accounts
                .map((a) => accountsIndexesMap[a.pubKey]!)
                .toList(growable: false),
            'data': base58.encode(
              instruction.data.toList(growable: false),
            ),
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
        'recentBlockhash': recentBlockhash.blockhash,
        'instructions': compiledInstructions,
      },
    );
  }

  /// Compiles a message into the array of bytes that would be interpreted
  /// by solana. The [recentBlockhash] is passed here as this is the final
  /// step before sending the [Message].
  ///
  /// You can also set the [feePayer]'s public key here in order for the
  /// compiler to put the [feePayer] as the first signer in the list of accounts
  /// of the compiled message.
  ByteArray compile({
    required Blockhash recentBlockhash,
    String? feePayer,
  }) {
    final accounts = instructions.getAccounts(feePayer);
    final keys = _CompactArray.fromIterable(
      accounts.toSerializablePubKeys(),
    );
    final accountsIndexesMap = accounts.toIndexesMap();
    final header = _MessageHeader.fromAccounts(accounts);
    final compiledInstructions = _CompactArray.fromIterable(
      instructions.map(
        (Instruction instruction) => _CompiledInstruction(
          instruction: instruction,
          accountIndexesMap: accountsIndexesMap,
        ),
      ),
    );

    return Buffer.fromConcatenatedByteArrays([
      header,
      keys,
      recentBlockhash.toBytes(),
      compiledInstructions,
    ]);
  }
}
