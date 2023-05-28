import 'dart:convert';

import 'package:espressocash_api/espressocash_api.dart';
import 'package:shelf/shelf.dart';

Future<Response> processRequest<T, R>(
  Request request,
  T Function(Map<String, dynamic> data) parse,
  Future<R> Function(T data) handler,
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
  } on EspressoCashException catch (e) {
    return Response.badRequest(
      body: json.encode(e.toJson()),
      headers: {
        'content-type': 'application/json',
      },
    );
  } on Exception {
    return Response.internalServerError();
  }
}
