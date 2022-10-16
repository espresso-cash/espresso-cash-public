import 'package:cryptoplease/storybook/stories/app/wallet_main_screen.dart';
import 'package:cryptoplease/storybook/stories/app_bar.dart';
import 'package:cryptoplease/storybook/stories/background_gradient.dart';
import 'package:cryptoplease/storybook/stories/bottom_button.dart';
import 'package:cryptoplease/storybook/stories/bullet_item.dart';
import 'package:cryptoplease/storybook/stories/button.dart';
import 'package:cryptoplease/storybook/stories/chip.dart';
import 'package:cryptoplease/storybook/stories/content_padding.dart';
import 'package:cryptoplease/storybook/stories/empty_message_widget.dart';
import 'package:cryptoplease/storybook/stories/headered_list.dart';
import 'package:cryptoplease/storybook/stories/icon_button.dart';
import 'package:cryptoplease/storybook/stories/info_widget.dart';
import 'package:cryptoplease/storybook/stories/loader.dart';
import 'package:cryptoplease/storybook/stories/rounded_rectangle.dart';
import 'package:cryptoplease/storybook/stories/snackbar.dart';
import 'package:cryptoplease/storybook/stories/status_screen.dart';
import 'package:cryptoplease/storybook/stories/status_widget.dart';
import 'package:cryptoplease/storybook/stories/switch.dart';
import 'package:cryptoplease/storybook/stories/text_field.dart';
import 'package:cryptoplease/storybook/stories/timeline.dart';
import 'package:cryptoplease/storybook/stories/user_avatar.dart';
import 'package:cryptoplease/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

void main() {
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
          cpAppBar,
          cpBackgroundGradient,
          cpBottomButton,
          cpBulletItem,
          cpButton,
          cpChip,
          cpContentPadding,
          cpEmptyMessageWidget,
          cpHeaderedList,
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
