import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:solana/base58.dart';
import 'package:solana/solana.dart';

Middleware createAuthMiddleware() => (innerHandler) => (request) async {
      final body = await request.readAsString();

      final signature = request.headers['x-signature'];
      final publicKey = request.headers['x-public-key'];

      if (request.requestedUri.path.startsWith('/api/') &&
          signature != null &&
          publicKey != null) {
        bool isValid;
        try {
          isValid = await verifySignature(
            message: utf8.encode(body),
            signature: base58decode(signature),
            publicKey: Ed25519HDPublicKey.fromBase58(publicKey),
          );
        } on Object {
          isValid = false;
        }

        if (!isValid) {
          return Response.forbidden('Invalid signature');
        }
      }

      return innerHandler(request.change(body: body));
    };
