part of 'profile_section.dart';

class KycSection extends StatelessWidget {
  const KycSection({super.key});

  @override
  Widget build(BuildContext context) => ProfileSection(
        title: 'Verification',
        padding: const EdgeInsets.fromLTRB(8, 16, 2, 16),
        actions: [
          ProfileButton(
            label: 'Email',
            onPressed: () => EmailVerificationScreen.push(context),
          ),
          const ProfileButton(
            label: 'Phone',
            onPressed: null,
          ),
          const ProfileButton(
            label: 'KYC',
            onPressed: null,
          ),
        ],
      );
}
