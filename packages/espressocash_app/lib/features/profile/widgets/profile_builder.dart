import 'package:flutter/widgets.dart';

import '../../../core/extensions.dart';
import '../../../core/presentation/value_stream_builder.dart';
import '../../../di.dart';
import '../data/profile_repository.dart';
import '../models/profile.dart';

typedef ProfileWidgetBuilder = Widget Function(
  BuildContext context,
  Profile snapshot,
);

class ProfileBuilder extends StatelessWidget {
  const ProfileBuilder({super.key, required this.builder});

  final ProfileWidgetBuilder builder;

  @override
  Widget build(BuildContext context) => ValueStreamBuilder(
        create: () => sl<ProfileRepository>().profileStream.withInitial(),
        builder: builder,
      );
}
