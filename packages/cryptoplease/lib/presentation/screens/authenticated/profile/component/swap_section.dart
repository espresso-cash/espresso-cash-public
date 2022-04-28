part of 'profile_section.dart';

// TODO(rhbrunetto): temp section
class SwapSection extends StatelessWidget {
  const SwapSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ProfileSection(
        title: 'Swap',
        actions: [
          ProfileButton(
            label: 'Swap Tokens',
            onPressed: () =>
                context.router.navigate(const SwapTokenFlowRoute()),
          ),
        ],
      );
}
