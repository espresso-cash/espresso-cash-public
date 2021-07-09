import 'dart:convert';
import 'dart:typed_data';

import 'package:solana/solana.dart';
import 'package:solana/src/borsh_serializer/borsh_serializer.dart';
import 'package:solana/src/crypto/ed25519_hd_keypair.dart';
import 'package:solana/src/encoder/anchor_instruction.dart';
import 'package:solana/src/encoder/constants.dart';
import 'package:solana/src/encoder/message.dart';
import 'package:test/test.dart';

import 'airdrop.dart';
import 'config.dart';

void main() {
  late final Ed25519HDKeyPair payer;
  late final Ed25519HDKeyPair vault;
  late final Ed25519HDKeyPair updater;
  final client = RPCClient(devnetRpcUrl);

  setUpAll(() async {
    payer = await Ed25519HDKeyPair.random();
    vault = await Ed25519HDKeyPair.random();
    updater = await Ed25519HDKeyPair.random();
    await airdrop(client, payer, sol: 10);
  });

  test('Call to basic-0 methods succeeds', () async {
    final instructions = [
      await AnchorInstruction.forMethod(
        programId: _basic0,
        method: 'initialize',
        accounts: [
          AccountMeta.readonly(pubKey: payer.address, isSigner: false),
        ],
        namespace: 'global',
      ),
    ];
    final message = Message(instructions: instructions);
    final signature = await client.signAndSendTransaction(
      message,
      [
        payer,
      ],
      feePayer: payer.address,
    );
    expect(signature, isNotNull);
  });

  test('Call to basic-1 methods succeeds', () async {
    // 8 bytes for the discriminator and 8 bytes for the data
    const space = 16;
    final rent = await client.getMinimumBalanceForRentExemption(space);
    final instructions = [
      SystemInstruction.createAccount(
        rent: rent,
        programId: _basic1,
        address: updater.address,
        owner: payer.address,
        space: space,
      ),
      await AnchorInstruction.forMethod(
        programId: _basic1,
        method: 'initialize',
        arguments: <String, dynamic>{
          'data': BorshInteger.u64(100),
        },
        accounts: <AccountMeta>[
          AccountMeta.writeable(pubKey: updater.address, isSigner: false),
          AccountMeta.readonly(pubKey: Sysvar.rent, isSigner: false),
        ],
        namespace: 'global',
      ),
    ];
    final message = Message(instructions: instructions);
    final signature = await client.signAndSendTransaction(
      message,
      [
        payer,
        updater,
      ],
    );
    final expectedDiscriminator = Uint8List.fromList(
      await computeDiscriminator('account', 'my_account'),
    );
    final accountInfo = await client.getAccountInfo(updater.address);
    final dynamic data = accountInfo.data;
    // TODO(IA): parse it as borsh encoded data + discriminator
    if (data is List) {
      final dynamic base64Data = data[0];
      if (base64Data is String && data[1] == 'base64') {
        final decoded = base64Decode(base64Data);
        final discriminator = ByteData.sublistView(decoded, 0, 8);
        final data = ByteData.sublistView(decoded, 8, 16);

        final discriminatorBytes = discriminator.buffer.asUint8List();
        print(discriminatorBytes);

        expect(data.getUint64(0, Endian.little), equals(100));
        expect(
          discriminator.getUint64(0, Endian.little),
          equals(
            ByteData.sublistView(expectedDiscriminator)
                .getUint64(0, Endian.little),
          ),
        );
      }
    }
    expect(signature, isNotNull);
  });
}

const _basic0 = 'CPByhqeWh1M5D9bdPqkwiWDyReVUB54XR9DhA7UYafqi';
const _basic1 = '7xRzrby4Gg486zNqgvE4b9VQmBtmdPoSG7KM4dH3w5VK';

extension on Ed25519HDKeyPair {
  AccountMeta toWriteableMeta({required bool signer}) =>
      AccountMeta.writeable(pubKey: address, isSigner: signer);
  AccountMeta toReadonlyMeta({required bool signer}) =>
      AccountMeta.readonly(pubKey: address, isSigner: signer);
}
