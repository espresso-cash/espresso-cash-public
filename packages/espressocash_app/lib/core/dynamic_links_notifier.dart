import 'dart:async';

import 'package:dfunc/dfunc.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uni_links/uni_links.dart';

import 'callback.dart';

@injectable
class DynamicLinksNotifier {
  DynamicLinksNotifier(this._firebaseDynamicLinks) {
    _init();
  }

  final _subject = BehaviorSubject<Uri>();

  final FirebaseDynamicLinks _firebaseDynamicLinks;

  StreamSubscription<Uri> processLink(Callback1<Uri> onLink) =>
      _subject.listen(onLink);

  Future<void> _init() async {
    final initialLink = await _firebaseDynamicLinks
        .getInitialLink()
        .then((value) => value?.link)
        .ifNull(getInitialUri);

    if (initialLink != null) _subject.add(initialLink);

    await _subject.addStream(
      _firebaseDynamicLinks.onLink.map((event) => event.link),
    );
    await _subject.addStream(uriLinkStream.whereNotNull());
  }

  void dispose() {
    _subject.close();
  }
}
