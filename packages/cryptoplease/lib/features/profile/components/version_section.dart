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
          final buildNumber = snapshot.data?.buildNumber;

          return version == null
              ? const SizedBox.shrink()
              : SizedBox(
                  height: kToolbarHeight,
                  child: Center(
                    child: Text(
                      'Version $version ($buildNumber)',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
        },
      );
}
