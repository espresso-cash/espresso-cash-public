import 'dart:async';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:uni_links/uni_links.dart';

class DynamicLinksNotifier extends ChangeNotifier {
  DynamicLinksNotifier(this._firebaseDynamicLinks) {
    _init();
  }

  Uri? _link;
  StreamSubscription<dynamic>? _subscription;

  final FirebaseDynamicLinks _firebaseDynamicLinks;

  void processLink(bool Function(Uri link) onLink) {
    final link = _link;
    if (link == null) return;

    if (onLink(link)) {
      _link = null;
    }
  }

  Future<void> _init() async {
    final initialLink = await _firebaseDynamicLinks
        .getInitialLink()
        .then((value) => value?.link);
    if (initialLink != null) {
      _link = initialLink;
      notifyListeners();
    }

    _subscription = _firebaseDynamicLinks.onLink
        .map((event) => event.link)
        .listen(_processLink);

    final initialUri = await getInitialUri();
    _processLink(initialUri);
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
