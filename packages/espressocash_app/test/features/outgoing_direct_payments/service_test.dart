import 'dart:async';
import 'dart:typed_data';

import 'package:dfunc/dfunc.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:espressocash_app/core/amount.dart';
import 'package:espressocash_app/core/currency.dart';
import 'package:espressocash_app/core/tokens/token.dart';
import 'package:espressocash_app/features/accounts/models/ec_wallet.dart';
import 'package:espressocash_app/features/outgoing_direct_payments/data/repository.dart';
import 'package:espressocash_app/features/outgoing_direct_payments/models/outgoing_direct_payment.dart';
import 'package:espressocash_app/features/outgoing_direct_payments/services/odp_service.dart';
import 'package:espressocash_app/features/outgoing_direct_payments/services/tx_created_watcher.dart';
import 'package:espressocash_app/features/outgoing_direct_payments/services/tx_sent_watcher.dart';
import 'package:espressocash_app/features/transactions/models/tx_sender.dart';
import 'package:espressocash_app/features/transactions/services/tx_sender.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

import 'service_test.mocks.dart';

final sender = MockTxSender();
final client = MockCryptopleaseClient();

@GenerateMocks([TxSender, CryptopleaseClient])
Future<void> main() async {
  late TxCreatedWatcher txCreatedWatcher;
  late TxSentWatcher txSentWatcher;

  final account = LocalWallet(await Ed25519HDKeyPair.random());
  final receiver = await Ed25519HDKeyPair.random();
  final repository = MemoryRepository();

  setUp(() {
    reset(sender);
    reset(client);

    txCreatedWatcher = TxCreatedWatcher(repository, sender)
      ..call(onBalanceAffected: ignore);
    txSentWatcher = TxSentWatcher(repository, sender)
      ..call(onBalanceAffected: ignore);
  });

  tearDown(
    () async {
      txCreatedWatcher.dispose();
      txSentWatcher.dispose();
      await repository.clear();
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
      )
      .then((it) => it.encode());

  final testApiResponse = CreateDirectPaymentResponseDto(
    fee: 100,
    transaction: stubTx,
    slot: BigInt.zero,
  );

  const testAmount = CryptoAmount(
    value: 100000000,
    cryptoCurrency: CryptoCurrency(token: Token.usdc),
  );

  ODPService createService() => ODPService(client, repository);

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
    when(client.createDirectPayment(any))
        .thenAnswer((_) async => testApiResponse);

    when(sender.send(any, minContextSlot: anyNamed('minContextSlot')))
        .thenAnswer((_) async => const TxSendResult.sent());
    when(sender.wait(any, minContextSlot: anyNamed('minContextSlot')))
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
              .having((it) => it.status, 'status', isA<ODPStatusSuccess>())
        ],
      ),
    );

    verify(sender.send(any, minContextSlot: anyNamed('minContextSlot')))
        .called(1);
    verify(sender.wait(any, minContextSlot: anyNamed('minContextSlot')))
        .called(1);
  });

  test('Failed to get tx from API', () async {
    when(client.createDirectPayment(any)).thenAnswer((_) => throw Exception());

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

    verifyNever(sender.send(any, minContextSlot: anyNamed('minContextSlot')));
    verifyNever(sender.wait(any, minContextSlot: anyNamed('minContextSlot')));
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
  Future<void> clear() async {
    _data.add(_data.value.clear());
  }

  @override
  Stream<OutgoingDirectPayment> watch(String id) =>
      // ignore: avoid-non-null-assertion, should fail if not existent
      _data.stream.map((it) => it[id]!);

  @override
  Stream<IList<OutgoingDirectPayment>> watchTxCreated() => _data.stream.map(
        (it) => it.values
            .where((it) => it.status.maybeMap(orElse: F, txCreated: T))
            .toIList(),
      );

  @override
  Stream<IList<OutgoingDirectPayment>> watchTxSent() => _data.stream.map(
        (it) => it.values
            .where((it) => it.status.maybeMap(orElse: F, txSent: T))
            .toIList(),
      );
}
