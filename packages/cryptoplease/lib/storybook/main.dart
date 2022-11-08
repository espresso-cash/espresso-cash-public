import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

import '../di.dart';
import '../ui/theme.dart';
import 'stories/app/investments/popular_crypto_header.dart';
import 'stories/app/investments/portfolio_widget.dart';
import 'stories/app/wallet_main_screen.dart';
import 'stories/app_bar.dart';
import 'stories/background_gradient.dart';
import 'stories/bottom_button.dart';
import 'stories/bullet_item.dart';
import 'stories/button.dart';
import 'stories/chip.dart';
import 'stories/content_padding.dart';
import 'stories/empty_message_widget.dart';
import 'stories/icon_button.dart';
import 'stories/info_widget.dart';
import 'stories/loader.dart';
import 'stories/rounded_rectangle.dart';
import 'stories/snackbar.dart';
import 'stories/status_screen.dart';
import 'stories/status_widget.dart';
import 'stories/switch.dart';
import 'stories/text_field.dart';
import 'stories/timeline.dart';
import 'stories/user_avatar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const StorybookApp());
}

class StorybookApp extends StatelessWidget {
  const StorybookApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Storybook(
        plugins: initializePlugins(
          contentsSidePanel: true,
          knobsSidePanel: true,
        ),
        wrapperBuilder: (context, child) => MaterialApp(
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          debugShowCheckedModeBanner: false,
          useInheritedMediaQuery: true,
          home: Builder(
            builder: (context) {
              final brightness = Theme.of(context).brightness;

              return CpTheme(
                theme: brightness == Brightness.dark
                    ? const CpThemeData.dark()
                    : const CpThemeData.light(),
                child: Scaffold(body: Center(child: child)),
              );
            },
          ),
        ),
        stories: [
          appWalletMainScreen,
          appPopularCryptoHeader,
          appPortfolioWidget,
          cpAppBar,
          cpBackgroundGradient,
          cpBottomButton,
          cpBulletItem,
          cpButton,
          cpChip,
          cpContentPadding,
          cpEmptyMessageWidget,
          cpIconButton,
          cpInfoWidget,
          cpLoader,
          cpRoundedRectangle,
          cpSnackbar,
          cpStatus,
          cpStatusScreen,
          cpSwitch,
          cpTextField,
          cpTimeline,
          cpUserAvatar,
        ],
      );
}
