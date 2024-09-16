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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(context.l10n.followUsOn),
                  const SizedBox(width: 6),
                  Assets.icons.x.svg(
                    height: 22,
                    width: 22,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
