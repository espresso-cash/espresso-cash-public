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
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

import 'bloc_test.mocks.dart';

final sender = MockTxSender();
final client = MockCryptopleaseClient();

@GenerateMocks([TxSender, CryptopleaseClient])
Future<void> main() async {
  final account = LocalWallet(await Ed25519HDKeyPair.random());
  final receiver = await Ed25519HDKeyPair.random();
  final repository = MemoryRepository();
  final txCreatedWatcher = TxCreatedWatcher(repository, sender);
  final txSentWatcher = TxSentWatcher(repository, sender);

  setUp(() {
    reset(sender);
    reset(client);
    repository.clear();

    txCreatedWatcher.call(onBalanceAffected: ignore);
    txSentWatcher.call(onBalanceAffected: ignore);
  });

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

    await createODP(createService());

    await expectLater(repository._payments.length, 1);
    await expectLater(
      repository._payments.values.first,
      isA<OutgoingDirectPayment>()
          .having((it) => it.status, 'status', isA<ODPStatusTxCreated>()),
    );
    await expectLater(
      repository._payments.values.first,
      isA<OutgoingDirectPayment>()
          .having((it) => it.status, 'status', isA<ODPStatusTxSent>()),
    );
    await expectLater(
      repository._payments.values.first,
      isA<OutgoingDirectPayment>()
          .having((it) => it.status, 'status', isA<ODPStatusSuccess>()),
    );

    verify(sender.send(any, minContextSlot: anyNamed('minContextSlot')))
        .called(1);
    verify(sender.wait(any, minContextSlot: anyNamed('minContextSlot')))
        .called(1);
  });
/*
  blocTest<ODPBloc, ODPState>(
    'happy path',
    setUp: () async {},
    build: createBloc,
    act: (b) async {
      b.add(
        ODPEvent.create(
          id: const Uuid().v4(),
          receiver: receiver.publicKey,
          reference: null,
          amount: testAmount,
        ),
      );
    },
    verify: (b) async {
      verify(sender.send(any, minContextSlot: anyNamed('minContextSlot')))
          .called(1);
      verify(sender.wait(any, minContextSlot: anyNamed('minContextSlot')))
          .called(1);

      expect(repository._payments.length, 1);
      expect(
        repository._payments.values.first,
        isA<OutgoingDirectPayment>()
            .having((it) => it.status, 'status', isA<ODPStatusSuccess>()),
      );
    },
  );

  blocTest<ODPBloc, ODPState>(
    'failed to get tx from API',
    setUp: () async {
      when(client.createDirectPayment(any))
          .thenAnswer((_) async => throw Exception());
    },
    build: createBloc,
    act: (b) async {
      b.add(
        ODPEvent.create(
          id: const Uuid().v4(),
          receiver: receiver.publicKey,
          reference: null,
          amount: testAmount,
        ),
      );
    },
    verify: (b) async {
      verifyNever(sender.send(any, minContextSlot: anyNamed('minContextSlot')));
      verifyNever(sender.wait(any, minContextSlot: anyNamed('minContextSlot')));

      expect(repository._payments.length, 1);
      expect(
        repository._payments.values.first,
        isA<OutgoingDirectPayment>()
            .having((it) => it.status, 'status', const ODPStatus.txFailure()),
      );
    },
  );
  */
}

class MemoryRepository implements ODPRepository {
  final Map<String, OutgoingDirectPayment> _payments = {};

  @override
  Future<OutgoingDirectPayment?> load(String id) async => _payments[id];

  @override
  Future<void> save(OutgoingDirectPayment payment) async {
    _payments[payment.id] = payment;
  }

  @override
  Future<void> clear() async => _payments.clear();

  @override
  Stream<OutgoingDirectPayment> watch(String id) {
    throw UnimplementedError();
  }

  @override
  Stream<IList<OutgoingDirectPayment>> watchTxCreated() => Stream.value(
        _payments.values
            .where((it) => it.status.maybeMap(orElse: F, txCreated: T))
            .toIList(),
      );

  @override
  Stream<IList<OutgoingDirectPayment>> watchTxSent() => Stream.value(
        _payments.values
            .where((it) => it.status.maybeMap(orElse: F, txSent: T))
            .toIList(),
      );
}

// Future<void> retryODP({required OutgoingDirectPayment payment}) async =>
//     runWithLoader(this, () async {
//       await sl<ODPService>().retry(
//         payment,
//         account: read<MyAccount>().wallet,
//       );
//       sl<AnalyticsManager>().directPaymentCreated();
//     });
