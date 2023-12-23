import 'dart:convert';

import 'package:dfunc/dfunc.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:sentry/sentry.dart';
import 'package:shelf/shelf.dart';

Future<Response> processRequest<T, R>(
  Request request,
  Transformer<Map<String, dynamic>, T> parse,
  Transformer<T, Future<R>> handler,
) async {
  final body = await request.readAsString();

  final T dto;
  try {
    final Map<String, dynamic> data =
        body.isEmpty ? {} : json.decode(body) as Map<String, dynamic>;
    dto = parse(data);
  } on Object {
    return Response.badRequest(body: 'Invalid JSON');
  }

  try {
    return Response.ok(
      json.encode(await handler(dto)),
      headers: {
        'content-type': 'application/json',
      },
    );
  } on EspressoCashException catch (error) {
    return Response.badRequest(
      body: json.encode(error.toJson()),
      headers: {
        'content-type': 'application/json',
      },
    );
  } on Exception catch (error, stacktrace) {
    await Sentry.captureException(error, stackTrace: stacktrace);

    return Response.internalServerError();
  }
}
