part of 'profile_section.dart';

class VersionSection extends StatefulWidget {
  const VersionSection({Key? key}) : super(key: key);

  @override
  State<VersionSection> createState() => _VersionSectionState();
}

class _VersionSectionState extends State<VersionSection> {
  late final _packageInfo = PackageInfo.fromPlatform();

  @override
  Widget build(BuildContext context) => FutureBuilder<PackageInfo>(
        future: _packageInfo,
        builder: (context, snapshot) {
          final version = snapshot.data?.version;
          if (version != null) {
            return SizedBox(
              height: kToolbarHeight,
              child: Center(
                child: Text(
                  'Version $version',
                  style: Theme.of(context).textTheme.headline4?.copyWith(
                        fontSize: 15,
                      ),
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      );
}
