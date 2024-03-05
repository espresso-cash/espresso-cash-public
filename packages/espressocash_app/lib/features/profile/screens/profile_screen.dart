import 'dart:io';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:solana/solana.dart';

import '../../../../../core/presentation/utils.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../ui/icon_button.dart';
import '../../../../../ui/user_avatar.dart';
import '../../../di.dart';
import '../../accounts/models/account.dart';
import '../../authenticated/authenticated_navigator_key.dart';
import '../data/profile_repository.dart';
import '../widgets/help_section.dart';
import '../widgets/profile_section.dart';
import '../widgets/security_section.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<MyAccount>();
    final address = state.publicKey;

    return Scaffold(
      body: Material(
        color: const Color(0xffF4F4F4),
        child: SingleChildScrollView(
          child: SafeArea(
            maintainBottomViewPadding: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    _buttonSpacing,
                    _buttonSpacing,
                    _buttonSpacing,
                    0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: _imageSize,
                        width: MediaQuery.sizeOf(context).width,
                        child: Stack(
                          children: [
                            Center(
                              child: ListenableBuilder(
                                listenable: sl<ProfileRepository>(),
                                builder: (context, child) => CpUserAvatar(
                                  radius: _imageSize / 2,
                                  image: sl<ProfileRepository>().photoPath?.let(
                                        (it) => FileImage(File(it)),
                                      ),
                                  userName: sl<ProfileRepository>()
                                      .initials
                                      .ifEmpty(() => 'MW'),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: CpIconButton(
                                icon: Assets.icons.closeButtonIcon.svg(),
                                onPressed: Navigator.of(context).pop,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: ListenableBuilder(
                          listenable: sl<ProfileRepository>(),
                          builder: (context, child) => Text(
                            sl<ProfileRepository>()
                                .fullName
                                .ifEmpty(() => 'My Wallet'),
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      ListenableBuilder(
                        listenable: sl<ProfileRepository>(),
                        builder: (context, child) => _QrCodeWidget(
                          address: address,
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  child: Column(
                    children: [
                      EditProfileSection(),
                      SecuritySection(),
                      HelpSection(),
                      DangerSection(),
                      ShareSection(),
                      VersionSection(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileRoute extends GoRouteData {
  const ProfileRoute();

  static final GlobalKey<NavigatorState> $parentNavigatorKey =
      authenticatedNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ProfileScreen();
}

const double _buttonSpacing = 22;
const double _imageSize = 88;

class _QrCodeWidget extends StatelessWidget {
  const _QrCodeWidget({
    required this.address,
  });

  final Ed25519HDPublicKey address;

  @override
  Widget build(BuildContext context) {
    final qrData = address.toBase58();

    return InkWell(
      onTap: () => context.copyToClipboard(qrData),
      child: Container(
        height: 150,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: Row(
          children: [
            Expanded(
              child: BarcodeWidget(
                barcode: Barcode.qrCode(),
                data: qrData,
                padding: EdgeInsets.zero,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                address.toBase58(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
