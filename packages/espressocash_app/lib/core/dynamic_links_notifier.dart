import 'dart:async';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:uni_links/uni_links.dart';

@injectable
class DynamicLinksNotifier extends ChangeNotifier {
  DynamicLinksNotifier() {
    _init();
  }

  Uri? _link;
  StreamSubscription<dynamic>? _subscription;

  Uri? get link => _link;

  void processLink(bool Function(Uri link) onLink) {
    final link = _link;
    if (link == null) return;

    if (onLink(link)) {
      _link = null;
    }
  }

  Future<void> _init() async {
    final initialLink = await getInitialUri();

    if (initialLink != null) {
      _link = initialLink;
      notifyListeners();
    }

    uriLinkStream.listen(_processLink);
  }

  void _processLink(Uri? link) {
    if (link == null) return;

    _link = link;
    notifyListeners();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
