import 'dart:convert';

import 'package:espressocash_backend/src/auth/create_auth_middleware.dart';
import 'package:shelf/shelf.dart';
import 'package:solana/solana.dart';
import 'package:test/test.dart';

Future<void> main() async {
  final middleware = createAuthMiddleware();
  final handler = middleware((request) => Response.ok('ok'));

  final key = await Ed25519HDKeyPair.fromMnemonic(
    'grow gas other curve update knife point arrange wrestle impulse tower filter',
    account: 0,
    change: 0,
  );
  const body = '';
  final correctSignature =
      await key.sign(utf8.encode(body)).then((value) => value.toBase58());
  final wrongSignature =
      await key.sign(utf8.encode('wrong')).then((value) => value.toBase58());

  group('API call:', () {
    test('no signature - 200', () async {
      final response = await handler(
        Request(
          'POST',
          Uri.parse('http://localhost/api/v1'),
          body: body,
        ),
      );

      expect(response.statusCode, 200);
    });

    test('wrong signature - 403', () async {
      final response = await handler(
        Request(
          'POST',
          Uri.parse('http://localhost/api/v1/'),
          body: body,
          headers: {
            'x-public-key': key.publicKey.toBase58(),
            'x-signature': wrongSignature,
          },
        ),
      );

      expect(response.statusCode, 403);
    });

    test('correct signature - 200', () async {
      final response = await handler(
        Request(
          'POST',
          Uri.parse('http://localhost/api/v1/'),
          body: body,
          headers: {
            'x-public-key': key.publicKey.toBase58(),
            'x-signature': correctSignature,
          },
        ),
      );

      expect(response.statusCode, 200);
    });
  });

  group('Non-API call:', () {
    test('no signature - 200', () async {
      final response = await handler(
        Request(
          'POST',
          Uri.parse('http://localhost/non-api/'),
          body: body,
        ),
      );

      expect(response.statusCode, 200);
    });

    test('wrong signature - 200', () async {
      final response = await handler(
        Request(
          'POST',
          Uri.parse('http://localhost/non-api/'),
          body: body,
          headers: {
            'x-public-key': key.publicKey.toBase58(),
            'x-signature': wrongSignature,
          },
        ),
      );

      expect(response.statusCode, 200);
    });

    test('correct signature - 200', () async {
      final response = await handler(
        Request(
          'POST',
          Uri.parse('http://localhost/non-api/'),
          body: body,
          headers: {
            'x-public-key': key.publicKey.toBase58(),
            'x-signature': wrongSignature,
          },
        ),
      );

      expect(response.statusCode, 200);
    });
  });
}
