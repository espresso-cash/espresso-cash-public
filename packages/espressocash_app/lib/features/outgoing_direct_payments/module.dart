import 'package:flutter/material.dart';
import 'package:nested/nested.dart';

import '../../di.dart';
import '../accounts/module.dart';
import 'data/repository.dart';

class ODPModule extends SingleChildStatelessWidget {
  const ODPModule({super.key, super.child});

  @override
  Widget buildWithChild(BuildContext context, Widget? child) => LogoutListener(
        onLogout: (_) => sl<ODPRepository>().clear(),
        child: child ?? const SizedBox.shrink(),
      );
}
