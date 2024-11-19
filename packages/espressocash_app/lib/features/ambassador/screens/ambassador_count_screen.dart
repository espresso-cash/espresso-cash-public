import 'package:flutter/material.dart';

import '../../../di.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/button.dart';
import '../../../ui/colors.dart';
import '../../../ui/loader.dart';
import '../../../ui/text_field.dart';
import '../../profile/data/profile_repository.dart';
import '../widgets/ambassador_page.dart';
import 'share_ambassador_link_screen.dart';

class AmbassadorCountScreen extends StatefulWidget {
  const AmbassadorCountScreen({super.key});

  static void push(BuildContext context) =>
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(
          builder: (context) => const AmbassadorCountScreen(),
        ),
      );

  @override
  State<AmbassadorCountScreen> createState() => _AmbassadorCountScreenState();
}

class _AmbassadorCountScreenState extends State<AmbassadorCountScreen> {
  late final String _name;
  late final Future<int> _countFuture;

  @override
  void initState() {
    super.initState();
    _name = sl<ProfileRepository>().fullName;
    _countFuture = _getCount();
  }

  Future<int> _getCount() async {
    //TODO get from client
    await Future.delayed(const Duration(seconds: 2));

    return 10;
  }

  @override
  Widget build(BuildContext context) => FutureBuilder<int>(
        future: _countFuture,
        builder: (context, snapshot) => CpLoader(
          isLoading: !snapshot.hasData,
          child: AmbassadorPage(
            name: _name,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Center(
                      child: _ReferralCount(count: snapshot.data ?? 0),
                    ),
                  ),
                  CpButton(
                    text: context.l10n.ambassador_ambassadorQrCode,
                    size: CpButtonSize.big,
                    width: 340,
                    onPressed: () =>
                        ShareAmbassadorLinkScreen.navigate(context),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      );
}

class _ReferralCount extends StatelessWidget {
  const _ReferralCount({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                context.l10n.ambassador_newUsersOnboarded,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.17,
                  color: CpColors.darkBackgroundColor,
                ),
              ),
            ),
            const SizedBox(height: 4),
            CpTextField(
              controller: TextEditingController(text: count.toString()),
              backgroundColor: CpColors.darkBackgroundColor,
              readOnly: true,
              textColor: Colors.white,
              fontSize: 34,
              fontWeight: FontWeight.w700,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            ),
          ],
        ),
      );
}
