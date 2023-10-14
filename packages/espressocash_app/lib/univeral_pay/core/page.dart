import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../gen/assets.gen.dart';

class PageWidget extends StatelessWidget {
  const PageWidget({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          centerTitle: false,
          automaticallyImplyLeading: true,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'This project is brought to you by ',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
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
          ),
          toolbarHeight: 44,
          actions: const [
            Center(
              child: Padding(
                padding: EdgeInsets.only(right: 16.0),
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'View the code on ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(
                        text: 'Github',
                        style: TextStyle(
                          color: Color(0xFFFFCC17),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
        body: DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Assets.demo.bg.path),
              fit: BoxFit.cover,
              colorFilter: const ColorFilter.mode(
                Color(0xD9FF8617),
                BlendMode.srcATop,
              ),
            ),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
              child: ConstrainedBox(
                constraints: constraints.copyWith(
                  minHeight: constraints.maxHeight,
                  maxHeight: double.infinity,
                ),
                child: IntrinsicHeight(
                  child: Stack(
                    children: [
                      Center(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(24),
                              child: Column(
                                children: [
                                  const SizedBox(height: 24),
                                  const _Header(),
                                  const SizedBox(height: 55),
                                  ...children,
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) => const Column(
        children: [
          FittedBox(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Universal',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 62,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  TextSpan(
                    text: 'Pay',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 62,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
          ),
          SizedBox(height: 8),
          FittedBox(
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
