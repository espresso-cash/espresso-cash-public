import 'dart:convert';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:solana/solana.dart';

import '../../../../core/accounts/bl/account.dart';
import '../../../../core/presentation/utils.dart';
import '../../../../features/qr_scanner/models/qr_address_data.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../ui/icon_button.dart';
import '../../../../ui/user_avatar.dart';
import 'components/learning_section.dart';
import 'components/profile_section.dart';
import 'components/security_section.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<MyAccount>();
    final name = state.firstName;
    final photoPath = state.photoPath;
    final address = state.publicKey;

    return Scaffold(
      body: Material(
        color: const Color(0xffF4F4F4),
        child: SafeArea(
          maintainBottomViewPadding: true,
          child: SingleChildScrollView(
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
                        width: MediaQuery.of(context).size.width,
                        child: Stack(
                          children: [
                            Center(
                              child: CpUserAvatar(
                                radius: _imageSize / 2,
                                image: photoPath?.let(
                                  (it) => FileImage(File(it)),
                                ),
                                userName: name,
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
                        child: Text(
                          name,
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ),
                      const SizedBox(height: 24),
                      _QrCodeWidget(address: address, name: name),
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
                      LearningSection(),
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

const double _buttonSpacing = 22;
const double _imageSize = 88;

class _QrCodeWidget extends StatelessWidget {
  const _QrCodeWidget({
    required this.address,
    required this.name,
  });

  final Ed25519HDPublicKey address;
  final String name;

  @override
  Widget build(BuildContext context) {
    final qrData =
        jsonEncode(QrAddressData(address: address, name: name).toJson());

    return InkWell(
      onTap: () => context.copyToClipboard(address.toBase58()),
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
