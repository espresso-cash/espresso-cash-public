import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../config.dart';

@RoutePage()
class DemoScreen extends StatefulWidget {
  const DemoScreen({super.key});

  @override
  State<DemoScreen> createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
  final _controller = YoutubePlayerController(
    initialVideoId: YoutubePlayerController.convertUrlToId(demoVideoUrl) ?? '',
    params:
        const YoutubePlayerParams(showFullscreenButton: true, autoPlay: false),
  );

  @override
  void dispose() {
    _controller.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'DEMO',
                  style: TextStyle(
                    fontSize: 48,
                    fontFamily: 'Inter',
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                ),
                const SizedBox(height: 32),
                SizedBox(
                  height: 500,
                  child: YoutubePlayerIFrame(
                    controller: _controller,
                    aspectRatio: 16 / 9,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
