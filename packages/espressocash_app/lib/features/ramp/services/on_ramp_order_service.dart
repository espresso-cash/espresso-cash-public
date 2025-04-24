import 'dart:async';

import 'package:dfunc/dfunc.dart';
import 'package:drift/drift.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

import '../../../data/db/db.dart';
import '../../accounts/auth_scope.dart';
import '../../analytics/analytics_manager.dart';
import '../../currency/models/amount.dart';
import '../../currency/models/currency.dart';
import '../../ramp_partner/models/ramp_partner.dart';
import '../../ramp_partner/models/ramp_type.dart';
import '../../tokens/data/token_repository.dart';
import '../../tokens/token.dart';

typedef OnRampOrder =
    ({
      String id,
      DateTime created,
      Amount submittedAmount,
      CryptoAmount? receiveAmount,
      RampPartner partner,
      OnRampOrderStatus status,
      String partnerOrderId,
      DepositDetails? manualDeposit,
      String? authToken,
      AdditionalDetails additionalDetails,
    });

typedef DepositDetails =
    ({String bankAccount, String bankName, DateTime transferExpiryDate, FiatAmount transferAmount});

typedef AdditionalDetails = ({FiatAmount? fee, String? referenceNumber, String? moreInfoUrl});

@Singleton(scope: authScope)
class OnRampOrderService implements Disposable {
  OnRampOrderService(this._db, this._tokenRepository, this._analytics);

  final Map<String, StreamSubscription<void>> _subscriptions = {};

  final MyDatabase _db;
  final TokenRepository _tokenRepository;
  final AnalyticsManager _analytics;

  @PostConstruct(preResolve: true)
  Future<void> init() async {
    final query = _db.select(_db.onRampOrderRows)
      ..where((tbl) => tbl.status.equalsValue(OnRampOrderStatus.waitingForDeposit));

    final orders = await query.get();

    for (final order in orders) {
      switch (order.partner) {
        case RampPartner.moneygram:
        case RampPartner.brij:
          continue;
        case RampPartner.kado:
        case RampPartner.coinflow:
        case RampPartner.guardarian:
        case RampPartner.rampNetwork:
          _subscribe(order.id);
      }
    }
  }

  AsyncResult<String> create({
    required String orderId,
    required RampPartner partner,
    required CryptoAmount submittedAmount,
    CryptoAmount? receiveAmount,
    OnRampOrderStatus status = OnRampOrderStatus.waitingForPartner,
    String? bankAccount,
    String? bankName,
    DateTime? transferExpiryDate,
    FiatAmount? transferAmount,
    required String countryCode,
  }) => tryEitherAsync((_) async {
    {
      final order = OnRampOrderRow(
        id: const Uuid().v4(),
        partnerOrderId: orderId,
        amount: submittedAmount.value,
        token: Token.usdc.address,
        humanStatus: '',
        machineStatus: '',
        isCompleted: false,
        created: DateTime.now(),
        txHash: '',
        partner: partner,
        receiveAmount: receiveAmount?.value,
        status: status,
        bankAccount: bankAccount,
        bankName: bankName,
        bankTransferExpiry: transferExpiryDate,
        bankTransferAmount: transferAmount?.value,
        fiatSymbol: transferAmount?.currency.symbol,
        authToken: null,
        moreInfoUrl: null,
      );

      await _db.into(_db.onRampOrderRows).insert(order);
      _subscribe(order.id);

      _analytics.rampInitiated(
        partnerName: partner.name,
        rampType: RampType.onRamp.name,
        amount: submittedAmount.value.toString(),
        countryCode: countryCode,
        id: order.id,
      );

      return order.id;
    }
  });

  AsyncResult<String> createForManualTransfer({
    required String orderId,
    required RampPartner partner,
    required CryptoAmount submittedAmount,
    required CryptoAmount? receiveAmount,
    required String? bankAccount,
    required String? bankName,
    required DateTime? transferExpiryDate,
    required FiatAmount transferAmount,
    OnRampOrderStatus status = OnRampOrderStatus.waitingForDeposit,
    required String countryCode,
  }) => create(
    orderId: orderId,
    partner: partner,
    submittedAmount: submittedAmount,
    receiveAmount: receiveAmount,
    bankAccount: bankAccount,
    bankName: bankName,
    transferExpiryDate: transferExpiryDate,
    transferAmount: transferAmount,
    status: status,
    countryCode: countryCode,
  );

  Future<void> confirmDeposit(String orderId) async {
    final query = _db.select(_db.onRampOrderRows)..where((tbl) => tbl.id.equals(orderId));
    final order = await query.getSingle();

    final updateQuery = _db.update(_db.onRampOrderRows)..where((tbl) => tbl.id.equals(orderId));

    switch (order.status) {
      case OnRampOrderStatus.waitingForDeposit:
        await updateQuery.write(
          const OnRampOrderRowsCompanion(status: Value(OnRampOrderStatus.waitingForPartner)),
        );
      case OnRampOrderStatus.depositExpired:
      case OnRampOrderStatus.waitingPartnerReview:
      case OnRampOrderStatus.waitingForPartner:
      case OnRampOrderStatus.failure:
      case OnRampOrderStatus.completed:
      case OnRampOrderStatus.pending:
      case OnRampOrderStatus.preProcessing:
      case OnRampOrderStatus.postProcessing:
      case OnRampOrderStatus.waitingForBridge:
      case OnRampOrderStatus.rejected:
        break;
    }
  }

