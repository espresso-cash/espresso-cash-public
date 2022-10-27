import 'dart:convert';
import 'dart:io';

import 'package:cryptoplease/app/screens/authenticated/profile/components/profile_section.dart';
import 'package:cryptoplease/core/accounts/bl/account.dart';
import 'package:cryptoplease/core/presentation/utils.dart';
import 'package:cryptoplease/features/qr_scanner/qr_address_data.dart';
import 'package:cryptoplease/gen/assets.gen.dart';
import 'package:cryptoplease/ui/colors.dart';
import 'package:cryptoplease/ui/icon_button.dart';
import 'package:cryptoplease/ui/user_avatar.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<MyAccount>();
    final name = state.firstName;
    final photoPath = state.photoPath;
    final address = state.address;

    return Scaffold(
      body: Material(
        color: Colors.white,
        child: SafeArea(
          bottom: false,
          maintainBottomViewPadding: false,
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
                          style: Theme.of(context).textTheme.headline3,
                        ),
                      ),
                      const SizedBox(height: 24),
                      _QrCodeWidget(address: address, name: name),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 24,
                  ),
                  child: Column(
                    children: const [
                      EditProfileSection(),
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
    Key? key,
    required this.address,
    required this.name,
  }) : super(key: key);

  final String address;
  final String name;

  @override
  Widget build(BuildContext context) {
    final qrData = jsonEncode(
      QrAddressData(address: address, name: name).toJson(),
    );

    return InkWell(
      onTap: () => context.copyToClipboard(address),
      child: Container(
        height: 150,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        decoration: const BoxDecoration(
          color: CpColors.lightGreyBackground,
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: Row(
          children: [
            QrImage(data: qrData, padding: EdgeInsets.zero),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 24),
                child: Text(
                  address,
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
    );
  }
}
