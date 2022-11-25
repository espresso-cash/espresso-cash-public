import 'package:flutter/material.dart';
import 'package:nested/nested.dart';

import '../../core/accounts/module.dart';
import '../../di.dart';
import 'src/bl/repository.dart';

export 'src/bl/repository.dart';
export 'src/bl/repository.dart';
export 'src/favorite_button.dart';
export 'src/favorite_tokens_list.dart';

class FavoriteTokensModule extends SingleChildStatelessWidget {
  const FavoriteTokensModule({Key? key, Widget? child})
      : super(key: key, child: child);

  @override
  Widget buildWithChild(BuildContext context, Widget? child) => LogoutListener(
        onLogout: () => sl<FavoriteTokenRepository>().clear(),
        child: child,
      );
}
