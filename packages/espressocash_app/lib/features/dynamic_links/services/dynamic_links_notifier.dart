import 'dart:async';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:uni_links/uni_links.dart';

import '../../../config.dart';
import '../data/dynamic_links_client.dart';

@singleton
class DynamicLinksNotifier extends ChangeNotifier {
  DynamicLinksNotifier(this._client);

  final DynamicLinkClient _client;

  Uri? _link;
  StreamSubscription<dynamic>? _subscription;

  Uri? get link => _link;

  bool get loading => _loading;
  bool _loading = false;

  void processLink(Func1<Uri, bool> onLink) {
    final link = _link;
    if (link == null) return;

    if (onLink(link)) {
      _link = null;
    }
  }

  @PostConstruct(preResolve: true)
  Future<void> init() async {
    final initialLink = await getInitialUri();

    if (initialLink != null) {
      await _processLink(initialLink);
    }

    _subscription = uriLinkStream.listen(_processLink);
  }

  Future<void> _processLink(Uri? link) async {
    if (link == null) return;

    if (!link.isShortened) {
      _link = link;
      notifyListeners();

      return;
    }

    _loading = true;
    notifyListeners();

    try {
      final fullLink = await _client.unshortenLink(link);
      final hash = _calculateHash(fullLink);

      if (fullLink.isValidHash(hash)) {
        _link = fullLink;
      }
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}

extension on Uri {
  bool get isShortened =>
      host == espressoCashLinkDomain && queryParameters.containsKey('s');

  bool isValidHash(String hash) => _calculateHash(this) == hash;
}

String _calculateHash(Uri url) =>
    // ignore: avoid-weak-cryptographic-algorithms, not crypto
    md5.convert(utf8.encode(url.toString())).toString();
