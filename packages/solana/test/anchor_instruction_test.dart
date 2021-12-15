import 'dart:io';

import 'package:solana/src/anchor/instruction.dart';
import 'package:solana/src/crypto/ed25519_hd_keypair.dart';
import 'package:solana/src/encoder/account_meta.dart';
import 'package:solana/src/encoder/constants.dart';
import 'package:solana/src/encoder/message.dart';
import 'package:solana/src/programs/system_program/system_instruction.dart';
import 'package:solana/src/rpc/client.dart';
import 'package:solana/src/rpc/dto/confirmation_status.dart';
import 'package:solana/src/subscription_client/subscription_client.dart';
import 'package:test/test.dart';

import 'airdrop.dart';
import 'anchor_tutorial_types/basic1.dart';
import 'config.dart';

void main() {
  late final Ed25519HDKeyPair payer;
  late final Ed25519HDKeyPair updater;
  late final SubscriptionClient subscriptionClient;
  final rpcClient = RpcClient(devnetRpcUrl);

  setUpAll(() async {
    subscriptionClient = await SubscriptionClient.connect(devnetWebsocketUrl);
    payer = await Ed25519HDKeyPair.random();
    updater = await Ed25519HDKeyPair.random();

    await airdrop(rpcClient, subscriptionClient, payer, sol: 10);
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
    final signature = await rpcClient.signAndSendTransaction(
      message,
      [payer],
    );
    await subscriptionClient.waitForSignatureStatus(
      signature,
      status: ConfirmationStatus.finalized,
    );

    expect(signature, isNotNull);
  }, skip: true);

  test('Call basic-1 initialize method', () async {
    // 8 bytes for the discriminator and 8 bytes for the data
    const space = 16;
    final rent = await rpcClient.getMinimumBalanceForRentExemption(space);
    final instructions = [
      SystemInstruction.createAccount(
        lamports: rent,
        owner: _basic1,
        pubKey: updater.address,
        creator: payer.address,
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
    final signature = await rpcClient.signAndSendTransaction(
      message,
      [
        payer,
        updater,
      ],
    );
    await subscriptionClient.waitForSignatureStatus(
      signature,
      status: ConfirmationStatus.finalized,
    );

    final account = await rpcClient.getAccountInfo(updater.address);
    expect(account, isNotNull);
    final rawData = account?.data;
    expect(rawData, isNotNull);
    final data = Basic1DataAccount.fromAccountData(rawData!);
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
    final signature = await rpcClient.signAndSendTransaction(
      message,
      [payer],
    );
    await subscriptionClient.waitForSignatureStatus(
      signature,
      status: ConfirmationStatus.finalized,
    );

    final discriminator = await computeDiscriminator('account', 'MyAccount');
    final account = await rpcClient.getAccountInfo(updater.address);
    expect(account, isNotNull);
    final rawData = account?.data;
    expect(rawData, isNotNull);
    final dataAccount = Basic1DataAccount.fromAccountData(rawData!);
    expect(dataAccount.data, equals(25));
    expect(dataAccount.discriminator, equals(discriminator));
  }, skip: true);
}

final _basic0 = Platform.environment['PROGRAM_ID_BASIC_0'] ??
    '73JSEtceE6QVgN44rfYtfkB1HnMW3z1tQH1ek79CTQtX';
final _basic1 = Platform.environment['PROGRAM_ID_BASIC_1'] ??
    '6gYaFMp7H5iao1wDJ7q7BAaXjLJi1w6UvSrGH14oUv4n';
