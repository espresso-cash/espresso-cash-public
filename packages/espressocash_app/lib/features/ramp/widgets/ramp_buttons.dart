import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';

import '../../../../../l10n/l10n.dart';
import '../../../di.dart';
import '../../../gen/assets.gen.dart';
import '../../../ui/button.dart';
import '../../../ui/icon_button.dart';
import '../../accounts/models/account.dart';
import '../../country_picker/models/country.dart';
import '../../profile/data/profile_repository.dart';
import '../../ramp_partner/models/ramp_type.dart';
import '../models/profile_data.dart';
import '../partners/brij_redirect/widgets/launch.dart';
import '../screens/ramp_onboarding_screen.dart';

class PayOrRequestButton extends StatelessWidget {
  const PayOrRequestButton({
    super.key,
    required this.voidCallback,
    this.size = CpButtonSize.normal,
  });

  final CpButtonSize size;
  final VoidCallback voidCallback;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      CpIconButton(
        icon: Assets.icons.dolar.svg(color: Colors.black),
        variant: CpIconButtonVariant.dark,
        size: CpIconButtonSize.large,
        onPressed: voidCallback,
      ),
      const SizedBox(height: 8),
      Text(
        context.l10n.requestOrSendPayment,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
      ),
    ],
  );
}

class AddCashButton extends StatelessWidget {
  const AddCashButton({super.key, this.size = CpButtonSize.normal});

  final CpButtonSize size;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      CpIconButton(
        icon: Assets.icons.addAlternative.svg(color: Colors.black),
        variant: CpIconButtonVariant.dark,
        size: CpIconButtonSize.large,
        onPressed: () async {
          final hasProfile = await context.ensureProfileData(RampType.onRamp) != null;

          if (context.mounted && hasProfile) {
            context.launchOnRampFlow();
          }
        },
      ),
      const SizedBox(height: 8),
      Text(
        context.l10n.ramp_btnAddCash,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
      ),
    ],
  );
}

class CashOutButton extends StatelessWidget {
  const CashOutButton({super.key, this.size = CpButtonSize.normal});

  final CpButtonSize size;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      CpIconButton(
        icon: Assets.icons.withdrawn.svg(color: Colors.black),
        variant: CpIconButtonVariant.dark,
        size: CpIconButtonSize.large,
        onPressed: () async {
          final hasProfile = await context.ensureProfileData(RampType.offRamp) != null;

          if (context.mounted && hasProfile) {
            context.launchOffRampFlow();
          }
        },
      ),
      const SizedBox(height: 8),
      Text(
        context.l10n.ramp_btnCashOut,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
      ),
    ],
  );
}

extension RampBuildContextExt on BuildContext {
  Future<ProfileData?> ensureProfileData(RampType rampType) async {
    void handleSubmitted() {
      Navigator.pop(this);
    }

    final repository = sl<ProfileRepository>();
    Country? country = repository.country?.let(Country.findByCode);
    String email = repository.email;

    if (country != null && email.isNotEmpty) {
      return (country: country, email: email);
    }

    await RampOnboardingScreen.push(this, onConfirmed: handleSubmitted, rampType: rampType);

    country = repository.country?.let(Country.findByCode);
    email = repository.email;

    return country != null && email.isNotEmpty ? (country: country, email: email) : null;
  }

  ProfileData getProfileData() {
    final repository = sl<ProfileRepository>();
    final Country? country = repository.country?.let(Country.findByCode);
    final String email = repository.email;

    if (country == null || email.isEmpty) {
      throw Exception('Profile data not available.');
    }

    return (country: country, email: email);
  }

  void launchOnRampFlow() => _launchRamp(RampType.onRamp);

  void launchOffRampFlow() => _launchRamp(RampType.offRamp);

  void _launchRamp(RampType type) {
    final address = sl<MyAccount>().wallet.publicKey.toBase58();
    final profile = getProfileData();
    launchBrijRedirect(type: type, profile: profile, address: address);
  }
}
