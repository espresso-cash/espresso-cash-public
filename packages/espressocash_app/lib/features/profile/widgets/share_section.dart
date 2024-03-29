part of 'profile_section.dart';

class ShareSection extends StatelessWidget {
  const ShareSection({super.key});

  @override
  Widget build(BuildContext context) => Center(
        child: InkWell(
          onTap: () => context.openLink(twitterUrl),
          child: DecoratedBox(
            decoration: const ShapeDecoration(
              shape: CircleBorder(),
              color: CpColors.darkBackground,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Assets.icons.twitter.svg(
                height: 20,
                width: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );
}
