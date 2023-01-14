import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

class COPModule extends SingleChildStatelessWidget {
  const COPModule({Key? key, Widget? child}) : super(key: key, child: child);

  @override
  Widget buildWithChild(BuildContext context, Widget? child) => MultiProvider(
        providers: const [
          // Provider(create: (context) => sl<CancelTxSender>()),
        ],
      );
}
