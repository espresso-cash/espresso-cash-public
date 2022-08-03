import 'dart:io';

import 'package:cryptoplease/config.dart';
import 'package:cryptoplease/core/accounts/bl/account.dart';
import 'package:cryptoplease/features/profile/components/profile_section.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
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

    return Material(
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
                              icon: Icons.close_outlined,
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
                    Container(
                      height: 150,
                      width: 150,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: CpColors.lightGreyBackground,
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      child: QrImage(
                        data: address,
                        size: 136,
                      ),
                    ),
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
                    if (!isProd) DebugSection(),
                    ShareSection(),
                    VersionSection(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const double _buttonSpacing = 24;
const double _imageSize = 100;
