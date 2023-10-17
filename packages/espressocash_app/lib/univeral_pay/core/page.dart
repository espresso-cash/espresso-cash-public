import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../gen/assets.gen.dart';
import '../config.dart';
import '../routes.gr.dart';
import 'extensions.dart';

class PageWidget extends StatelessWidget {
  const PageWidget({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(44),
          child: Hero(
            tag: 'appbar',
            child: AppBar(
              backgroundColor: Colors.black,
              elevation: 0,
              centerTitle: false,
              leadingWidth: 24,
              actions: const [SizedBox.shrink()],
              title: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const _EspressoProjectBranding(),
                  if (!context.isSmall) const Center(child: _GithubText()),
                ],
              ),
            ),
          ),
        ),
        body: DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Assets.demo.bg.path),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              CustomScrollView(
                shrinkWrap: true,
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          if (context.isSmall)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _PageButton(
                                  child: const _GithubText(),
                                  onTap: () =>
                                      launchUrl(Uri.parse(githubRepoUrl)),
                                ),
                              ],
                            ),
                          const SizedBox(height: 32),
                          const _Header(),
                          const SizedBox(height: 55),
                          ...children,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}

class _EspressoProjectBranding extends StatelessWidget {
  const _EspressoProjectBranding();

  @override
  Widget build(BuildContext context) => Row(
        children: [
          const FittedBox(
            child: Text(
              'This project is brought to you by ',
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            child: Assets.images.logo.image(height: 29),
            onTap: () {
              launchUrl(Uri.parse('https://www.espressocash.com/'));
            },
          ),
        ],
      );
}

class _PageButton extends StatelessWidget {
  const _PageButton({
    required this.child,
    this.onTap,
  });

  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          height: 33,
          decoration: const ShapeDecoration(
            color: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(35),
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Center(child: child),
          ),
        ),
      );
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) => Column(
        children: [
          GestureDetector(
            onTap: () {
              context.router.navigate(const RequestRoute());
            },
            child: const FittedBox(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Universal',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 64,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: 'Pay',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 64,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
              ),
            ),
          ),
          const SizedBox(height: 8),
          const FittedBox(
            child: Text(
              'Accept USDC from any Blockchain and receive\n payments on Solana with individual tracking.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      );
}

class _GithubText extends StatelessWidget {
  const _GithubText();

  @override
  Widget build(BuildContext context) => Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: 'View the code on ',
              style: TextStyle(
                color: Colors.white,
                fontSize: context.isSmall ? 12 : 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            TextSpan(
              text: 'Github',
              style: TextStyle(
                color: const Color(0xFFFFCC17),
                fontSize: context.isSmall ? 12 : 14,
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  launchUrl(Uri.parse(githubRepoUrl));
                },
            ),
          ],
        ),
        textAlign: TextAlign.center,
        maxLines: 1,
      );
}
