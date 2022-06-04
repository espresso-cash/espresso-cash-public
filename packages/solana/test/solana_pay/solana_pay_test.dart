import 'package:decimal/decimal.dart';
import 'package:solana/solana.dart';
import 'package:solana/src/solana_pay/solana_pay.dart';
import 'package:test/test.dart';

import '../config.dart';

void main() {
  final client = SolanaClient(
    rpcUrl: Uri.parse(devnetRpcUrl),
    websocketUrl: Uri.parse(devnetWebsocketUrl),
  );

  test(
    'Happy path for paying with SOL',
    () async {
      final recipient = await Ed25519HDKeyPair.random();
      final sender = await Ed25519HDKeyPair.random();

      final amount = Decimal.parse('0.01');
      final transactionFee = Decimal.fromInt(5000).shift(-solDecimalPlaces);

      // Airdrop some SOL to the recipient.
      await client.requestAirdrop(
        address: recipient.publicKey,
        lamports: lamportsPerSol,
        commitment: Commitment.confirmed,
      );

      // Airdrop some SOL to the sender.
      await client.requestAirdrop(
        address: sender.publicKey,
        lamports: lamportsPerSol,
        commitment: Commitment.confirmed,
      );

      final reference = (await Ed25519HDKeyPair.random()).publicKey;
      final url = 'solana:${recipient.publicKey.toBase58()}'
          '?amount=$amount'
          '&reference=${reference.toBase58()}'
          '&label=Michael'
          '&message=Thanks%20for%20all%20the%20fish'
          '&memo=OrderId5678';

      final request = SolanaPayRequest.parse(url);

      final expectedTransactionId = await client.sendSolanaPay(
        payer: sender,
        recipient: request.recipient,
        // ignore: avoid-non-null-assertion, cannot be null here
        amount: request.amount!,
        reference: request.reference,
        memo: request.memo,
        commitment: Commitment.confirmed,
      );

      final found = await client.findSolanaPayTransaction(
        reference: reference,
        commitment: Commitment.confirmed,
      );
      expect(found, expectedTransactionId);

      await client.validateSolanaPayTransaction(
        // ignore: avoid-non-null-assertion, cannot be null here
        signature: found!,
        recipient: recipient.publicKey,
        // ignore: avoid-non-null-assertion, cannot be null here
        amount: request.amount!,
        commitment: Commitment.confirmed,
      );

      final balanceSender = await client.rpcClient.getBalance(
        sender.publicKey.toBase58(),
        commitment: Commitment.confirmed,
      );
      final balanceDecimalSender =
          Decimal.fromInt(balanceSender).shift(-solDecimalPlaces);
      expect(balanceDecimalSender, Decimal.one - amount - transactionFee);

      final balanceRecipient = await client.rpcClient.getBalance(
        recipient.publicKey.toBase58(),
        commitment: Commitment.confirmed,
      );
      final balanceDecimalRecipient =
          Decimal.fromInt(balanceRecipient).shift(-solDecimalPlaces);
      expect(balanceDecimalRecipient, Decimal.one + amount);
    },
    timeout: const Timeout(Duration(minutes: 1)),
  );
}
