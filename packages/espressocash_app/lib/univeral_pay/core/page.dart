import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../gen/assets.gen.dart';
import '../../ui/button.dart';
import '../../ui/colors.dart';
import '../config.dart';
import '../features/verifier/service/request_verifier_bloc.dart';
import '../features/verifier/widgets/timeline_screen.dart';
import '../routes.gr.dart';
import 'arrow.dart';
import 'extensions.dart';

class PageWidget extends StatelessWidget {
  const PageWidget({
    super.key,
    required this.children,
    this.statusWidget,
  });

  final List<Widget> children;
  final Widget? statusWidget;

  @override
  Widget build(BuildContext context) {
    final showStatus = statusWidget != null;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(_appBarHeight),
        child: Hero(
          tag: 'appbar',
          child: AppBar(
            backgroundColor: Colors.black,
            elevation: 0,
            centerTitle: false,
            leadingWidth: 24,
            leading: null,
            automaticallyImplyLeading: false,
            actions: const [SizedBox.shrink()],
            title: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const EspressoProjectBranding(),
                if (!context.isSmall) const Center(child: _GithubText()),
              ],
            ),
          ),
        ),
      ),
      drawerScrimColor: Colors.transparent,
      endDrawerEnableOpenDragGesture: false,
      endDrawer: (showStatus && !context.isSmall)
          ? Drawer(
              backgroundColor: CpColors.darkSplashBackgroundColor,
              child: Column(
                children: [
                  Container(
                    height: _appBarHeight,
                    decoration: const BoxDecoration(color: Colors.black),
                  ),
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: Builder(
                          builder: (context) => IconButton(
                            padding: const EdgeInsets.all(24),
                            icon: const Icon(Icons.close),
                            color: Colors.white,
                            onPressed: () {
                              Scaffold.of(context).closeEndDrawer();
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Transfer Status',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  if (statusWidget case final statusWidget?)
                    Expanded(child: statusWidget),
                ],
              ),
            )
          : null,
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
                              if (showStatus)
                                _PageButton(
                                  child: const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 12),
                                    child: Text(
                                      'Check Status',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    final widget = statusWidget;

                                    if (widget == null) return;

                                    final bloc =
                                        context.read<RequestVerifierBloc>();

                                    Navigator.of(context).push(
                                      MaterialPageRoute<void>(
                                        builder: (context) => BlocProvider<
                                            RequestVerifierBloc>.value(
                                          value: bloc,
                                          child: TimelineScreen(
                                            child: widget,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
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
            if (showStatus && !context.isSmall)
              Align(
                alignment: Alignment.topRight,
                child: Builder(
                  builder: (context) => Padding(
                    padding: const EdgeInsets.all(24),
                    child: CpButton(
                      text: 'Check Status',
                      width: 170,
                      variant: CpButtonVariant.black,
                      trailing: const Arrow(color: Colors.white),
                      onPressed: () {
                        Scaffold.of(context).openEndDrawer();
                      },
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class EspressoProjectBranding extends StatelessWidget {
  const EspressoProjectBranding({super.key});

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
                      ),
                    ),
                    TextSpan(
                      text: 'Pay',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                style: TextStyle(
                  fontSize: 62,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w800,
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
                fontFamily: 'Inter',
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

const _appBarHeight = 44.0;
