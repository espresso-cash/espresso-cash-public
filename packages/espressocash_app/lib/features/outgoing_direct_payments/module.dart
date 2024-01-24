import 'package:flutter/material.dart';
import 'package:nested/nested.dart';

import '../../di.dart';
import '../accounts/module.dart';
import 'data/repository.dart';
import 'widgets/link_listener.dart';

class ODPModule extends SingleChildStatelessWidget {
  const ODPModule({super.key, super.child});

  @override
  Widget buildWithChild(BuildContext context, Widget? child) => LogoutListener(
        onLogout: (_) => sl<ODPRepository>().clear(),
        child: ODPLinkListener(child: child ?? const SizedBox.shrink()),
      );
}
