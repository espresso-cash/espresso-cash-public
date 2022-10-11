part of 'profile_section.dart';

class DebugSection extends StatelessWidget {
  const DebugSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ProfileSection(
        title: context.l10n.debugSectionTitle,
        actions: const [
          AirdropButton(),
        ],
      );
}
