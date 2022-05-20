import 'dart:io';

import 'package:cryptoplease/bl/accounts/account.dart';
import 'package:cryptoplease/config.dart';
import 'package:cryptoplease/presentation/screens/authenticated/profile/component/address_view.dart';
import 'package:cryptoplease/presentation/screens/authenticated/profile/component/profile_section.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

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

    return SingleChildScrollView(
      child: SafeArea(
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
                  CpUserAvatar(
                    radius: _imageSize / 2,
                    image: photoPath?.let((it) => FileImage(File(it))),
                    userName: name,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      name,
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ),
                  AddressView(address: address, color: CpColors.yellowColor),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
              child: Column(
                children: const [
                  SecuritySection(),
                  EditProfileSection(),
                  AboutSection(),
                  DangerSection(),
                  if (!isProd) DebugSection(),
                  VersionSection(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const double _buttonSpacing = 24;
const double _imageSize = 160;