  Future<void> delete(String orderId) async {
    final query = _db.select(_db.onRampOrderRows)..where((tbl) => tbl.id.equals(orderId));
    final order = await query.getSingle();

    if (!order.status.isCancellable) {
      return;
    }

    await (_db.delete(_db.onRampOrderRows)..where((tbl) => tbl.id.equals(orderId))).go();
  }

  Stream<OnRampOrder> watch(String id) {
    final query = _db.select(_db.onRampOrderRows)..where((tbl) => tbl.id.equals(id));

    return query.watchSingle().asyncMap((row) async {
      final bankAccount = row.bankAccount;
      final bankName = row.bankName;
      final transferExpiryDate = row.bankTransferExpiry;
      final transferAmount = row.bankTransferAmount;
      final fiatSymbol = row.fiatSymbol;
      final moreInfoUrl = row.moreInfoUrl;

      final isManualDeposit = bankName != null && transferAmount != null && fiatSymbol != null;

      final Token? token = await _tokenRepository.getToken(row.token);

      final feeAmount = row.feeAmount?.let(
        (it) =>
            Amount(value: it, currency: currencyFromString(row.fiatSymbol ?? 'USD')) as FiatAmount,
      );

      final isFiat = row.partner == RampPartner.brij;

      final submittedAmount =
          isFiat
              ? FiatAmount(
                value: row.amount,
                fiatCurrency: currencyFromString(row.fiatSymbol ?? 'USD'),
              )
              : CryptoAmount(
                value: row.amount,
                cryptoCurrency: CryptoCurrency(token: token ?? Token.unk),
              );

      return (
        id: row.id,
        created: row.created,
        submittedAmount: submittedAmount,
        receiveAmount: row.receiveAmount?.let(
          (amount) => CryptoAmount(
            value: amount,
            cryptoCurrency: CryptoCurrency(token: token ?? Token.unk),
          ),
        ),
        partner: row.partner,
        status: row.status,
        partnerOrderId: row.partnerOrderId,
        manualDeposit:
            isManualDeposit
                ? (
                  bankAccount: bankAccount ?? '',
                  bankName: bankName,
                  transferExpiryDate: transferExpiryDate ?? DateTime.now(),
                  transferAmount: FiatAmount(
                    value: transferAmount,
                    fiatCurrency: currencyFromString(fiatSymbol),
                  ),
                )
                : null,
        authToken: row.authToken,
        additionalDetails: (
          fee: feeAmount,
          moreInfoUrl: moreInfoUrl,
          referenceNumber: row.referenceNumber,
        ),
      );
    });
  }

  Stream<IList<({String id, DateTime created})>> watchPending() {
    final query = _db.select(_db.onRampOrderRows)
      ..where((tbl) => tbl.isCompleted.equals(false) & tbl.status.isNotValue('pending'));

    return query
        .watch()
        .map((rows) => rows.map((r) => (id: r.id, created: r.created)))
        .map((rows) => rows.toIList());
  }

  void _subscribe(String orderId) {
    _subscriptions[orderId] = Stream<void>.periodic(const Duration(seconds: 5))
        .asyncMap((_) async {
          final order =
              await (_db.select(_db.onRampOrderRows)
                ..where((tbl) => tbl.id.equals(orderId))).getSingle();

          if (order.status != OnRampOrderStatus.waitingForDeposit) {
            await _subscriptions.remove(orderId)?.cancel();

            return null;
          }

          final expiry = order.bankTransferExpiry;
          if (expiry != null && expiry.isBefore(DateTime.now())) {
            return OnRampOrderRowsCompanion(
              id: Value(order.id),
              status: const Value(OnRampOrderStatus.depositExpired),
            );
          }
        })
        .whereNotNull()
        .listen((event) async {
          await _subscriptions.remove(orderId)?.cancel();

          await (_db.update(_db.onRampOrderRows)
            ..where((tbl) => tbl.id.equals(orderId))).write(event);
        });
  }

  @override
  Future<void> onDispose() async {
    await Future.wait(_subscriptions.values.map((it) => it.cancel()));
    await _db.delete(_db.onRampOrderRows).go();
  }
}

extension OnRampOrderStatusExt on OnRampOrderStatus {
  bool get isCancellable =>
      this == OnRampOrderStatus.depositExpired ||
      this == OnRampOrderStatus.pending ||
      this == OnRampOrderStatus.preProcessing ||
      this == OnRampOrderStatus.postProcessing ||
      this == OnRampOrderStatus.rejected ||
      this == OnRampOrderStatus.failure;
}
