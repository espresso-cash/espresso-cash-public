import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../ui/colors.dart';
import '../../tokens/token.dart';
import '../../tokens/widgets/token_icon.dart';
import '../screens/token_picker_screen.dart';

class TokenPicker extends StatelessWidget {
  const TokenPicker({
    super.key,
    required this.token,
    required this.title,
    required this.onSubmitted,
    this.isExpanded = false,
    this.showOnlyUserTokens = false,
  });

  final Token token;
  final String title;
  final ValueSetter<Token> onSubmitted;
  final bool isExpanded;
  final bool showOnlyUserTokens;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: const ShapeDecoration(color: CpColors.blackGreyColor, shape: StadiumBorder()),
    child: ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      onTap: () async {
        final Token? updated = await TokenPickerScreen.push(
          context,
          initial: token,
          title: title,
          showOnlyUserTokens: showOnlyUserTokens,
        );

        if (context.mounted && updated != null) {
          onSubmitted(updated);
        }
      },
      leading: TokenIcon(token: token, size: 42.w),
      title: FittedBox(
        child: Text(
          isExpanded ? (token.symbol) : '',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.sp),
        ),
      ),
      titleAlignment: ListTileTitleAlignment.threeLine,
      trailing: const Icon(Icons.keyboard_arrow_down_outlined, color: Colors.white),
    ),
  );
}
