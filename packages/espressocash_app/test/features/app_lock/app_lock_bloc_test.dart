import 'package:bloc_test/bloc_test.dart';
import 'package:espressocash_app/features/app_lock/src/bl/app_lock_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'app_lock_bloc_test.mocks.dart';

@GenerateNiceMocks([MockSpec<FlutterSecureStorage>()])
void main() {
  group('AppLockBloc', () {
    late MockFlutterSecureStorage mockSecureStorage;

    setUp(() {
      mockSecureStorage = MockFlutterSecureStorage();
    });

    test('initial state is correct', () {
      expect(
        AppLockBloc(secureStorage: mockSecureStorage).state,
        equals(const AppLockState.none()),
      );
    });

    blocTest<AppLockBloc, AppLockState>(
      'AppLockEventEmit emits correct state when there is no pin stored in the secure storage',
      build: () {
        when(mockSecureStorage.read(key: anyNamed('key')))
            .thenAnswer((_) async => null);

        return AppLockBloc(secureStorage: mockSecureStorage);
      },
      act: (bloc) => bloc.add(const AppLockEvent.init()),
      expect: () => const <AppLockState>[
        AppLockState.disabled(),
      ],
    );

    blocTest<AppLockBloc, AppLockState>(
      'AppLockEventEmit emits correct state when there is pin stored in the secure storage',
      build: () {
        when(mockSecureStorage.read(key: anyNamed('key')))
            .thenAnswer((_) async => '1234');

        return AppLockBloc(secureStorage: mockSecureStorage);
      },
      act: (bloc) => bloc.add(const AppLockEvent.init()),
      expect: () => const <AppLockState>[
        AppLockState.enabled(disableFailed: false),
      ],
    );

    blocTest<AppLockBloc, AppLockState>(
      'AppLockEventLogout emits correct state',
      build: () => AppLockBloc(secureStorage: mockSecureStorage),
      act: (bloc) => bloc.add(const AppLockEvent.logout()),
      expect: () => const <AppLockState>[
        AppLockState.disabled(),
      ],
    );

    blocTest<AppLockBloc, AppLockState>(
      'AppLockEventEnable emits correct state',
      build: () => AppLockBloc(secureStorage: mockSecureStorage),
      act: (bloc) => bloc.add(const AppLockEvent.enable('1234')),
      expect: () => const <AppLockState>[
        AppLockState.enabled(disableFailed: false),
      ],
    );

    blocTest<AppLockBloc, AppLockState>(
      'AppLockEventDisable emits correct state when pin is correct',
      seed: () => const AppLockState.enabled(disableFailed: false),
      build: () {
        when(mockSecureStorage.read(key: anyNamed('key')))
            .thenAnswer((_) async => '1234');

        return AppLockBloc(secureStorage: mockSecureStorage);
      },
      act: (bloc) => bloc.add(const AppLockEvent.disable('1234')),
      expect: () => const <AppLockState>[
        AppLockState.disabled(),
      ],
    );

    blocTest<AppLockBloc, AppLockState>(
      'AppLockEventDisable emits correct state when pin is incorrect',
      seed: () => const AppLockState.enabled(disableFailed: false),
      build: () {
        when(mockSecureStorage.read(key: anyNamed('key')))
            .thenAnswer((_) async => '1234');

        return AppLockBloc(secureStorage: mockSecureStorage);
      },
      act: (bloc) => bloc.add(const AppLockEvent.disable('4321')),
      expect: () => const <AppLockState>[
        AppLockState.enabled(disableFailed: true),
      ],
    );

    blocTest<AppLockBloc, AppLockState>(
      'AppLockEventLock emits correct state',
      build: () => AppLockBloc(secureStorage: mockSecureStorage)
        ..emit(
          const AppLockState.enabled(disableFailed: false),
        ),
      act: (bloc) => bloc.add(const AppLockEvent.lock()),
      expect: () => const <AppLockState>[
        AppLockState.locked(isRetrying: false),
      ],
    );

    blocTest<AppLockBloc, AppLockState>(
      'AppLockEventUnlock emits correct state when pin is incorrect',
      seed: () => const AppLockState.locked(isRetrying: false),
      build: () {
        when(mockSecureStorage.read(key: anyNamed('key')))
            .thenAnswer((_) async => '4321');

        return AppLockBloc(secureStorage: mockSecureStorage);
      },
      act: (bloc) => bloc.add(const AppLockEvent.unlock('1234')),
      expect: () => const <AppLockState>[
        AppLockState.locked(isRetrying: true),
      ],
    );

    blocTest<AppLockBloc, AppLockState>(
      'AppLockEventUnlock emits correct state when pin is incorrect',
      seed: () => const AppLockState.locked(isRetrying: false),
      build: () {
        when(mockSecureStorage.read(key: anyNamed('key')))
            .thenAnswer((_) async => '1234');

        return AppLockBloc(secureStorage: mockSecureStorage);
      },
      act: (bloc) => bloc.add(const AppLockEvent.unlock('1234')),
      expect: () => const <AppLockState>[
        AppLockState.enabled(disableFailed: false),
      ],
    );
  });
}
