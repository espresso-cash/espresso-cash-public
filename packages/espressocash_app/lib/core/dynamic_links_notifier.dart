import 'dart:async';

import 'package:dfunc/dfunc.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:uni_links/uni_links.dart';

@injectable
class DynamicLinksNotifier extends ChangeNotifier {
  DynamicLinksNotifier(this._firebaseDynamicLinks) {
    _init();
  }

  Uri? _link;
  StreamSubscription<dynamic>? _dynamicLinksSubscription;
  StreamSubscription<dynamic>? _uniLinksSubscription;

  final FirebaseDynamicLinks _firebaseDynamicLinks;

  void processLink(bool Function(Uri link) onLink) {
    final link = _link;
    if (link == null) return;

    if (onLink(link)) {
      _link = null;
    }
  }

  Future<void> _init() async {
    await _processInitialLink();

    _dynamicLinksSubscription = _firebaseDynamicLinks.onLink
        .map((event) => event.link)
        .listen(_notifyLink);

    _uniLinksSubscription = uriLinkStream.listen(_notifyLink);
  }

  void _notifyLink(Uri? link) {
    if (link == null) return;

    _link = link;
    notifyListeners();
  }

  Future<void> _processInitialLink() async {
    final initialLink = await _firebaseDynamicLinks
        .getInitialLink()
        .then((value) => value?.link)
        .ifNull(getInitialUri);

    _notifyLink(initialLink);
  }

  @override
  void dispose() {
    _dynamicLinksSubscription?.cancel();
    _uniLinksSubscription?.cancel();
    super.dispose();
  }
}
