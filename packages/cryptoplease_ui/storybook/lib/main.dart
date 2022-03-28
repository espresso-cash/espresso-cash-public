import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';
import 'package:storybook/stories/action_selector.dart';
import 'package:storybook/stories/app_bar.dart';
import 'package:storybook/stories/background_gradient.dart';
import 'package:storybook/stories/bottom_button.dart';
import 'package:storybook/stories/bullet_item.dart';
import 'package:storybook/stories/button.dart';
import 'package:storybook/stories/content_padding.dart';
import 'package:storybook/stories/empty_message_widget.dart';
import 'package:storybook/stories/headered_list.dart';
import 'package:storybook/stories/loader.dart';
import 'package:storybook/stories/snackbar.dart';
import 'package:storybook/stories/switch.dart';
import 'package:storybook/stories/text_field.dart';
import 'package:storybook/stories/user_avatar.dart';
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
          cpActionSelector,
          cpAppBar,
          cpBackgroundGradient,
          cpBottomButton,
          cpBulletItem,
          cpButton,
          cpContentPadding,
          cpEmptyMessageWidget,
          cpHeaderedList,
          cpLoader,
          cpSnackbar,
          cpSwitch,
          cpTextField,
          cpUserAvatar,
        ],
      );
}
