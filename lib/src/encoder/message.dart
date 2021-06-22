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
          AccountMeta.writeableSigner(pubKey: source),
          AccountMeta.writeable(pubKey: destination),
        ],
        data: InstructionData.transfer(lamports: lamports),
      ),
      if (memo != null)
        Instruction.memo(
          signers: [AccountMeta.writeableSigner(pubKey: source)],
          memo: Buffer.fromString(memo),
        ),
    ];

    return Message(
      instructions: instructions,
    );
  }

  final List<Instruction> instructions;

  /// Compiles a message into the array of bytes that would be interpreted
  /// by solana. The [recentBlockhash] is passed here as this is the final
  /// step before sending the [Message].
  ByteArray compile(Blockhash recentBlockhash) {
    final accounts = instructions.getAccounts();
    final keys = CompactArray<PubKeyBytes>.fromIterable(
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

    return Buffer.fromByteArrays([
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
