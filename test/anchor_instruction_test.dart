import 'package:solana/solana.dart';
import 'package:solana/src/crypto/ed25519_hd_keypair.dart';
import 'package:solana/src/encoder/anchor_instruction.dart';
import 'package:solana/src/encoder/constants.dart';
import 'package:solana/src/encoder/message.dart';
import 'package:test/test.dart';

import 'airdrop.dart';
import 'config.dart';

void main() {
  late final Ed25519HDKeyPair solOwner;
  late final Ed25519HDKeyPair vault;
  final client = RPCClient(devnetRpcUrl);

  setUpAll(() async {
    solOwner = await Ed25519HDKeyPair.random();
    vault = await Ed25519HDKeyPair.random();
    await airdrop(client, solOwner, sol: 10);
  });

  test('It works', () async {
    final instruction = await AnchorInstruction.forMethod(
      programId: _programId,
      namespace: 'pushnotification',
      method: 'init',
      arguments: <String, dynamic>{
        'fee': 1000,
      },
      accounts: [
        AccountMeta.readonly(pubKey: solOwner.address, isSigner: true),
        AccountMeta.writeable(pubKey: vault.address, isSigner: true),
        AccountMeta.readonly(pubKey: _programId, isSigner: false),
        AccountMeta.readonly(pubKey: SystemProgram.programId, isSigner: false),
        AccountMeta.readonly(pubKey: Sysvar.rent, isSigner: false),
      ],
    );
    final message = Message(instructions: [instruction]);
    final signature = await client.signAndSendTransaction(message, [
      solOwner,
    ]);
    print(signature);
    print(instruction);
  });
}

const _programId = 'HKD6QnSVx7EV8Q3cMenMcBrfvopnoX9vFJ4L4g4Q5GmW';
