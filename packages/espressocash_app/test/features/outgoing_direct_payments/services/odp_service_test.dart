import 'dart:async';
import 'dart:typed_data';

import 'package:dfunc/dfunc.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:espressocash_app/features/accounts/models/ec_wallet.dart';
import 'package:espressocash_app/features/currency/models/amount.dart';
import 'package:espressocash_app/features/currency/models/currency.dart';
import 'package:espressocash_app/features/outgoing_direct_payments/data/repository.dart';
import 'package:espressocash_app/features/outgoing_direct_payments/models/outgoing_direct_payment.dart';
import 'package:espressocash_app/features/outgoing_direct_payments/services/odp_service.dart';
import 'package:espressocash_app/features/payments/create_direct_payment.dart';
import 'package:espressocash_app/features/tokens/token.dart';
import 'package:espressocash_app/features/transactions/models/tx_results.dart';
import 'package:espressocash_app/features/transactions/services/tx_confirm.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

import '../../../stub_analytics_manager.dart';
import '../../../stub_refresh_balance.dart';
import 'odp_service_test.mocks.dart';

final confirm = MockTxConfirm();
final createDirectPayment = MockCreateDirectPayment();
final client = MockEspressoCashClient();

@GenerateMocks([
  TxConfirm,
  CreateDirectPayment,
  EspressoCashClient,
])
Future<void> main() async {
  final account = LocalWallet(await Ed25519HDKeyPair.random());
  final receiver = await Ed25519HDKeyPair.random();
  final repository = MemoryRepository();

  setUp(() {
    reset(confirm);
    reset(createDirectPayment);
    reset(client);
  });

  tearDown(
    () async {
      await repository.onDispose();
    },
  );

  final stubTx = await Message.only(
    MemoInstruction(signers: const [], memo: 'test'),
  )
      .compile(
        recentBlockhash: 'EkSnNWid2cvwEVnVx9aBqawnmiCNiDgp3gUdkDPTKN1N',
        feePayer: account.publicKey,
      )
      .let(
        (it) async => SignedTx(
          compiledMessage: it,
          signatures: await account.sign(
            [it.toByteArray().toList().let(Uint8List.fromList)],
          ),
        ),
      );

  final testDirectPaymentResult =
      DirectPaymentResult(fee: 100, transaction: stubTx);

  final testApiResponse = SubmitDurableTxResponseDto(
    signature: stubTx.encode(),
  );

  const testAmount = CryptoAmount(
    value: 100000000,
    cryptoCurrency: CryptoCurrency(token: Token.usdc),
  );

  ODPService createService() => ODPService(
        client,
        repository,
        confirm,
        const StubAnalyticsManager(),
        createDirectPayment,
        const StubRefreshBalance(),
      );

  Future<String> createODP(ODPService service) async {
    final payment = await service.create(
      account: account,
      amount: testAmount,
      receiver: receiver.publicKey,
      reference: null,
    );

    return payment.id;
  }

  test('Happy path', () async {
    provideDummy<TxSendResult>(const TxSendSent());
    provideDummy<TxWaitResult>(const TxWaitSuccess());

    when(
      createDirectPayment(
        aReceiver: anyNamed('aReceiver'),
        aReference: anyNamed('aReference'),
        aSender: anyNamed('aSender'),
        amount: anyNamed('amount'),
        commitment: anyNamed('commitment'),
      ),
    ).thenAnswer((_) async => testDirectPaymentResult);

    when(client.submitDurableTx(any)).thenAnswer((_) async => testApiResponse);
    when(confirm(txId: anyNamed('txId')))
        .thenAnswer((_) async => const TxWaitResult.success());

    final paymentId = await createService().let(createODP);
    final payment = repository.watch(paymentId);

    await expectLater(
      payment,
      emitsInOrder(
        [
          isA<OutgoingDirectPayment>()
              .having((it) => it.status, 'status', isA<ODPStatusTxCreated>()),
          isA<OutgoingDirectPayment>()
              .having((it) => it.status, 'status', isA<ODPStatusTxSent>()),
          isA<OutgoingDirectPayment>()
              .having((it) => it.status, 'status', isA<ODPStatusSuccess>()),
        ],
      ),
    );

    verify(client.submitDurableTx(any)).called(1);
    verify(confirm(txId: anyNamed('txId'))).called(1);
  });

  test('Failed to create direct durable payment', () async {
    provideDummy<TxSendResult>(
      const TxSendFailure(reason: TxFailureReason.unknown),
    );
    provideDummy<TxWaitResult>(
      const TxWaitFailure(reason: TxFailureReason.unknown),
    );

    when(
      createDirectPayment(
        aReceiver: anyNamed('aReceiver'),
        aReference: anyNamed('aReference'),
        aSender: anyNamed('aSender'),
        amount: anyNamed('amount'),
        commitment: anyNamed('commitment'),
      ),
    ).thenAnswer((_) async => throw Exception());

    final paymentId = await createService().let(createODP);
    final payment = repository.watch(paymentId);

    await expectLater(
      payment,
      emitsInOrder(
        [
          isA<OutgoingDirectPayment>()
              .having((it) => it.status, 'status', isA<ODPStatusTxFailure>()),
        ],
      ),
    );

    verifyNever(client.submitDurableTx(any));
    verifyNever(confirm(txId: anyNamed('txId')));
  });
}

typedef PaymentMap = IMap<String, OutgoingDirectPayment>;

class MemoryRepository implements ODPRepository {
  final _data = BehaviorSubject<PaymentMap>.seeded(PaymentMap());

  @override
  Future<OutgoingDirectPayment?> load(String id) async => _data.value[id];

  @override
  Future<void> save(OutgoingDirectPayment payment) async {
    _data.add(_data.value.add(payment.id, payment));
  }

  @override
  Future<void> onDispose() async {
    _data.add(_data.value.clear());
  }

  @override
  Future<void> delete(String id) async {
    _data.add(_data.value.remove(id));
  }

  @override
  Stream<OutgoingDirectPayment> watch(String id) =>
      // ignore: avoid-non-null-assertion, should fail if not existent
      _data.stream.map((it) => it[id]!);

  @override
  Future<IList<String>> getNonCompletedPaymentIds() => _data.stream
      .map(
        (it) => it.values
            .where(
              (it) => switch (it.status) {
                ODPStatusTxCreated() || ODPStatusTxSent() => true,
                ODPStatusSuccess() || ODPStatusTxFailure() => false,
              },
            )
            .map((e) => e.id)
            .toIList(),
      )
      .first;
}
