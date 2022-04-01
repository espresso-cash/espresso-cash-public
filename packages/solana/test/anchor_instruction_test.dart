import 'dart:io';

import 'package:solana/anchor.dart';
import 'package:solana/dto.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';
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
    subscriptionClient = SubscriptionClient.connect(devnetWebsocketUrl);
    payer = await Ed25519HDKeyPair.random();
    updater = await Ed25519HDKeyPair.random();

    await airdrop(rpcClient, subscriptionClient, payer, sol: 10);
  });

  test(
    'Call basic-0 initialize method',
    () async {
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
    },
    skip: true,
  );

  test(
    'Call basic-1 initialize method',
    () async {
      // 8 bytes for the discriminator and 8 bytes for the data
      const space = 16;
      final rent = await rpcClient.getMinimumBalanceForRentExemption(space);
      final instructions = [
        SystemInstruction.createAccount(
          lamports: rent,
          owner: _basic1,
          newAccount: updater.publicKey,
          fundingAccount: payer.publicKey,
          space: space,
        ),
        await AnchorInstruction.forMethod(
          programId: _basic1,
          method: 'initialize',
          arguments: const Basic1Arguments(data: 100),
          accounts: <AccountMeta>[
            AccountMeta.writeable(pubKey: updater.publicKey, isSigner: false),
            AccountMeta.readonly(
              pubKey: Ed25519HDPublicKey.fromBase58(Sysvar.rent),
              isSigner: false,
            ),
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
    },
    skip: true,
  );

  test(
    'Call basic-1 update method',
    () async {
      // Call update
      final instructions = [
        await AnchorInstruction.forMethod(
          programId: _basic1,
          method: 'update',
          arguments: const Basic1Arguments(data: 25),
          accounts: <AccountMeta>[
            AccountMeta.writeable(pubKey: updater.publicKey, isSigner: false),
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
    },
    skip: true,
  );
}

final _basic0 = Ed25519HDPublicKey.fromBase58(
  Platform.environment['PROGRAM_ID_BASIC_0'] ??
      '73JSEtceE6QVgN44rfYtfkB1HnMW3z1tQH1ek79CTQtX',
);
final _basic1 = Ed25519HDPublicKey.fromBase58(
  Platform.environment['PROGRAM_ID_BASIC_1'] ??
      '6gYaFMp7H5iao1wDJ7q7BAaXjLJi1w6UvSrGH14oUv4n',
);
