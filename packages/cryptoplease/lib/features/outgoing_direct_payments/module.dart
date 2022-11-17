import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

import '../../core/accounts/bl/account.dart';
import '../../di.dart';
import 'src/bl/bloc.dart';
import 'src/presentation/link_listener.dart';

export 'src/bl/odp_request.dart';
export 'src/bl/odp_request_repository.dart';
export 'src/bl/outgoing_direct_payment.dart';
export 'src/bl/repository.dart';
export 'src/presentation/build_context_ext.dart';
export 'src/presentation/odp_request_flow.dart';

class ODPModule extends SingleChildStatelessWidget {
  const ODPModule({Key? key, Widget? child}) : super(key: key, child: child);

  @override
  Widget buildWithChild(BuildContext context, Widget? child) => MultiProvider(
        providers: [
          BlocProvider<ODPBloc>(
            create: (context) => sl<ODPBloc>(
              param1: context.read<MyAccount>().wallet,
            ),
          ),
        ],
        child: ODPLinkListener(child: child ?? const SizedBox.shrink()),
      );
}
