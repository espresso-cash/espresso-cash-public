import 'dart:async';

import 'package:collection/collection.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:solana/dto.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';
import 'package:solana/solana_pay.dart';

import '../../../di.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/loader.dart';
import '../../../ui/snackbar.dart';
import '../../accounts/models/account.dart';
import '../../currency/models/amount.dart';
import '../../currency/models/currency.dart';
import '../../tokens/token.dart';
import '../screens/confirmation_screen.dart';
import '../screens/tr_details_screen.dart';
import '../service/tr_service.dart';
import 'solana_client_ext.dart';

typedef TransactionRequestResult = ({
  CryptoAmount amount,
  BigInt slot,
  TransactionRequestInfo info,
  SignedTx tx,
  String? message,
});

extension BuildContextExt on BuildContext {
  Future<void> processSolanaTransactionRequest(
    SolanaTransactionRequest request,
  ) async {
    final response =
        await runWithLoader<TransactionRequestResult?>(this, () async {
      final info = await request.get();

      final wallet = sl<MyAccount>().wallet.publicKey;
      final client = sl<SolanaClient>();

      final postResponse = await request.post(account: wallet.toBase58());

      final isUsdcTransfer = postResponse.transaction
          .let(SignedTx.decode)
          .let(_checkIfUsdcTransfer);

      if (!isUsdcTransfer) {
        showCpErrorSnackbar(this, message: 'Error. Can only transfer USDC');

        return null;
      }

      final hasUsdcAccount = await client.hasUsdcAccount(wallet);

      if (!hasUsdcAccount) {
        showCpErrorSnackbar(this, message: l10n.errorMessageInsufficientFunds);

        return null;
      }

      final tx = await client.processSolanaPayTransactionRequest(
        transaction: postResponse.transaction,
        signer: wallet,
        ignoreSignerVerification: true,
      );

      final simulate = await client.simulateTransfer(
        tx: tx,
        account: wallet,
        currency: Currency.usdc,
      );

      if (simulate == null) {
        showCpErrorSnackbar(this, message: l10n.tryAgainLater);

        return null;
      }

      return (
        amount: CryptoAmount(
          value: simulate.amountTransferred,
          cryptoCurrency: Currency.usdc,
        ),
        slot: simulate.slot,
        info: info,
        tx: tx,
        message: postResponse.message,
      );
    }).onError((__, _) {
      showCpErrorSnackbar(this, message: l10n.tryAgainLater);
    });

    if (response == null) return;

    final confirmationResult = await TRConfirmationScreen.push(
      this,
      request: response.info,
      amount: response.amount,
      message: response.message,
    );

    if (confirmationResult == true) {
      final id = await _createTR(
        tx: response.tx,
        amount: response.amount,
        slot: response.slot,
        label: response.info.label,
      );

      if (!mounted) return;
      TRDetailsScreen.push(this, id: id);
    }
  }

  Future<String> _createTR({
    required SignedTx tx,
    required CryptoAmount amount,
    required BigInt slot,
    required String label,
  }) =>
      runWithLoader(
        this,
        () async => sl<TRService>().create(
          tx: tx,
          amount: amount,
          slot: slot,
          label: label,
        ),
      );
}

bool _checkIfUsdcTransfer(SignedTx tx) => tx
        .decompileMessage()
        .instructions
        .firstWhereOrNull(
          (e) => e.programId.toBase58() == TokenProgram.programId,
        )
        .let((i) {
      if (i == null) return false;

      return i.accounts
          .map((e) => e.pubKey.toBase58())
          .toList()
          .contains(Token.usdc.address);
    });

extension SolanaClientExt on SolanaClient {
  Future<bool> hasUsdcAccount(Ed25519HDPublicKey account) async {
    final tokenAddress = await findAssociatedTokenAddress(
      owner: account,
      mint: Token.usdc.publicKey,
    );

    final accountInfo = await rpcClient.getAccountInfo(
      tokenAddress.toBase58(),
      encoding: Encoding.base64,
      commitment: Commitment.confirmed,
    );

    return accountInfo.value != null;
  }
}
