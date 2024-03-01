import 'package:flutter/widgets.dart';

import '../../../di.dart';
import '../models/account.dart';
import '../services/account_service.dart';

mixin AccountListener<T extends StatefulWidget> on State<T> {
  void handleAccountChanged(MyAccount? account);

  @override
  void initState() {
    super.initState();
    sl<AccountService>().addListener(_handleAccountChanged);
  }

  @override
  void dispose() {
    sl<AccountService>().removeListener(_handleAccountChanged);
    super.dispose();
  }

  void _handleAccountChanged() {
    handleAccountChanged(sl<AccountService>().value);
  }
}
