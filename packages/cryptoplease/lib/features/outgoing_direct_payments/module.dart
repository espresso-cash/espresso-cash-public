import 'package:cryptoplease/core/tokens/token_list.dart';
import 'package:cryptoplease/data/db/db.dart';
import 'package:cryptoplease/features/outgoing_direct_payments/bl/repository.dart';
import 'package:cryptoplease/features/outgoing_direct_payments/data/repository.dart';
import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

class ODPModule extends SingleChildStatelessWidget {
  const ODPModule({Key? key, Widget? child}) : super(key: key, child: child);

  @override
  Widget buildWithChild(BuildContext context, Widget? child) => MultiProvider(
        providers: [
          Provider<ODPRepository>(
            create: (context) => DbODPRepository(
              context.read<MyDatabase>(),
              context.read<TokenList>(),
            ),
          ),
        ],
        child: child,
      );
}
