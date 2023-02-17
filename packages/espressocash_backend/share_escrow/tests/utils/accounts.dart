import 'package:solana/solana.dart';

class Accounts {
  Accounts({
    required this.escrowAccount,
    required this.receiverAccount,
    required this.senderTokenAccount,
    required this.vaultTokenAccount,
    required this.senderAccount,
    required this.depositorAccount,
    required this.receiverTokenAccount,
  });
  final Ed25519HDKeyPair escrowAccount;
  final Ed25519HDKeyPair receiverAccount;
  final Ed25519HDKeyPair senderAccount;
  final Ed25519HDKeyPair depositorAccount;
  final Ed25519HDPublicKey senderTokenAccount;
  final Ed25519HDPublicKey receiverTokenAccount;
  final Ed25519HDPublicKey vaultTokenAccount;
}
