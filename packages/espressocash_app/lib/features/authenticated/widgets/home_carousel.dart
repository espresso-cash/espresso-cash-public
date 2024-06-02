import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../gen/assets.gen.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/button.dart';
import '../../../ui/colors.dart';
import '../../../ui/home_tile.dart';

class HomeCarouselWidget extends StatefulWidget {
  const HomeCarouselWidget({super.key, required this.onSendMoneyPressed});

  final VoidCallback onSendMoneyPressed;

  @override
  State<HomeCarouselWidget> createState() => _HomeCarouselWidgetState();
}

class _HomeCarouselWidgetState extends State<HomeCarouselWidget> {
  late final PageController _controller = PageController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isIos = Theme.of(context).platform == TargetPlatform.iOS;

    final items = [
      _Item(
        title: context.l10n.carousel1Title,
        subtitle: context.l10n.carousel1Subtitle,
        button: CpButton(
          minWidth: 250,
          size: CpButtonSize.wide,
          text: context.l10n.carouselSendMoneyBtn,
          onPressed: widget.onSendMoneyPressed,
        ),
        backgroundImage:
            isIos ? Assets.images.carousel2Ios : Assets.images.carousel2,
      ),
      _Item(
        title: context.l10n.carousel2Title,
        subtitle: context.l10n.carousel2Subtitle,
        button: CpButton(
          minWidth: 250,
          size: CpButtonSize.wide,
          text: context.l10n.carouselSendMoneyBtn,
          onPressed: widget.onSendMoneyPressed,
        ),
        backgroundImage: Assets.images.carousel1,
      ),
      _Item(
        title: context.l10n.carousel4Title,
        subtitle: context.l10n.carousel4Subtitle,
        button: CpButton(
          minWidth: 250,
          size: CpButtonSize.wide,
          text: context.l10n.carouselSendMoneyBtn,
          onPressed: widget.onSendMoneyPressed,
        ),
        backgroundImage: Assets.images.carousel4,
      ),
      _Item(
        title: context.l10n.carousel3Title,
        subtitle: context.l10n.carousel3Subtitle,
        button: CpButton(
          minWidth: 250,
          size: CpButtonSize.wide,
          text: context.l10n.carouselSendMoneyBtn,
          onPressed: widget.onSendMoneyPressed,
        ),
        backgroundImage: Assets.images.carousel3,
      ),
    ];

    return HomeTile(
      child: SizedBox(
        height: 385,
        child: Stack(
          children: [
            PageView(
              controller: _controller,
              children: items,
            ),
            Align(
              alignment: const Alignment(0, 0.1),
              child: SmoothPageIndicator(
                controller: _controller,
                count: items.length,
                effect: const ExpandingDotsEffect(
                  activeDotColor: CpColors.carouselDotColor,
                  dotColor: Colors.white,
                  dotHeight: 7,
                  dotWidth: 25,
                  expansionFactor: 2.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({
    required this.title,
    required this.subtitle,
    this.button,
    required this.backgroundImage,
  });

  final String title;
  final String subtitle;
  final Widget? button;
  final AssetGenImage backgroundImage;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(32.0),
              ),
              child: backgroundImage.image(
                height: 175,
                width: 400,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                FittedBox(
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    subtitle,
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                button ?? const SizedBox(height: 44),
              ],
            ),
          ),
        ],
      );
}
