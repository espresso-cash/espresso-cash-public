# Brij-Only Ramp Flow Design

## Overview

Simplify the ramp flow to bypass partner selection and go directly to Brij when users tap Add Cash or Cash Out.

## Decisions Made

| Decision | Choice |
|----------|--------|
| Keep profile onboarding (country + email)? | Yes, with comments on how to skip |
| What to do with other partner code? | Keep but disable, with comments for future removal |
| What about `RampPartner` enum? | Leave untouched |
| How to modify button flow? | Modify existing `launchOnRampFlow` / `launchOffRampFlow` methods |
| Handle unused imports? | Delete them (keep imports clean) |
| Handle unused switch methods? | Delete entirely, add git history comment |
| Handle `partner_config.dart`? | Leave untouched |

## Changes

### File: `lib/features/ramp/widgets/ramp_buttons.dart`

**Imports to delete:**
- `ramp_partner_select_screen.dart`
- `kado/widgets/launch.dart`
- `coinflow/widgets/launch.dart`
- `guardarian/widgets/launch.dart`
- `moneygram/widgets/launch.dart`
- `ramp_partner/models/ramp_partner.dart`

**Methods to delete:**
- `_launchOnRampPartner()`
- `_launchOffRampPartner()`

**Methods to modify:**

```dart
void launchOnRampFlow() {
  // NOTE: Multi-partner selection removed. To re-enable, see git history
  // for RampPartnerSelectScreen flow and _launchOnRampPartner switch.
  // To skip onboarding entirely, remove ensureProfileData check in button
  // and pass country directly to Brij (Brij can detect country itself).
  final address = sl<MyAccount>().wallet.publicKey.toBase58();
  final profile = getProfileData();
  launchBrijRedirect(type: RampType.onRamp, profile: profile, address: address);
}

void launchOffRampFlow() {
  // NOTE: Multi-partner selection removed. To re-enable, see git history
  // for RampPartnerSelectScreen flow and _launchOffRampPartner switch.
  // To skip onboarding entirely, remove ensureProfileData check in button
  // and pass country directly to Brij (Brij can detect country itself).
  final address = sl<MyAccount>().wallet.publicKey.toBase58();
  final profile = getProfileData();
  launchBrijRedirect(type: RampType.offRamp, profile: profile, address: address);
}
```

**What stays the same:**
- `ensureProfileData()` - keeps onboarding flow
- `getProfileData()` - still used for Brij
- Button widgets (`AddCashButton`, `CashOutButton`, `PayOrRequestButton`)

## Files Left Untouched

These files remain for potential future multi-partner re-enablement:

- `partner_config.dart` - Country filtering logic
- `ramp_partner_select_screen.dart` - Partner selection UI
- `partner_tile.dart` - Partner tile widget
- `RampPartner` enum - All 5 partners defined
- `partners/kado/` - Kado integration
- `partners/coinflow/` - Coinflow integration
- `partners/guardarian/` - Guardarian integration
- `partners/moneygram/` - MoneyGram integration
- `partners/brij_redirect/` - **Actively used**
- Order screens and services

## Future Options

### Re-enable multi-partner selection
See git history for this commit. Restore:
1. Deleted imports in `ramp_buttons.dart`
2. `_launchOnRampPartner()` and `_launchOffRampPartner()` methods
3. `RampPartnerSelectScreen.push()` calls in flow methods

### Skip onboarding entirely (Option 3)
Remove `ensureProfileData` check in button `onPressed` handlers and let Brij handle country detection itself.

### Remove all partner code permanently
Delete these directories/files:
- `partners/kado/`
- `partners/coinflow/`
- `partners/guardarian/`
- `partners/moneygram/`
- `widgets/partner_config.dart`
- `widgets/partner_tile.dart`
- `screens/ramp_partner_select_screen.dart`

Simplify `RampPartner` enum to only `brijRedirect` or remove entirely.
