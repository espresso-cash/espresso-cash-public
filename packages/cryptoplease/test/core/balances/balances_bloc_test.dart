import 'package:bloc_test/bloc_test.dart';
import 'package:cryptoplease/config.dart';
import 'package:cryptoplease/core/accounts/bl/account.dart';
import 'package:cryptoplease/core/amount.dart';
import 'package:cryptoplease/core/balances/bl/balances_bloc.dart';
import 'package:cryptoplease/core/processing_state.dart';
import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease/core/tokens/token_list.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:solana/solana.dart';

import '../../utils.dart';

void main() {
  final SolanaClient solanaClient = createTestSolanaClient();
  // ignore: avoid-non-null-assertion, cannot be null here
  final token = TokenList(data: localTokenList)
      .findTokenByMint('gfctksjBntn1EBqLYgmcPhQEf9uwPi5ds7Vs4fbsahp')!;

  group(
    'BalancesBloc:',
    () {
      late final MyAccount account;
      const initialAmount = 10 * lamportsPerSol;

      setUpAll(() async {
        final wallet = await Wallet.random();

        account = MyAccount(
          firstName: 'Tester',
          wallet: wallet,
          accessMode: const AccessMode.created(),
        );
        await solanaClient.requestAirdrop(
          address: wallet.publicKey,
          lamports: initialAmount,
          commitment: Commitment.confirmed,
        );

        await solanaClient.createTokenAccount(
          mint: token.publicKey,
          account: await Ed25519HDKeyPair.random(),
          creator: account.wallet,
          commitment: Commitment.confirmed,
        );

        await solanaClient.airdropSplTokens(
          account.publicKey,
          token,
          amount: 10000,
        );
      });

      blocTest<BalancesBloc, BalancesState>(
        'counts only main accounts',
        build: () => BalancesBloc(
          solanaClient: solanaClient,
          tokens: TokenList(),
        ),
        act: (bloc) => bloc.add(
          BalancesEvent.requested(address: account.address),
        ),
        expect: () => [
          BalancesState(processingState: const ProcessingState.processing()),
          BalancesState(
            processingState: const ProcessingState.none(),
            balances: <Token, Amount>{
              Token.sol: Amount.sol(
                // Initial balance minus fee for creating SPL accounts
                value:
                    initialAmount - tokenProgramRent - 2 * lamportsPerSignature,
              ),
              token: Amount.fromToken(value: 10000, token: token),
            },
          ),
        ],
        wait: const Duration(seconds: 5),
        tags: 'solana',
      );
    },
  );
}
