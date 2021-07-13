import 'package:solana/solana.dart';
import 'package:solana/src/anchor/instruction.dart';
import 'package:solana/src/crypto/ed25519_hd_keypair.dart';
import 'package:solana/src/encoder/constants.dart';
import 'package:solana/src/encoder/message.dart';
import 'package:test/test.dart';

import 'airdrop.dart';
import 'anchor_tutorial_types/basic1.dart';
import 'config.dart';
import 'pushnotifications_types/push_notifications.dart';

void main() {
  late final Ed25519HDKeyPair payer;
  late final Ed25519HDKeyPair updater;
  late final Ed25519HDKeyPair data;
  late final Ed25519HDKeyPair vault;
  final client = RPCClient(devnetRpcUrl);

  setUpAll(() async {
    payer = await Ed25519HDKeyPair.random();
    updater = await Ed25519HDKeyPair.random();
    data = await Ed25519HDKeyPair.random();
    vault = await Ed25519HDKeyPair.random();
    await airdrop(client, payer, sol: 10);
  });

  test('Call basic-0 initialize method', () async {
    final instructions = [
      await AnchorInstruction.forMethod(
        programId: _basic0,
        method: 'initialize',
        accounts: [],
        namespace: 'global',
      ),
    ];
    final message = Message(instructions: instructions);
    final signature = await client.signAndSendTransaction(
      message,
      [payer],
    );
    expect(signature, isNotNull);
  }, skip: true);

  test('Call basic-1 initialize method', () async {
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
        arguments: const Basic1Arguments(data: 100),
        accounts: <AccountMeta>[
          AccountMeta.writeable(pubKey: updater.address, isSigner: false),
          AccountMeta.readonly(pubKey: Sysvar.rent, isSigner: false),
        ],
        namespace: 'global',
      ),
    ];
    final message = Message(instructions: instructions);
    await client.signAndSendTransaction(
      message,
      [
        payer,
        updater,
      ],
    );
    final account = await client.getAccountInfo(updater.address);
    final data = Basic1DataAccount.fromAccountData(account.data);
    final discriminator = await computeDiscriminator('account', 'MyAccount');
    expect(data.data, equals(100));
    expect(data.discriminator, equals(discriminator));
  }, skip: true);

  test('Call basic-1 update method', () async {
    // Call update
    final instructions = [
      await AnchorInstruction.forMethod(
        programId: _basic1,
        method: 'update',
        arguments: const Basic1Arguments(data: 25),
        accounts: <AccountMeta>[
          AccountMeta.writeable(pubKey: updater.address, isSigner: false),
        ],
        namespace: 'global',
      ),
    ];
    final message = Message(instructions: instructions);
    await client.signAndSendTransaction(
      message,
      [payer],
    );
    final discriminator = await computeDiscriminator('account', 'MyAccount');
    final account = await client.getAccountInfo(updater.address);
    final dataAccount = Basic1DataAccount.fromAccountData(account.data);
    expect(dataAccount.data, equals(25));
    expect(dataAccount.discriminator, equals(discriminator));
  }, skip: true);

  test('Test push notifications', () async {
    final initAddress = await findProgramAddress(
      programId: _pushNotifications,
      seeds: ['mainDataForTheProgram'.codeUnits],
    );
    const space = 500;
    final rent = await client.getMinimumBalanceForRentExemption(space);
    // Call update
    final instructions = [
      SystemInstruction.createAccount(
        rent: rent,
        programId: _pushNotifications,
        address: data.address,
        owner: payer.address,
        space: space,
      ),
      await AnchorInstruction.forMethod(
        programId: _pushNotifications,
        method: 'init',
        arguments: const Init(fee: 4400),
        accounts: <AccountMeta>[
          AccountMeta.writeable(pubKey: data.address, isSigner: false),
          AccountMeta.writeable(pubKey: initAddress, isSigner: false),
          AccountMeta.writeable(pubKey: vault.address, isSigner: false),
          AccountMeta.writeable(pubKey: payer.address, isSigner: true),
          AccountMeta.writeable(
              pubKey: SystemProgram.programId, isSigner: false),
          AccountMeta.writeable(pubKey: Sysvar.rent, isSigner: false),
        ],
        namespace: 'global',
      ),
    ];
    final message = Message(instructions: instructions);
    await client.signAndSendTransaction(
      message,
      [
        payer,
        data,
      ],
    );
  }, skip: true);
}

const _basic0 = '73JSEtceE6QVgN44rfYtfkB1HnMW3z1tQH1ek79CTQtX';
const _basic1 = '6gYaFMp7H5iao1wDJ7q7BAaXjLJi1w6UvSrGH14oUv4n';

const _pushNotifications = '384J5ei4zbK7N7tGrEUwoTThDbxWtNbdYaiD2kC9v2CL';
