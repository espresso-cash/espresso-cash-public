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
          memo: SerializableString(memo),
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
  List<int> compile(Blockhash recentBlockhash) {
    final accounts = instructions.getAccounts();
    final keys = CompactArray<SerializablePubKey>.fromIterable(
      accounts.toSerializablePubKeys(),
    );
    final header = MessageHeader.fromAccounts(accounts);
    final compiledInstructions = CompactArray.fromIterable(
      instructions.map(
        (Instruction instruction) => CompiledInstruction(
          instruction: instruction,
          messageAccounts: accounts,
        ),
      ),
    );

    return [
      ...header,
      ...keys,
      ...recentBlockhash.toBytes(),
      ...compiledInstructions,
    ];
  }
}

extension _EncodableAccountsInterableExt on Iterable<AccountMeta> {
  // Convert account metas to encoder public keys
  Iterable<SerializablePubKey> toSerializablePubKeys() =>
      map((a) => SerializablePubKey.from(a.pubKey));
}

extension _InstructionsIterableExt on Iterable<Instruction> {
  /// Simple helper to extract all accounts from an instruction, it also appends
  /// the program id account which needs to be present in the accounts array sent
  /// in a message.
  Iterable<AccountMeta> _extractAccounts() => [
        for (final Instruction instruction in this) ...[
          ...instruction.accounts,
          // Always add the program id as an account
          AccountMeta.readonly(pubKey: instruction.programId, isSigner: false),
        ]
      ];

  /// Combines accounts from every instruction and sorts them according
  /// to [Account Addresses Format][account addresses format], also removes
  /// any duplicates.
  ///
  /// Duplicates are removed by picking signers and writeable accounts
  /// over non-writeable and non-signers.
  ///
  /// Accounts are considered duplicates if they have the same public keys.
  ///
  /// [account addresses format]: https://docs.solana.com/developing/programming-model/transactions#account-addresses-format
  Iterable<AccountMeta> getAccounts() =>
      _extractAccounts().unique()..sort(_accountComparator);
}

extension _BlockhashExt on Blockhash {
  Iterable<int> toBytes() => SerializablePubKey.from(blockhash);
}

/// Compare accounts according to the following rules
///
/// Signer accounts go first, and within them writeable accounts
/// go first
///
/// Non-Signer accounts go after, and within them the writeable
/// accounts go first
int _accountComparator(AccountMeta a1, AccountMeta a2) {
  int score = 0;
  score += a1.isSigner ? -1 : 0;
  score += a2.isSigner ? 1 : 0;
  score += a1.isWriteable ? -1 : 0;
  score += a2.isWriteable ? 1 : 0;
  return score;
}
