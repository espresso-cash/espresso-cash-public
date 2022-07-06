import 'package:cryptoplease/features/pending_request/bl/pending_request_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';

class PendingRequestModule extends SingleChildStatelessWidget {
  const PendingRequestModule({Key? key, Widget? child})
      : super(key: key, child: child);

  @override
  Widget buildWithChild(BuildContext context, Widget? child) => BlocProvider(
        create: (_) => PendingRequestBloc(),
        child: child,
      );
}
