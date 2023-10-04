import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:espressocash_backend/src/apps.dart';
import 'package:espressocash_backend/src/associations.dart';
import 'package:shelf/shelf.dart';

Response assetLinksHandler(Request _) {
  final assetLinks =
      getAssetLinks(apps.map((a) => a.androidOptions).whereNotNull());

  return Response.ok(
    jsonEncode(assetLinks),
    headers: _contentTypeJson,
  );
}

Response appAssociationsHandler(Request _) {
  final appAssociations =
      getAppAssociations(apps.map((a) => a.iOSOptions).whereNotNull());

  return Response.ok(
    jsonEncode(appAssociations),
    headers: _contentTypeJson,
  );
}

const _contentTypeJson = {'Content-Type': 'application/json'};
