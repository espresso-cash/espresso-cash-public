part of 'profile_section.dart';

class ShareSection extends StatelessWidget {
  const ShareSection({Key? key}) : super(key: key);

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
              child: Assets.icons.twitter.image(height: 20, width: 20),
            ),
          ),
        ),
      );
}
