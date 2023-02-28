import 'dart:async';

import 'package:decimal/decimal.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/base58.dart';

import '../../../../core/amount.dart';
import '../../../../core/cancelable_job.dart';
import '../../../../core/link_shortener.dart';
import '../../../../core/single_key_payments.dart';
import '../../../../core/split_key_payments.dart';
import '../../models/outgoing_split_key_payment.dart';
import 'payment_watcher.dart';
import 'repository.dart';

/// Watches for [OSKPStatus.txConfirmed] payments and generates the links.
@injectable
class TxConfirmedWatcher extends PaymentWatcher {
  TxConfirmedWatcher(super._repository, this._shortener);

  final LinkShortener _shortener;

  @override
  CancelableJob<OutgoingSplitKeyPayment> createJob(
    OutgoingSplitKeyPayment payment,
  ) =>
      _OSKPConfirmedJob(payment, _shortener);

  @override
  Stream<IList<OutgoingSplitKeyPayment>> watchPayments(
    OSKPRepository repository,
  ) =>
      repository.watchTxConfirmed();
}

class _OSKPConfirmedJob extends CancelableJob<OutgoingSplitKeyPayment> {
  _OSKPConfirmedJob(this.payment, this._linkShortener);

  final OutgoingSplitKeyPayment payment;
  final LinkShortener _linkShortener;

  @override
  Future<OutgoingSplitKeyPayment?> process() async {
    final status = payment.status;
    if (status is! OSKPStatusTxConfirmed) {
      return payment;
    }

    final token = payment.amount.token;

    final privateKey = status.escrow.bytes.lock;
    final keyParts = _splitKey(privateKey);

    final rawFirstLink = SplitKeyFirstLink(
      key: keyParts.first,
      token: token.publicKey,
    ).toUri();

    final firstLink = await _linkShortener.buildShortUrl(rawFirstLink) ??
        _linkShortener.buildFullUrl(rawFirstLink);

    final secondLink = SplitKeySecondLink(key: keyParts.last).toUri();

    Uri? qrLink;

    if (payment.amount.decimal <= _qrLinkThreshold) {
      final key = base58encode(privateKey.toList());
      final rawQrLink = SingleKeyPaymentData(
        key: key,
        token: token.publicKey,
      ).toUri();

      qrLink = _linkShortener.buildFullUrl(rawQrLink);
    }

    final newStatus = OSKPStatus.linksReady(
      link1: firstLink,
      link2: secondLink,
      qrLink: qrLink,
      escrow: status.escrow,
    );

    return payment.copyWith(status: newStatus);
  }
}

/// The maximum amount that a QR code will be generated together with links.
final _qrLinkThreshold = Decimal.parse('10.0');

List<String> _splitKey(IList<int> privateKey) {
  final parts = privateKey.splitAt(privateKey.length ~/ 2);

  return [
    base58encode(parts.first.toList()),
    base58encode(parts.second.toList()),
  ];
}
