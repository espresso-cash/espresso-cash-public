part of 'encoder.dart';

/// This is an implementation of the [Message Format][message format].
///
/// [message format]: https://docs.solana.com/developing/programming-model/transactions#message-format
class Message {
  /// Construct a message to send with a transaction to execute
  /// the provided [instructions].
  Message({
    required this.instructions,
  }) : super();

  /// Creates a solana transfer message to send [lamports] SOL tokens from [source]
  /// to [destination].
  ///
  /// To add additional data to the transaction you can use the [memo] field.
  /// It accepts an arbitrary string of utf-8 characters. As of now the maximum
  /// allowed length for the memo is 566 bytes of utf-8 data.
  ///
  /// NOTE: This constructor creates a transaction with 2 instructions when a [memo]
  /// is provided.
  factory Message.transfer({
    required String source,
    required String destination,
    required int lamports,
    String? memo,
  }) {
    final instructions = [
      Instruction.system(
        accounts: [
          AccountMeta.writeable(pubKey: source, isSigner: true),
          AccountMeta.writeable(pubKey: destination, isSigner: false),
        ],
        data: InstructionData.transfer(lamports: lamports),
      ),
      if (memo != null)
        Instruction.memo(
          signers: [AccountMeta.writeable(pubKey: source, isSigner: true)],
          memo: Buffer.fromString(memo),
        ),
    ];

    return Message(
      instructions: instructions,
    );
  }

  final List<Instruction> instructions;

  String debug(
    Blockhash recentBlockhash, {
    String? feePayer,
  }) {
    final accounts = instructions._getAccounts(feePayer);
    final accountsIndexesMap = accounts.toIndexesMap();
    final header = MessageHeader.fromAccounts(accounts);
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
    final accounts = instructions._getAccounts(feePayer);
    final keys = CompactArray<Buffer>.fromIterable(
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

    return Buffer.fromConcatenatedByteArrays([
      header,
      keys,
      recentBlockhash.toBytes(),
      compiledInstructions,
    ]);
  }
}

extension on Iterable<AccountMeta> {
  Map<String, int> toIndexesMap() {
    final Map<String, int> mapped = {};

    for (int i = 0; i < length; ++i) {
      final AccountMeta item = elementAt(i);
      mapped[item.pubKey] = i;
    }

    return mapped;
  }
}
