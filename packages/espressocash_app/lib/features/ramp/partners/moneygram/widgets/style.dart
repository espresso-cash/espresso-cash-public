import 'package:flutter/services.dart';

import '../../../../../gen/assets.gen.dart';

Future<String> loadMoneygramStyle() async {
  final css = await rootBundle.loadString(Assets.moneygram.style);

  return """
  (function() {
    var style = document.createElement('style');
    style.type = 'text/css';
    style.innerHTML = `$css`;
    document.head.appendChild(style);
  })();
""";
}
