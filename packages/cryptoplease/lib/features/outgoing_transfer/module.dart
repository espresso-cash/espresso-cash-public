import 'package:cryptoplease/data/db/db.dart';
import 'package:cryptoplease/features/outgoing_transfer/bl/repository.dart';
import 'package:cryptoplease/features/outgoing_transfer/data/outgoing_transfer_repository.dart';
import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

class OutgoingTransferModule extends SingleChildStatelessWidget {
  const OutgoingTransferModule({Key? key, Widget? child})
      : super(key: key, child: child);

  @override
  Widget buildWithChild(BuildContext context, Widget? child) => MultiProvider(
        providers: [
          Provider<OutgoingTransferRepository>(
            create: (_) => DbOutgoingTransferRepository(
              context.read<MyDatabase>(),
            ),
          ),
        ],
        child: child,
      );
}
