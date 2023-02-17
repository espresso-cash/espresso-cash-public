import 'dart:async';

import 'package:async/async.dart';
import 'package:dfunc/dfunc.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:espressocash_app/core/accounts/bl/ec_wallet.dart';
import 'package:espressocash_app/core/amount.dart';
import 'package:espressocash_app/core/currency.dart';
import 'package:espressocash_app/core/tokens/token.dart';
import 'package:espressocash_app/core/transactions/tx_sender.dart';
import 'package:espressocash_app/features/outgoing_direct_payments/models/outgoing_direct_payment.dart';
import 'package:espressocash_app/features/outgoing_direct_payments/src/bl/odp_service.dart';
import 'package:espressocash_app/features/outgoing_direct_payments/src/bl/repository.dart';
import 'package:espressocash_app/features/outgoing_direct_payments/src/bl/tx_created_watcher.dart';
import 'package:espressocash_app/features/outgoing_direct_payments/src/bl/tx_sent_watcher.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

import 'bloc_test.mocks.dart';

final sender = MockTxSender();
final client = MockCryptopleaseClient();

@GenerateMocks([TxSender, CryptopleaseClient])
Future<void> main() async {
  late final TxCreatedWatcher txCreatedWatcher;
  late final TxSentWatcher txSentWatcher;

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
          signatures: [await account.sign(it.toByteArray())],
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

    expect(
      repository.watch(paymentId),
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

    // verify(sender.send(any, minContextSlot: anyNamed('minContextSlot')))
    //     .called(1);
    // verify(sender.wait(any, minContextSlot: anyNamed('minContextSlot')))
    //     .called(1);
  });
}

typedef PaymentMap = IMap<String, OutgoingDirectPayment>;

class MemoryRepository implements ODPRepository {
  final _controller = StreamController<PaymentMap>.broadcast();
  PaymentMap _payments = PaymentMap();

  @override
  Future<OutgoingDirectPayment?> load(String id) async => watch(id).firstOrNull;

  @override
  Future<void> save(OutgoingDirectPayment payment) async {
    _payments = _payments.add(payment.id, payment);
    _controller.add(_payments);
  }

  @override
  Future<void> clear() async {
    _payments = _payments.clear();
    _controller.add(_payments);
  }

  @override
  Stream<OutgoingDirectPayment> watch(String id) =>
      _controller.stream.map((it) => it[id]!);

  @override
  Stream<IList<OutgoingDirectPayment>> watchTxCreated() =>
      _controller.stream.delay(const Duration(seconds: 2)).map(
            (it) => it.values
                .where((it) => it.status.maybeMap(orElse: F, txCreated: T))
                .toIList(),
          );

  @override
  Stream<IList<OutgoingDirectPayment>> watchTxSent() =>
      _controller.stream.delay(const Duration(seconds: 2)).map(
            (it) => it.values
                .where((it) => it.status.maybeMap(orElse: F, txSent: T))
                .toIList(),
          );
}
