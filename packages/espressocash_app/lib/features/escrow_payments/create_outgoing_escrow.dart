import 'package:dfunc/dfunc.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/dto.dart' hide Instruction;
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

import '../../config.dart';
import '../priority_fees/services/add_priority_fees.dart';
import '../tokens/token.dart';
import 'instructions.dart';

@injectable
class CreateOutgoingEscrow {
  const CreateOutgoingEscrow(
    this._client,
    this._addPriorityFees,
    this._ecClient,
  );

  final SolanaClient _client;
  final AddPriorityFees _addPriorityFees;
  final EspressoCashClient _ecClient;

  /// Creates a transaction that will:
  ///
  /// - create ATA for the [escrowAccount] account;
  /// - send [amount] from [senderAccount] ATA to [escrowAccount] ATA;
  /// - send fee from [senderAccount] ATA to [_platform] ATA;
  ///
  /// Tx will be partially signed by the [_platform]. Keep in mind that
  /// [senderAccount] and [_platform] should already have the corresponding ATAs for
  /// the [mint].
  ///
  /// [commitment] is used for checking the ATA for [senderAccount] and for retrieving
  /// the latest blockhash.
  Future<SignedTx> call({
    required Ed25519HDPublicKey senderAccount,
    required Ed25519HDPublicKey escrowAccount,
    required int amount,
    required Commitment commitment,
  }) async {
    final mint = Token.usdc.publicKey;

    final nonceData = await _ecClient.getFreeNonce();
    final platformAccount = Ed25519HDPublicKey.fromBase58(nonceData.authority);

    final isNewEscrowAccount = await _client.rpcClient
            .getAccountInfo(escrowAccount.toBase58(), commitment: commitment)
            .value ==
        null;
    if (!isNewEscrowAccount) {
      throw Exception('Escrow account already exists');
    }

    final senderATAData = await _client.getAssociatedTokenAccount(
      owner: senderAccount,
      mint: mint,
      commitment: commitment,
    );

    if (senderATAData == null) {
      throw Exception('No token account.');
    }

    final ataSender = Ed25519HDPublicKey.fromBase58(senderATAData.pubkey);

    final instructions = <Instruction>[];

    final ataEscrow =
        await findAssociatedTokenAddress(owner: escrowAccount, mint: mint);
    final iCreateATA = AssociatedTokenAccountInstruction.createAccount(
      funder: platformAccount,
      address: ataEscrow,
      owner: escrowAccount,
      mint: mint,
    );

    instructions.add(iCreateATA);

    final ataPlatform = await findAssociatedTokenAddress(
      owner: platformAccount,
      mint: mint,
    );
    const fee = escrowPaymentFee;
    final iTransferFee = TokenInstruction.transfer(
      amount: fee,
      source: ataSender,
      destination: ataPlatform,
      owner: senderAccount,
    );

    instructions.add(iTransferFee);

    final escrowIx = await EscrowInstruction.initEscrow(
      amount: amount,
      escrowAccount: escrowAccount,
      senderAccount: senderAccount,
      depositorAccount: platformAccount,
      senderTokenAccount: ataSender,
      vaultTokenAccount: ataEscrow,
    );

    instructions.add(escrowIx);

    final message = Message(
      instructions: [
        SystemInstruction.advanceNonceAccount(
          nonce: Ed25519HDPublicKey.fromBase58(nonceData.nonce),
          nonceAuthority: platformAccount,
        ),
        ...instructions,
      ],
    );

    final compiled = message.compile(
      recentBlockhash: nonceData.nonce,
      feePayer: platformAccount,
    );

    return await SignedTx(
      compiledMessage: compiled,
      signatures: [
        Signature(List.filled(64, 0), publicKey: platformAccount),
        Signature(List.filled(64, 0), publicKey: escrowAccount),
        Signature(List.filled(64, 0), publicKey: senderAccount),
      ],
    ).let(
      (tx) => _addPriorityFees(
        tx: tx,
        commitment: commitment,
        maxTxCostUsdc: _maxTxCostUsdc,
        platform: platformAccount,
      ),
    );
  }
}

const _maxTxCostUsdc = 9000;
