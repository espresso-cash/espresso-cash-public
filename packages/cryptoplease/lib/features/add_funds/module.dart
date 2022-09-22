import 'package:cryptoplease/data/moonpay/moonpay_client.dart';
import 'package:cryptoplease/features/add_funds/bl/repository.dart';
import 'package:cryptoplease_api/cryptoplease_api.dart';
import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

class AddFundsModule extends SingleChildStatelessWidget {
  const AddFundsModule({Key? key, Widget? child})
      : super(key: key, child: child);

  @override
  Widget buildWithChild(BuildContext context, Widget? child) => MultiProvider(
        providers: [
          Provider<AddFundsRepository>(
            create: (context) => AddFundsRepository(
              cryptopleaseClient: context.read<CryptopleaseClient>(),
              moonpayClient: context.read<MoonpayClient>(),
            ),
          )
        ],
        child: child,
      );
}
