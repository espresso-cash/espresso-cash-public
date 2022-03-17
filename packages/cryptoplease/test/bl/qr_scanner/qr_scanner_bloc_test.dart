import 'package:bloc_test/bloc_test.dart';
import 'package:cryptoplease/bl/qr_scanner/qr_scanner_bloc.dart';
import 'package:cryptoplease/bl/qr_scanner/qr_scanner_request.dart';
import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:cryptoplease/bl/tokens/token_list.dart';
import 'package:decimal/decimal.dart';
import 'package:solana/solana.dart';
import 'package:test/test.dart';

void main() {
  late final TokenList tokenList;
  late final Token sampleToken;
  late final String sampleAddress;

  setUpAll(() async {
    sampleAddress = (await Ed25519HDKeyPair.random()).address;
    tokenList = TokenList();
    sampleToken = tokenList
        .findTokenByMint('9fvEiugrurd2kzSkqFjhGaUFiZUfP4UWbfprmFEm51M9')!;
  });

  group('QrScannerBloc tests:', () {
    blocTest<QrScannerBloc, QrScannerState>(
      'bloc can be correctly initialized',
      build: () => QrScannerBloc(tokenList),
      act: (bloc) => bloc.add(const QrScannerEvent.initialized()),
      expect: () => [const QrScannerState.initial()],
    );

    blocTest<QrScannerBloc, QrScannerState>(
      'unknown URI scheme emits an error state',
      build: () => QrScannerBloc(tokenList),
      act: (bloc) =>
          bloc.add(const QrScannerEvent.received('not-solana:irrelevant')),
      expect: () => [
        const QrScannerState.error(QrScannerError.unsupportedURIScheme),
      ],
    );

    blocTest<QrScannerBloc, QrScannerState>(
      'bad token emits an error state',
      build: () => QrScannerBloc(tokenList),
      act: (bloc) => bloc.add(
        QrScannerEvent.received(
          _buildSolanaPayURI(
            recipientAddress: sampleAddress,
            splToken: 'INVALID_SPL_TOKEN',
          ),
        ),
      ),
      expect: () => [
        const QrScannerState.error(QrScannerError.tokenNotFound),
      ],
    );

    blocTest<QrScannerBloc, QrScannerState>(
      'missing spl token sets Token.sol',
      build: () => QrScannerBloc(tokenList),
      act: (bloc) => bloc.add(
        QrScannerEvent.received(
          _buildSolanaPayURI(recipientAddress: sampleAddress),
        ),
      ),
      expect: () => [
        QrScannerState.done(
          QrScannerRequest.solanaPay(
            recipient: sampleAddress,
            token: Token.sol,
          ),
        ),
      ],
    );

    blocTest<QrScannerBloc, QrScannerState>(
      'valid SPL token is picked correctly',
      build: () => QrScannerBloc(tokenList),
      act: (bloc) => bloc.add(
        QrScannerEvent.received(
          _buildSolanaPayURI(
            recipientAddress: sampleAddress,
            splToken: sampleToken.address,
          ),
        ),
      ),
      expect: () => [
        QrScannerState.done(
          QrScannerRequest.solanaPay(
            recipient: sampleAddress,
            token: sampleToken,
          ),
        ),
      ],
    );

    blocTest<QrScannerBloc, QrScannerState>(
      'solana pay request with amount and no reference',
      build: () => QrScannerBloc(tokenList),
      act: (bloc) => bloc.add(
        QrScannerEvent.received(
          _buildSolanaPayURI(
            recipientAddress: sampleAddress,
            splToken: sampleToken.address,
            amount: 0.5,
          ),
        ),
      ),
      expect: () => [
        QrScannerState.done(
          QrScannerRequest.solanaPay(
            recipient: sampleAddress,
            token: sampleToken,
            amount: Decimal.parse('0.5'),
          ),
        ),
      ],
    );

    blocTest<QrScannerBloc, QrScannerState>(
      'solana pay request with amount and reference',
      build: () => QrScannerBloc(tokenList),
      act: (bloc) => bloc.add(
        const QrScannerEvent.received(
          'solana:6QUGVzqad3z5k1i87L9w14YQQAMkxRgL648ifLdstHV2'
          '?amount=2'
          '&label=order%201'
          '&message=testTransaction'
          '&memo=Memo'
          '&reference=ded50ed6deb61e267a894f78a1b940d50e216661643d6741568fe42cc20f570d',
        ),
      ),
      expect: () => [
        QrScannerState.done(
          QrScannerRequest.solanaPay(
            recipient: '6QUGVzqad3z5k1i87L9w14YQQAMkxRgL648ifLdstHV2',
            token: Token.sol,
            amount: Decimal.fromInt(2),
            reference:
                'ded50ed6deb61e267a894f78a1b940d50e216661643d6741568fe42cc20f570d',
          ),
        ),
      ],
    );

    blocTest<QrScannerBloc, QrScannerState>(
      'amount with wrong number of decimals is rejected',
      build: () => QrScannerBloc(tokenList),
      act: (bloc) => bloc.add(
        const QrScannerEvent.received(
          'solana:6QUGVzqad3z5k1i87L9w14YQQAMkxRgL648ifLdstHV2'
          '?amount=0.1234567891',
        ),
      ),
      expect: () => [
        const QrScannerState.error(QrScannerError.solanaPayQueryFailedToParse),
      ],
    );

    blocTest<QrScannerBloc, QrScannerState>(
      'simple address qr scanned',
      build: () => QrScannerBloc(tokenList),
      act: (bloc) => bloc.add(QrScannerEvent.received(sampleAddress)),
      expect: () => [
        QrScannerState.done(QrScannerRequest.address(sampleAddress)),
      ],
    );
  });
}

String _buildSolanaPayURI({
  required String recipientAddress,
  String? splToken,
  String? reference,
  double? amount,
}) {
  final Iterable<String> values = <String, String?>{
    'spl-token': splToken,
    'reference': reference,
    'amount': amount?.toString(),
  }
      .entries
      .where((entry) => entry.value != null)
      .map((entry) => '${entry.key}=${entry.value}');

  return 'solana:$recipientAddress?${values.join('&')}';
}
