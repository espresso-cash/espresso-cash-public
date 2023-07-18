part of 'profile_section.dart';

class VersionSection extends StatefulWidget {
  const VersionSection({super.key});

  @override
  State<VersionSection> createState() => _VersionSectionState();
}

class _VersionSectionState extends State<VersionSection> {
  late final _packageInfo = PackageInfo.fromPlatform();

  Future<void> _copyFID() async {
    final id = await FirebaseInstallations.instance.getId();
    await Clipboard.setData(ClipboardData(text: id));
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(context.l10n.copiedFid(id))),
    );
  }

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
                    child: GestureDetector(
                      onLongPress: _copyFID,
                      child: Text(
                        context.l10n.version(version, buildNumber ?? ''),
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                );
        },
      );
}
