import 'dart:async';

import 'package:dfunc/dfunc.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uni_links/uni_links.dart';

typedef LinkCallback = bool Function(Uri);

@injectable
class DynamicLinksNotifier {
  DynamicLinksNotifier(this._firebaseDynamicLinks) {
    _init();
  }

  final FirebaseDynamicLinks _firebaseDynamicLinks;

  final _subject = BehaviorSubject<Uri?>();
  StreamSubscription<dynamic>? _firebaseSubscription;
  StreamSubscription<dynamic>? _uniLinksSubscription;

  StreamSubscription<Uri?> processLink(LinkCallback onLink) =>
      _subject.listen((link) {
        if (link == null) return;
        if (onLink(link)) _subject.add(null);
      });

  Future<void> _init() async {
    final initialLink = await _firebaseDynamicLinks
        .getInitialLink()
        .then((value) => value?.link)
        .ifNull(getInitialUri);

    if (initialLink != null) _subject.add(initialLink);

    _uniLinksSubscription = uriLinkStream.listen(_subject.add);
    _firebaseSubscription =
        _firebaseDynamicLinks.onLink.map((it) => it.link).listen(_subject.add);
  }

  void dispose() {
    _firebaseSubscription?.cancel();
    _uniLinksSubscription?.cancel();
    _subject.close();
  }
}
