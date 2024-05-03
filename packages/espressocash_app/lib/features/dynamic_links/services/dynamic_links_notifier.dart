import 'dart:async';

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

    if (link.isShortenedLink) {
      try {
        _loading = true;
        notifyListeners();

        link = await _client.unshortenLink(link);
      } on Exception {
        return;
      } finally {
        _loading = false;
      }
    }

    _link = link;
    notifyListeners();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}

extension on Uri {
  bool get isShortenedLink =>
      host == espressoCashLinkDomain && queryParameters.containsKey('s');
}
