import 'package:flutter/widgets.dart';

import '../../../di.dart';
import '../services/dynamic_links_notifier.dart';

mixin DynamicLinkHandler<T extends StatefulWidget> on State<T> {
  bool handleDynamicLink(Uri uri);

  @override
  void initState() {
    super.initState();
    sl<DynamicLinksNotifier>().addListener(_handle);
  }

  @override
  void dispose() {
    sl<DynamicLinksNotifier>().removeListener(_handle);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) => _handle());
  }

  void _handle() {
    sl<DynamicLinksNotifier>().processLink(handleDynamicLink);
  }
}
