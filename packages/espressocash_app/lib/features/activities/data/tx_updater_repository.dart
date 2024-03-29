import 'package:collection/collection.dart';
import 'package:dfunc/dfunc.dart';
import 'package:drift/drift.dart';
import 'package:espressocash_common/espressocash_common.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/dto.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

import '../../../data/db/db.dart';
import '../models/transaction.dart';

@injectable
class TxUpdaterRepository {
  const TxUpdaterRepository(this._db, this._client);

  final MyDatabase _db;
  final SolanaClient _client;

  Future<void> update(Ed25519HDPublicKey publicKey) async {
    final usdcTokenAccount = await findAssociatedTokenAddress(
      owner: publicKey,
      mint: Ed25519HDPublicKey.fromBase58(Token.usdc.address),
    );

    final mostRecentTx = await _mostRecentTx();
    final mostRecentSignature = mostRecentTx?.tx.id;

    const fetchLimit = 50;

    final details = await _client.rpcClient.getTransactionsList(
      usdcTokenAccount,
      limit: fetchLimit,
      until: mostRecentSignature,
      encoding: Encoding.base64,
      commitment: Commitment.confirmed,
    );

    if (details.isNotEmpty) {
      final txs = details.map((it) => it.toFetched(usdcTokenAccount));

      final hasGap = mostRecentSignature != null && txs.length == fetchLimit;

      if (hasGap) {
        await _db.transaction(() async {
          await _db.delete(_db.transactionRows).go();
          await _saveAll(txs);
        });
      } else {
        await _saveAll(txs);
      }
    }
  }

  Future<void> clear() => _db.delete(_db.transactionRows).go();

  Future<TxCommon?> _mostRecentTx() async {
    final query = _db.select(_db.transactionRows)
      ..orderBy([(t) => OrderingTerm.desc(t.created)])
      ..limit(1);

    final result = await query.getSingleOrNull();

    return result?.toModel();
  }

  Future<void> _saveAll(Iterable<TxCommon> txs) => _db.batch(
        (batch) => batch.insertAll(
          _db.transactionRows,
          txs.map((e) => e.toRow()),
          mode: InsertMode.insertOrReplace,
        ),
      );
}

class TransactionRows extends Table {
  const TransactionRows();

  TextColumn get id => text()();
  DateTimeColumn get created => dateTime().nullable()();
  TextColumn get encodedTx => text()();
  IntColumn get status => intEnum<TxCommonStatus>()();
  IntColumn get amount => integer().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

extension TransactionRowExt on TransactionRow {
  TxCommon toModel() => TxCommon(
        SignedTx.decode(encodedTx),
        created: created,
        status: status,
        amount: amount?.let(
          (it) => CryptoAmount(value: it, cryptoCurrency: Currency.usdc),
        ),
      );
}

extension on TxCommon {
  TransactionRow toRow() => TransactionRow(
        id: tx.id,
        created: created,
        encodedTx: tx.encode(),
        status: status,
        amount: amount?.value,
      );
}

extension on TransactionDetails {
  TxCommon toFetched(Ed25519HDPublicKey usdcTokenAddress) {
    final rawTx = transaction as RawTransaction;
    final tx = SignedTx.fromBytes(rawTx.data);

    final accountIndex =
        tx.compiledMessage.accountKeys.indexWhere((e) => e == usdcTokenAddress);

    final preTokenBalance = meta?.preTokenBalances
        .where((e) => e.mint == Token.usdc.address)
        .where((e) => e.accountIndex == accountIndex)
        .firstOrNull;

    final postTokenBalance = meta?.postTokenBalances
        .where((e) => e.mint == Token.usdc.address)
        .where((e) => e.accountIndex == accountIndex)
        .firstOrNull;

    CryptoAmount? amount;

    if (preTokenBalance != null && postTokenBalance != null) {
      final rawAmount = int.parse(postTokenBalance.uiTokenAmount.amount) -
          int.parse(preTokenBalance.uiTokenAmount.amount);

      amount = CryptoAmount(
        value: rawAmount,
        cryptoCurrency: Currency.usdc,
      );
    }

    return TxCommon(
      tx,
      status:
          meta?.err == null ? TxCommonStatus.success : TxCommonStatus.failure,
      created: blockTime
          ?.let((it) => DateTime.fromMillisecondsSinceEpoch(1000 * it)),
      amount: amount,
    );
  }
}
