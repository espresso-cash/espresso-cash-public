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
                    const SizedBox(height: 24),
                    _AddressWidget(address: state.address),
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

class _AddressWidget extends StatelessWidget {
  const _AddressWidget({
    Key? key,
    required this.address,
  }) : super(key: key);

  final String address;

  @override
  Widget build(BuildContext context) => Container(
        height: 150,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        decoration: const BoxDecoration(
          color: CpColors.lightGreyBackground,
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: Row(
          children: [
            QrImage(data: address, padding: EdgeInsets.zero),
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
      );
}
