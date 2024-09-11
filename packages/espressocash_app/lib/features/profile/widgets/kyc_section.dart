part of 'profile_section.dart';

class KycSection extends StatelessWidget {
  const KycSection({super.key});

  @override
  Widget build(BuildContext context) => ProfileSection(
        title: 'Verification',
        padding: const EdgeInsets.fromLTRB(8, 16, 2, 16),
        actions: [
          ProfileButton(
            label: 'KYC',
            onPressed: () => KycFlow.open(context),
          ),
        ],
      );
}
