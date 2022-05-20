import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:cryptoplease_link/src/apps.dart';
import 'package:cryptoplease_link/src/associations.dart';
import 'package:shelf/shelf.dart';

Future<Response> assetLinksHandler(Request _) async {
  final assetLinks =
      getAssetLinks(apps.map((a) => a.androidOptions).whereNotNull());

  return Response.ok(
    jsonEncode(assetLinks),
    headers: _contentTypeJson,
  );
}

Future<Response> appAssociationsHandler(Request _) async {
  final appAssociations =
      getAppAssociations(apps.map((a) => a.iOSOptions).whereNotNull());

  return Response.ok(
    jsonEncode(appAssociations),
    headers: _contentTypeJson,
  );
}

const _contentTypeJson = {'Content-Type': 'application/json'};
