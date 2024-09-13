import 'package:dfunc/dfunc.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:solana/dto.dart';
import 'package:solana/solana.dart';

import '../../../config.dart';
import '../models/tx_results.dart';

@injectable
class TxConfirm {
  const TxConfirm({
    required SolanaClient client,
  }) : _client = client;

  final SolanaClient _client;

  Future<TxWaitResult?> call({required String txId}) {
    final sentryTx = Sentry.startTransaction(
      'Wait TX confirmation',
      'TxConfirm.wait()',
      waitForChildren: true,
      // ignore: avoid-missing-interpolation, as intended
    )..setData('txId', txId);

    const commitment = Commitment.confirmed;

    Future<TxWaitResult?> getSignatureStatus(ISentrySpan span) async {
      final innerSpan = span.startChild('getSignatureStatus()');
      _logger.fine('$txId: Checking tx status.');

      final statuses = await _client.rpcClient.getSignatureStatuses(
        [txId],
        searchTransactionHistory: true,
      );
      final t = statuses.value.first;

      if (t == null) {
        innerSpan.status = const SpanStatus.aborted();
        _logger.fine('$txId: Tx not found.');

        return null;
      }

      if (t.err != null) {
        const reason = TxFailureReason.txError;
        innerSpan.setData('reason', 'Tx error ${t.err}.');
        await innerSpan.finish();
        _logger.fine('$txId: Tx error ${t.err}.');

        return const TxWaitResult.failure(reason: reason);
      }

      if (t.confirmationStatus.index >= ConfirmationStatus.confirmed.index) {
        innerSpan.status = const SpanStatus.ok();
        await innerSpan.finish();
        _logger.fine('$txId: Success.');

        return const TxWaitResult.success();
      }

      innerSpan.setData(
        'reason',
        'Wrong confirmation status ${t.confirmationStatus}.',
      );
      await innerSpan.finish();
      _logger.fine('$txId: Wrong confirmation status ${t.confirmationStatus}.');
    }

    Future<TxWaitResult?> waitForSignatureStatus(ISentrySpan span) async {
      final innerSpan = span.startChild('waitForSignatureStatus()');
      try {
        await _client.waitForSignatureStatus(
          txId,
          status: commitment,
          pingInterval: pingDefaultInterval,
          timeout: waitForSignatureDefaultTimeout,
        );

        innerSpan.status = const SpanStatus.ok();
        await innerSpan.finish();
        _logger.fine('$txId: Success from WS.');

        return const TxWaitResult.success();
      } on SubscriptionClientException catch (error) {
        const reason = TxFailureReason.txError;
        innerSpan
          ..setData('reason', 'Failure from WS $error.')
          ..status = const SpanStatus.aborted();
        await innerSpan.finish();
        _logger.fine('$txId: Failure from WS $error.');

        return const TxWaitResult.failure(reason: reason);
      } on Exception catch (error) {
        innerSpan
          ..setData('reason', 'Network error from WS $error.')
          ..status = const SpanStatus.aborted();
        await innerSpan.finish();
        _logger.fine('$txId: Network error from WS $error.');

        return null;
      }
    }

    final polling = Stream<void>.periodic(const Duration(seconds: 10))
        .startWith(null)
        .exhaustMap(
          (_) => getSignatureStatus(sentryTx).asStream().onErrorReturn(null),
        );

    return MergeStream([
      polling,
      waitForSignatureStatus(sentryTx).asStream().onErrorReturn(null),
    ]).whereNotNull().first.alsoAsync((result) {
      sentryTx.finish(
        status: switch (result) {
          TxWaitSuccess() => const SpanStatus.ok(),
          TxWaitFailure() => const SpanStatus.aborted(),
          TxWaitNetworkError() => const SpanStatus.unknownError(),
        },
      );
    });
  }
}

final _logger = Logger('TxConfirm');
