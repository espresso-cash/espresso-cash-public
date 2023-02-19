import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

import '../../core/accounts/module.dart';
import '../../di.dart';
import 'src/bl/islp_repository.dart';
import 'src/widgets/link_listener.dart';

class ISLPModule extends SingleChildStatelessWidget {
  const ISLPModule({Key? key, Widget? child}) : super(key: key, child: child);

  @override
  Widget buildWithChild(BuildContext context, Widget? child) => MultiProvider(
        providers: [
          LogoutListener(
            onLogout: (_) => sl<ISLPRepository>().clear(),
          ),
        ],
        child: ISLPListener(child: child ?? const SizedBox.shrink()),
      );
}
