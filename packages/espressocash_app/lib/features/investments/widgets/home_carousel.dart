import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../gen/assets.gen.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/button.dart';
import '../../../ui/colors.dart';
import '../../wallet_flow/screens/wallet_flow_screen.dart';
import 'home_widget.dart';

class HomeCarouselWidget extends StatefulWidget {
  const HomeCarouselWidget({super.key});

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
    final items = [
      _Item(
        title: context.l10n.carousel1Title,
        subtitle: context.l10n.carousel1Subtitle,
        button: CpButton(
          minWidth: 250,
          size: CpButtonSize.wide,
          text: context.l10n.carouselSendMoneyBtn,
          onPressed: () => context.router.navigate(WalletFlowScreen.route()),
        ),
        backgroundImage: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Assets.images.carousel1.image(),
            ),
            Expanded(
              child: Assets.images.carousel15.image(),
            ),
          ],
        ),
      ),
      _Item(
        title: context.l10n.carousel2Title,
        subtitle: context.l10n.carousel2Subtitle,
        button: CpButton(
          minWidth: 250,
          size: CpButtonSize.wide,
          text: context.l10n.carouselSendMoneyBtn,
          onPressed: () => context.router.navigate(WalletFlowScreen.route()),
        ),
        backgroundImage: Assets.images.carousel2.image(),
      ),
      _Item(
        title: context.l10n.carousel3Title,
        subtitle: context.l10n.carousel3Subtitle,
        backgroundImage: Assets.images.carousel3.image(),
      ),
    ];

    return HomeTile(
      child: SizedBox(
        height: 375,
        child: Stack(
          children: [
            PageView(
              controller: _controller,
              children: items,
            ),
            Align(
              alignment: Alignment.center,
              child: SmoothPageIndicator(
                controller: _controller,
                count: items.length,
                effect: const ExpandingDotsEffect(
                  activeDotColor: CpColors.primaryColor,
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
  final Widget backgroundImage;

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: _carouselMaxWidth),
              child: backgroundImage,
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              constraints: const BoxConstraints(maxWidth: _carouselMaxWidth),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.1, 0.4, 0.6],
                  colors: [
                    Colors.black.withOpacity(0),
                    const Color(0x76CCCCCC),
                    CpColors.dashboardBackgroundColor,
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0.0, 0.7),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  FittedBox(
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFF2D2B2C),
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFF2D2B2C),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 15),
                  button ?? const SizedBox(height: 44),
                ],
              ),
            ),
          ),
        ],
      );
}

const _carouselMaxWidth = 430.0;
