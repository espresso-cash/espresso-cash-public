import 'package:solana/src/constants.dart';
import 'package:solana/src/crypto/ed25519_hd_keypair.dart';
import 'package:solana/src/encoder/message.dart';
import 'package:solana/src/programs/token_program/token_program.dart';
import 'package:solana/src/rpc/client.dart';
import 'package:solana/src/rpc/dto/confirmation_status.dart';
import 'package:solana/src/subscription_client/subscription_client.dart';
import 'package:test/test.dart';

import 'config.dart';

void main() {
  late final Ed25519HDKeyPair mint;
  late final Ed25519HDKeyPair freezeAuthority;
  late final Ed25519HDKeyPair mintAuthority;
  late final Ed25519HDKeyPair tokensHolder;
  late final Ed25519HDKeyPair randomRecipient;

  final rpcClient = RpcClient(devnetRpcUrl);
  final subscriptionClient = SubscriptionClient.connect(devnetWebsocketUrl);

  setUpAll(() async {
    mint = await Ed25519HDKeyPair.random();
    freezeAuthority = await Ed25519HDKeyPair.random();
    mintAuthority = await Ed25519HDKeyPair.random();
    tokensHolder = await Ed25519HDKeyPair.random();
    randomRecipient = await Ed25519HDKeyPair.random();

    final signature = await rpcClient.requestAirdrop(
      mintAuthority.address,
      10 * lamportsPerSol,
    );

    await subscriptionClient.waitForSignatureStatus(
      signature,
      status: ConfirmationStatus.finalized,
    );
  });

  final sendMessage = (
    Message message,
    List<Ed25519HDKeyPair> signers,
  ) =>
      _sendMessage(
        rpcClient: rpcClient,
        subscriptionClient: subscriptionClient,
        message: message,
        signers: signers,
      );

  test('Initialize Mint', () async {
    final rent = await rpcClient
        .getMinimumBalanceForRentExemption(TokenProgram.neededMintAccountSpace);
    // Not throwing is sufficient as test, we need the mint to exist
    await sendMessage(
      TokenProgram.initializeMint(
        mint: mint.address,
        mintAuthority: mintAuthority.address,
        freezeAuthority: freezeAuthority.address,
        rent: rent,
        space: TokenProgram.neededMintAccountSpace,
        decimals: 5,
      ),
      [mintAuthority, mint],
    );
  });

  test('Create Account', () async {
    final rent = await rpcClient.getMinimumBalanceForRentExemption(
      TokenProgram.neededAccountSpace,
    );

    expect(
        sendMessage(
          TokenProgram.createAccount(
            mint: mint.address,
            address: tokensHolder.address,
            owner: mintAuthority.address,
            rent: rent,
            space: TokenProgram.neededAccountSpace,
          ),
          [mintAuthority, tokensHolder],
        ),
        completes);
  });

  test('Mint To', () async {
    expect(
      sendMessage(
        TokenProgram.mintTo(
          mint: mint.address,
          destination: tokensHolder.address,
          authority: mintAuthority.address,
          amount: 10000000000,
        ),
        [mintAuthority],
      ),
      completes,
    );
  });

  test('Mint To Checked', () async {
    expect(
      sendMessage(
        TokenProgram.mintToChecked(
          mint: mint.address,
          destination: tokensHolder.address,
          authority: mintAuthority.address,
          amount: 10000000000,
          decimals: 5,
        ),
        [mintAuthority],
      ),
      completes,
    );
  });

  test('Transfer', () async {
    expect(
      sendMessage(
        TokenProgram.transfer(
          source: tokensHolder.address,
          destination: tokensHolder.address,
          owner: mintAuthority.address,
          amount: 100000,
        ),
        [mintAuthority],
      ),
      completes,
    );
  });

  test('Transfer Checked', () async {
    expect(
      sendMessage(
        TokenProgram.transferChecked(
          source: tokensHolder.address,
          destination: tokensHolder.address,
          owner: mintAuthority.address,
          amount: 100000,
          decimals: 5,
          mint: mint.address,
        ),
        [mintAuthority],
      ),
      completes,
    );
  });

  test('Approve', () async {
    expect(
      sendMessage(
        TokenProgram.approve(
          amount: 1000000,
          source: tokensHolder.address,
          delegate: randomRecipient.address,
          sourceOwner: mintAuthority.address,
        ),
        [mintAuthority],
      ),
      completes,
    );
  });

  test('Approve Checked', () async {
    expect(
      sendMessage(
        TokenProgram.approveChecked(
          amount: 1000000,
          decimals: 5,
          source: tokensHolder.address,
          delegate: randomRecipient.address,
          sourceOwner: mintAuthority.address,
          mint: mint.address,
        ),
        [mintAuthority],
      ),
      completes,
    );
  });

  test('Burn', () async {
    expect(
      sendMessage(
        TokenProgram.burn(
          amount: 100000,
          accountToBurnFrom: tokensHolder.address,
          mint: mint.address,
          owner: mintAuthority.address,
        ),
        [mintAuthority],
      ),
      completes,
    );
  });

  test('Burn Checked', () async {
    expect(
      sendMessage(
        TokenProgram.burnChecked(
          amount: 100000,
          accountToBurnFrom: tokensHolder.address,
          mint: mint.address,
          owner: mintAuthority.address,
          decimals: 5,
        ),
        [mintAuthority],
      ),
      completes,
    );
  });

  test('Freeze Account', () async {
    expect(
      sendMessage(
          TokenProgram.freezeAccount(
            accountToFreeze: tokensHolder.address,
            mint: mint.address,
            freezeAuthority: freezeAuthority.address,
          ),
          [mintAuthority, freezeAuthority]),
      completes,
    );
  });

  test('Thaw Account', () async {
    expect(
      sendMessage(
          TokenProgram.thawAccount(
            accountToFreeze: tokensHolder.address,
            mint: mint.address,
            freezeAuthority: freezeAuthority.address,
          ),
          [mintAuthority, freezeAuthority]),
      completes,
    );
  });

  test('Revoke', () async {
    expect(
      sendMessage(
          TokenProgram.revoke(
            source: randomRecipient.address,
            sourceOwner: tokensHolder.address,
          ),
          [mintAuthority, tokensHolder]),
      completes,
    );
  });

  test('Set Authority', () async {
    final newAuthority = await Ed25519HDKeyPair.random();
    expect(
      sendMessage(
          TokenProgram.setAuthority(
            mintOrAccount: mint.address,
            currentAuthority: mintAuthority.address,
            newAuthority: newAuthority.address,
            authorityType: AuthorityType.mintTokens,
          ),
          [mintAuthority]),
      completes,
    );
  }, skip: true);
}

Future<void> _sendMessage({
  required RpcClient rpcClient,
  required SubscriptionClient subscriptionClient,
  required Message message,
  required List<Ed25519HDKeyPair> signers,
}) async {
  final signature = await rpcClient.signAndSendTransaction(message, signers);
  await subscriptionClient.waitForSignatureStatus(
    signature,
    status: ConfirmationStatus.finalized,
  );
}
