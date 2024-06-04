import 'dart:io';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:solana/solana.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../../ui/icon_button.dart';
import '../../../../../ui/user_avatar.dart';
import '../../../di.dart';
import '../../../ui/clipboard.dart';
import '../../../ui/colors.dart';
import '../../accounts/models/account.dart';
import '../data/profile_repository.dart';
import '../widgets/help_section.dart';
import '../widgets/profile_section.dart';
import '../widgets/security_section.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static void push(BuildContext context) => Navigator.of(context).push<void>(
        MaterialPageRoute(
          fullscreenDialog: true,
          builder: (context) => const ProfileScreen(),
        ),
      );

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Material(
          color: CpColors.darkBackground,
          child: SingleChildScrollView(
            child: SafeArea(
              maintainBottomViewPadding: true,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      left: _buttonSpacing,
                      top: _buttonSpacing,
                      right: _buttonSpacing,
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
                                    image:
                                        sl<ProfileRepository>().photoPath?.let(
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
                                  icon: Assets.icons.closeButtonIcon.svg(
                                    color: Colors.white,
                                  ),
                                  onPressed: Navigator.of(context).pop,
                                  variant: CpIconButtonVariant.black,
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
                            address: sl<MyAccount>().publicKey,
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
        padding: EdgeInsets.zero,
        alignment: Alignment.centerLeft,
        decoration: const BoxDecoration(
          color: CpColors.darkBackgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 22,
            vertical: 19,
          ),
          child: Row(
            children: [
              BarcodeWidget(
                barcode: Barcode.qrCode(),
                width: 101,
                height: 101,
                data: qrData,
                color: CpColors.lightGreyBackground,
              ),
              const SizedBox(width: 32),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.zero,
                  child: Text(
                    address.toBase58(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
