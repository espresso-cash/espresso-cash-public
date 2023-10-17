import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

import '../config.dart';
import '../features/request/screens/request_screen.dart';

@RoutePage()
class DemoScreen extends StatefulWidget {
  const DemoScreen({super.key});

  @override
  State<DemoScreen> createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
  @override
  void initState() {
    super.initState();

    launchUrl(Uri.parse(demoVideoUrl));
    context.router.replace(RequestScreen.route());
  }

  @override
  Widget build(BuildContext context) => Container();
}
