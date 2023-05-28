import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

import '../di.dart';
import '../ui/theme.dart';
import 'stories/activity_tile.dart';
import 'stories/app/investments/portfolio_widget.dart';
import 'stories/app/wallet_main_screen.dart';
import 'stories/app_bar.dart';
import 'stories/background_gradient.dart';
import 'stories/bordered_row.dart';
import 'stories/bottom_button.dart';
import 'stories/bullet_item.dart';
import 'stories/button.dart';
import 'stories/chip.dart';
import 'stories/content_padding.dart';
import 'stories/crypto_header.dart';
import 'stories/dialog.dart';
import 'stories/empty_message_widget.dart';
import 'stories/icon_button.dart';
import 'stories/info_widget.dart';
import 'stories/loader.dart';
import 'stories/navigation_bar.dart';
import 'stories/rounded_rectangle.dart';
import 'stories/shake.dart';
import 'stories/slider.dart';
import 'stories/snackbar.dart';
import 'stories/status_screen.dart';
import 'stories/status_widget.dart';
import 'stories/switch.dart';
import 'stories/tab_bar.dart';
import 'stories/text_button.dart';
import 'stories/text_field.dart';
import 'stories/timeline.dart';
import 'stories/user_avatar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const StorybookApp());
}

class StorybookApp extends StatelessWidget {
  const StorybookApp({super.key});

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
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
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
          appPortfolioWidget,
          appWalletMainScreen,
          cpActivityTile,
          cpAppBar,
          cpBackgroundGradient,
          cpBorderedRow,
          cpBottomButton,
          cpBulletItem,
          cpButton,
          cpChip,
          cpContentPadding,
          cpCryptoHeader,
          cpDialog,
          cpEmptyMessageWidget,
          cpIconButton,
          cpInfoWidget,
          cpLoader,
          cpNavigationBar,
          cpRoundedRectangle,
          cpShake,
          cpSlider,
          cpSnackbar,
          cpStatus,
          cpStatusScreen,
          cpSwitch,
          cpTabBar,
          cpTextButton,
          cpTextField,
          cpTimeline,
          cpUserAvatar,
        ],
      );
}
