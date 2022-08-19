import 'dart:convert';

import 'package:shelf/shelf.dart';

Future<Response> processRequest<T, R>(
  Request request,
  T Function(Map<String, dynamic>) parse,
  Future<R> Function(T data) handler,
) async {
  final body = await request.readAsString();

  final T dto;
  try {
    final data = json.decode(body) as Map<String, dynamic>;
    dto = parse(data);
  } on Object {
    return Response.badRequest(body: 'Invalid JSON');
  }

  return Response.ok(
    json.encode(await handler(dto)),
    headers: {
      'content-type': 'application/json',
    },
  );
}
