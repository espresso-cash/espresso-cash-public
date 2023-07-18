import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:solana_mobile_wallet/solana_mobile_wallet.dart';
import 'package:solana_mobile_wallet/src/api.dart';

import 'scenario_test.mocks.dart';

@GenerateMocks([ScenarioCallbacks, Scenario])
Future<void> main() async {
  late MockScenarioCallbacks callbacks;
  late Uint8List publicKey;

  setUp(() {
    Api.instance = Api();
    callbacks = MockScenarioCallbacks();
    publicKey = Uint8List.fromList(
      List.generate(32, (_) => Random().nextInt(64)),
    );
  });

  int createAndRegisterScenario() {
    final scenario = ScenarioTest(
      associationPublicKey: Uint8List(32),
      callbacks: callbacks,
      id: Random().nextInt(10),
    );
    Api.instance.register(scenario);

    return scenario.id;
  }

  test('Authorize', () async {
    final id = createAndRegisterScenario();

    final requestDto = AuthorizeRequestDto(
      identityName: '',
      identityUri: '',
      iconUri: '',
    );

    when(
      callbacks.onAuthorizeRequest(any),
    ).thenAnswer(
      (_) async => AuthorizeResult(publicKey: publicKey),
    );

    final result = await Api.instance.authorize(requestDto, id);

    expect(result, isA<AuthorizeResultDto>());
    verify(callbacks.onAuthorizeRequest(any)).called(1);
    verifyNoMoreInteractions(callbacks);
  });

  test('Reauthorize', () async {
    final id = createAndRegisterScenario();

    final requestDto = ReauthorizeRequestDto(
      cluster: 'testnet',
      authorizationScope: Uint8List(32),
    );

    when(callbacks.onReauthorizeRequest(any)).thenAnswer((_) async => true);

    final result = await Api.instance.reauthorize(requestDto, id);

    expect(result, true);
    verify(callbacks.onReauthorizeRequest(any)).called(1);
    verifyNoMoreInteractions(callbacks);
  });

  test('Sign transactions', () async {
    final id = createAndRegisterScenario();
    final payloads = List.generate(2, (_) => Uint8List(32));
    final requestDto = SignTransactionsRequestDto(
      payloads: payloads,
      authorizationScope: Uint8List(32),
      cluster: 'testnet',
    );

    when(
      callbacks.onSignTransactionsRequest(any),
    ).thenAnswer(
      (_) async => SignedPayloadResult(signedPayloads: payloads),
    );

    final result = await Api.instance.signTransactions(requestDto, id);

    expect(result, isA<SignedPayloadsResultDto>());
    verify(callbacks.onSignTransactionsRequest(any)).called(1);
    verifyNoMoreInteractions(callbacks);
  });

  test('Sign messages', () async {
    final id = createAndRegisterScenario();
    final payloads = List.generate(2, (_) => Uint8List(32));
    final requestDto = SignMessagesRequestDto(
      payloads: payloads,
      authorizationScope: Uint8List(32),
      cluster: 'testnet',
    );

    when(
      callbacks.onSignMessagesRequest(any),
    ).thenAnswer(
      (_) async => SignedPayloadResult(signedPayloads: payloads),
    );

    final result = await Api.instance.signMessages(requestDto, id);

    expect(result, isA<SignedPayloadsResultDto>());
    verify(callbacks.onSignMessagesRequest(any)).called(1);
    verifyNoMoreInteractions(callbacks);
  });

  test('Sign and send transactions', () async {
    final id = createAndRegisterScenario();
    final payloads = List.generate(2, (_) => Uint8List(32));
    final requestDto = SignAndSendTransactionsRequestDto(
      publicKey: publicKey,
      transactions: payloads,
      authorizationScope: Uint8List(32),
      cluster: 'testnet',
    );

    when(
      callbacks.onSignAndSendTransactionsRequest(any),
    ).thenAnswer(
      (_) async => SignaturesResult(signatures: [Uint8List(64)]),
    );

    final result = await Api.instance.signAndSendTransactions(requestDto, id);

    expect(result, isA<SignaturesResultDto>());
    verify(callbacks.onSignAndSendTransactionsRequest(any)).called(1);
    verifyNoMoreInteractions(callbacks);
  });

  test('Scenario ready', () async {
    final id = createAndRegisterScenario();

    when(callbacks.onScenarioReady(any)).thenAnswer((_) {});

    Api.instance.onScenarioReady(id);

    verify(callbacks.onScenarioReady(any)).called(1);
    verifyNoMoreInteractions(callbacks);
  });

  test('Scenario complete', () async {
    final id = createAndRegisterScenario();

    when(callbacks.onScenarioComplete()).thenAnswer((_) {});

    Api.instance.onScenarioComplete(id);

    verify(callbacks.onScenarioComplete()).called(1);
    verifyNoMoreInteractions(callbacks);
  });

  test('Scenario error', () async {
    final id = createAndRegisterScenario();

    when(callbacks.onScenarioError()).thenAnswer((_) {});

    Api.instance.onScenarioError(id);

    verify(callbacks.onScenarioError()).called(1);
    verifyNoMoreInteractions(callbacks);
  });

  test('Scenario serving clients', () async {
    final id = createAndRegisterScenario();

    when(callbacks.onScenarioServingClients()).thenAnswer((_) {});

    Api.instance.onScenarioServingClients(id);

    verify(callbacks.onScenarioServingClients()).called(1);
    verifyNoMoreInteractions(callbacks);
  });

  test('Scenario serving complete', () async {
    final id = createAndRegisterScenario();

    when(callbacks.onScenarioServingComplete()).thenAnswer((_) {});

    Api.instance.onScenarioServingComplete(id);

    verify(callbacks.onScenarioServingComplete()).called(1);
    verifyNoMoreInteractions(callbacks);
  });

  test('Scenario teardown complete', () async {
    final id = createAndRegisterScenario();

    when(callbacks.onScenarioTeardownComplete()).thenAnswer((_) {});

    Api.instance.onScenarioTeardownComplete(id);

    verify(callbacks.onScenarioTeardownComplete()).called(1);
    verifyNoMoreInteractions(callbacks);
  });

  test('On low power and no connection', () async {
    final id = createAndRegisterScenario();

    when(callbacks.onLowPowerAndNoConnection()).thenAnswer((_) {});

    Api.instance.onLowPowerAndNoConnection(id);

    verify(callbacks.onLowPowerAndNoConnection()).called(1);
    verifyNoMoreInteractions(callbacks);
  });

  test('Deauthorize', () async {
    final id = createAndRegisterScenario();

    final deauthorizeDto = DeauthorizeEventDto(
      identityName: '',
      identityUri: '',
      iconRelativeUri: '',
      cluster: 'testnet',
      authorizationScope: Uint8List(32),
    );

    when(callbacks.onDeauthorizeEvent(any)).thenAnswer((_) async => true);

    await Api.instance.deauthorize(deauthorizeDto, id);

    verify(callbacks.onDeauthorizeEvent(any)).called(1);
    verifyNoMoreInteractions(callbacks);
  });
}

class ScenarioTest implements Scenario {
  const ScenarioTest({
    required this.associationPublicKey,
    required this.callbacks,
    required this.id,
  });

  @override
  final Uint8List associationPublicKey;

  @override
  final ScenarioCallbacks callbacks;

  @override
  final int id;

  @override
  void close() {}

  @override
  void start() {}
}
