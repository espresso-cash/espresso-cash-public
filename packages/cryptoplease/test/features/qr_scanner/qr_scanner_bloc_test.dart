import 'package:bloc_test/bloc_test.dart';
import 'package:cryptoplease/core/link_shortener.dart';
import 'package:cryptoplease/features/qr_scanner/src/qr_address_data.dart';
import 'package:cryptoplease/features/qr_scanner/src/qr_scanner_bloc.dart';
import 'package:cryptoplease/features/qr_scanner/src/qr_scanner_request.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:solana/solana.dart';

import 'qr_scanner_bloc_test.mocks.dart';

@GenerateMocks([LinkShortener])
void main() {
  final linkShortener = MockLinkShortener();
  late final String sampleAddress;

  setUpAll(() async {
    sampleAddress = (await Ed25519HDKeyPair.random()).address;
  });

  group('QrScannerBloc tests:', () {
    blocTest<QrScannerBloc, QrScannerState>(
      'bloc can be correctly initialized',
      build: () => QrScannerBloc(linkShortener: linkShortener),
      act: (bloc) => bloc.add(const QrScannerEvent.initialized()),
      expect: () => [const QrScannerState.initial()],
    );

    blocTest<QrScannerBloc, QrScannerState>(
      'solana pay QR code leads to done state',
      build: () => QrScannerBloc(linkShortener: linkShortener),
      act: (bloc) => bloc.add(
        QrScannerEvent.received(
          _buildSolanaPayURI(recipientAddress: sampleAddress),
        ),
      ),
      expect: () => [isA<QrScannerDoneState>()],
    );

    blocTest<QrScannerBloc, QrScannerState>(
      'simple address qr scanned',
      build: () => QrScannerBloc(linkShortener: linkShortener),
      act: (bloc) => bloc.add(QrScannerEvent.received(sampleAddress)),
      expect: () => [
        QrScannerState.done(
          QrScannerRequest.address(
            QrAddressData(
              address: Ed25519HDPublicKey.fromBase58(sampleAddress),
              name: null,
            ),
          ),
        ),
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
