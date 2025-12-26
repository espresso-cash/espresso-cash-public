# Remove Legacy Ramp Partners Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Remove all legacy ramp partner code (Guardarian, Kado, Coinflow, MoneyGram) leaving only Brij Redirect as the sole ramp partner.

**Architecture:** Sequential partner removal with commit after each. Partners ordered by complexity: Guardarian (simplest) → Kado → Coinflow → MoneyGram (most complex due to Stellar integration). Each removal includes code, tests, assets, DI registrations, and references.

**Tech Stack:** Flutter/Dart, Drift (database), Injectable (DI), Freezed (code generation)

---

## Task 1: Remove Guardarian Partner

Guardarian is the simplest partner - only has a launch widget.

**Files:**
- Delete: `lib/features/ramp/partners/guardarian/` (entire directory)
- Delete: `assets/brands/guardarian.png`
- Modify: `lib/features/ramp_partner/models/ramp_partner.dart` - remove enum value
- Modify: `lib/features/ramp/widgets/partner_config.dart` - remove country config
- Modify: `lib/features/ramp/services/on_ramp_order_service.dart` - remove switch case
- Modify: `lib/features/ramp/services/off_ramp_order_service.dart` - remove switch case
- Modify: `lib/config.dart` - remove guardarian config constants

**Step 1: Delete the Guardarian partner directory**

Run: `rm -rf lib/features/ramp/partners/guardarian`

**Step 2: Delete the Guardarian brand asset**

Run: `rm assets/brands/guardarian.png`

**Step 3: Remove Guardarian from RampPartner enum**

Edit `lib/features/ramp_partner/models/ramp_partner.dart`:
- Remove the `guardarian` enum value (lines 27-38)
- Remove `RampPartner.guardarian` case from `logo` getter extension

**Step 4: Remove Guardarian country config**

Edit `lib/features/ramp/widgets/partner_config.dart`:
- Remove `_guardarianCountries` constant (lines 53-57)
- Remove the guardarian partner logic from `getOnRampPartners` (lines 22-24)

**Step 5: Remove Guardarian from OnRampOrderService**

Edit `lib/features/ramp/services/on_ramp_order_service.dart`:
- Remove `RampPartner.guardarian` from the switch case in `init()` method (around line 67)

**Step 6: Remove Guardarian from OffRampOrderService**

Edit `lib/features/ramp/services/off_ramp_order_service.dart`:
- Remove `RampPartner.guardarian` from switch case in `init()` method (around line 91)
- Remove `RampPartner.guardarian` from throw statement in `_watch()` method (around line 327-329)

**Step 7: Remove Guardarian config constants**

Edit `lib/config.dart`:
- Remove `guardarianBaseUrl` constant (line 62)
- Remove `guardarianApiKey` constant (line 63)

**Step 8: Run build_runner to regenerate code**

Run: `make flutter_build`

**Step 9: Run analyzer to verify no errors**

Run: `make dart_analyze`

**Step 10: Commit**

```bash
git add -A && git commit -m "refactor: remove Guardarian ramp partner"
```

---

## Task 2: Remove Kado Partner

Kado has data layer (API client), services (watchers), and widgets.

**Files:**
- Delete: `lib/features/ramp/partners/kado/` (entire directory)
- Delete: `assets/brands/kado.png`
- Modify: `lib/features/ramp_partner/models/ramp_partner.dart` - remove enum value
- Modify: `lib/features/ramp/widgets/partner_config.dart` - remove country config
- Modify: `lib/features/ramp/services/on_ramp_order_service.dart` - remove switch case
- Modify: `lib/features/ramp/services/off_ramp_order_service.dart` - remove switch case and watcher import
- Modify: `lib/config.dart` - remove kado config constants

**Step 1: Delete the Kado partner directory**

Run: `rm -rf lib/features/ramp/partners/kado`

**Step 2: Delete the Kado brand asset**

Run: `rm assets/brands/kado.png`

**Step 3: Remove Kado from RampPartner enum**

Edit `lib/features/ramp_partner/models/ramp_partner.dart`:
- Remove the `kado` enum value (lines 8-18)
- Remove `RampPartner.kado` case from `logo` getter extension

**Step 4: Remove Kado country config**

Edit `lib/features/ramp/widgets/partner_config.dart`:
- Remove `_kadoCountries` constant (line 51)
- Remove the kado partner logic from `getOnRampPartners` (lines 18-20)

**Step 5: Remove Kado from OnRampOrderService**

Edit `lib/features/ramp/services/on_ramp_order_service.dart`:
- Remove `RampPartner.kado` from the switch case in `init()` method

**Step 6: Remove Kado from OffRampOrderService**

Edit `lib/features/ramp/services/off_ramp_order_service.dart`:
- Remove import of `kado_off_ramp_order_watcher.dart` (line 31)
- Remove `RampPartner.kado` from switch case in `init()` method
- Remove `RampPartner.kado` from switch in `_watch()` method

**Step 7: Remove Kado config constants**

Edit `lib/config.dart`:
- Remove `kadoBaseUrl` constant (line 56)
- Remove `kadoApiBaseUrl` constant (line 57)
- Remove `kadoApiKey` constant (line 58)

**Step 8: Run build_runner to regenerate code**

Run: `make flutter_build`

**Step 9: Run analyzer to verify no errors**

Run: `make dart_analyze`

**Step 10: Commit**

```bash
git add -A && git commit -m "refactor: remove Kado ramp partner"
```

---

## Task 3: Remove Coinflow Partner

Coinflow has data layer, services, widgets, and a link listener in home_screen.

**Files:**
- Delete: `lib/features/ramp/partners/coinflow/` (entire directory)
- Delete: `assets/brands/coinflow.png`
- Modify: `lib/features/ramp_partner/models/ramp_partner.dart` - remove enum value
- Modify: `lib/features/ramp/widgets/partner_config.dart` - remove country config
- Modify: `lib/features/ramp/services/on_ramp_order_service.dart` - remove switch case
- Modify: `lib/features/ramp/services/off_ramp_order_service.dart` - remove switch case and watcher import
- Modify: `lib/features/authenticated/screens/home_screen.dart` - remove CoinflowLinkListener
- Modify: `lib/config.dart` - remove coinflow config constants

**Step 1: Delete the Coinflow partner directory**

Run: `rm -rf lib/features/ramp/partners/coinflow`

**Step 2: Delete the Coinflow brand asset**

Run: `rm assets/brands/coinflow.png`

**Step 3: Remove Coinflow from RampPartner enum**

Edit `lib/features/ramp_partner/models/ramp_partner.dart`:
- Remove the `coinflow` enum value (lines 21-25)
- Remove `RampPartner.coinflow` case from `logo` getter extension

**Step 4: Remove Coinflow country config**

Edit `lib/features/ramp/widgets/partner_config.dart`:
- Remove `_coinflowCountries` constant (lines 59-63)
- Remove the coinflow partner logic from `getOffRampPartners` (lines 42-44)

**Step 5: Remove Coinflow from OnRampOrderService**

Edit `lib/features/ramp/services/on_ramp_order_service.dart`:
- Remove `RampPartner.coinflow` from the switch case in `init()` method

**Step 6: Remove Coinflow from OffRampOrderService**

Edit `lib/features/ramp/services/off_ramp_order_service.dart`:
- Remove import of `coinflow_off_ramp_order_watcher.dart` (line 30)
- Remove `RampPartner.coinflow` from switch case in `init()` method
- Remove `RampPartner.coinflow` from switch in `_watch()` method

**Step 7: Remove CoinflowLinkListener from HomeScreen**

Edit `lib/features/authenticated/screens/home_screen.dart`:
- Remove import of `coinflow_link_listener.dart` (line 16)
- Remove `CoinflowLinkListener` wrapper widget from build method (line 69)
- Adjust widget nesting hierarchy

**Step 8: Remove Coinflow config constants**

Edit `lib/config.dart`:
- Remove `coinflowApiUrl` constant (lines 69-71)
- Remove `coinflowKycUrl` constant (lines 73-75)

**Step 9: Run build_runner to regenerate code**

Run: `make flutter_build`

**Step 10: Run analyzer to verify no errors**

Run: `make dart_analyze`

**Step 11: Commit**

```bash
git add -A && git commit -m "refactor: remove Coinflow ramp partner"
```

---

## Task 4: Remove MoneyGram Partner (Part 1: Partner Directory)

MoneyGram is complex - has data layer (API client, Allbridge client, DTOs), services, widgets with styling. First remove the partner directory itself.

**Files:**
- Delete: `lib/features/ramp/partners/moneygram/` (entire directory)
- Delete: `assets/brands/moneygram.png`

**Step 1: Delete the MoneyGram partner directory**

Run: `rm -rf lib/features/ramp/partners/moneygram`

**Step 2: Delete the MoneyGram brand asset**

Run: `rm assets/brands/moneygram.png`

**Step 3: Run build_runner (will have errors, continue)**

Run: `make flutter_build` (expect errors - will fix in next steps)

---

## Task 5: Remove MoneyGram Partner (Part 2: Enum and Services)

**Files:**
- Modify: `lib/features/ramp_partner/models/ramp_partner.dart` - remove enum value
- Modify: `lib/features/ramp/widgets/partner_config.dart` - remove country config
- Modify: `lib/features/ramp/services/on_ramp_order_service.dart` - remove moneygram logic
- Modify: `lib/features/ramp/services/off_ramp_order_service.dart` - remove moneygram logic

**Step 1: Remove MoneyGram from RampPartner enum**

Edit `lib/features/ramp_partner/models/ramp_partner.dart`:
- Remove the `moneygram` enum value (line 40)
- Remove `RampPartner.moneygram` case from `logo` getter extension

**Step 2: Remove MoneyGram country config**

Edit `lib/features/ramp/widgets/partner_config.dart`:
- Remove `_moneygramOnRampCountries` constant (lines 65-69)
- Remove `_moneygramOffRampCountries` constant (lines 71-87)
- Remove the moneygram partner logic from `getOnRampPartners` (lines 12-16)
- Remove the moneygram partner logic from `getOffRampPartners` (lines 36-40)
- Remove `isMoneygramEnabled` variable and FeatureFlagsManager import/usage

**Step 3: Remove MoneyGram from OnRampOrderService**

Edit `lib/features/ramp/services/on_ramp_order_service.dart`:
- Remove `RampPartner.moneygram` case from the switch in `init()` method (lines 62-64)

**Step 4: Remove MoneyGram from OffRampOrderService**

Edit `lib/features/ramp/services/off_ramp_order_service.dart`:
- Remove `RampPartner.moneygram` case from switch in `init()` method (lines 86-88)
- Remove `RampPartner.moneygram` from switch in `_watch()` method (line 328)
- Remove MoneyGram-specific cancel logic in `cancel()` method (lines 229-231)

---

## Task 6: Remove MoneyGram Partner (Part 3: Screens)

**Files:**
- Modify: `lib/features/ramp/screens/on_ramp_order_screen.dart` - remove moneygram-specific UI
- Modify: `lib/features/ramp/screens/off_ramp_order_screen.dart` - remove moneygram-specific UI

**Step 1: Clean OnRampOrderScreen**

Edit `lib/features/ramp/screens/on_ramp_order_screen.dart`:
- Remove import of `moneygram/widgets/style.dart` (line 25)
- Remove `isMoneygramOrder` variable and related theme logic (line 77-79)
- Remove `_MgAdditionalInfo` widget usage (lines 175-179)
- Remove `toMoneygramStatus()` extension method call
- Remove MoneyGram-specific timeline text (line 320-321)
- Delete `_MgAdditionalInfo` widget class entirely (lines 232-279)
- Delete `toMoneygramStatus()` extension (lines 384-395)
- Clean up theme to always use black theme

**Step 2: Clean OffRampOrderScreen**

Edit `lib/features/ramp/screens/off_ramp_order_screen.dart`:
- Remove import of `moneygram/widgets/extensions.dart` (line 27)
- Remove import of `moneygram/widgets/style.dart` (line 28)
- Remove `isMoneygramOrder` variable usages (lines 82, 121-123, 151, etc.)
- Remove `handleContinue` and `handleMoreInfo` moneygram callbacks (lines 97-103)
- Remove `_ContinueButton` and `_MoreInfoButton` widgets and their usages
- Remove `_MgAdditionalInfo` widget and usage (lines 288-337)
- Remove MoneyGram-specific timeline logic (line 348, 350-353, 356, 366, 381)
- Remove `toActiveItemForMoneygram()` extension (lines 494-512)
- Remove `showMoneygramReceiveAmount` extension (lines 525-545)
- Remove `toMoneygramStatus()` extension (lines 547-567)
- Clean up theme to always use black theme

---

## Task 7: Remove MoneyGram Partner (Part 4: Feature Flags & Stellar)

MoneyGram required Stellar chain integration. Remove related code.

**Files:**
- Modify: `lib/features/feature_flags/data/feature_flags_manager.dart` - remove moneygram flag
- Delete: `lib/features/stellar/` (entire directory - only used for moneygram)
- Delete: `lib/features/stellar_recovery/` (entire directory - only used for moneygram)

**Step 1: Clean FeatureFlagsManager**

Edit `lib/features/feature_flags/data/feature_flags_manager.dart`:
- Remove `isMoneygramAccessEnabled()` method (line 30)
- Remove `FeatureFlag.moneygram` enum value (line 38)
- If `FeatureFlag` enum becomes empty, consider removing the enum or keeping for future use

**Step 2: Delete Stellar feature**

Run: `rm -rf lib/features/stellar`

**Step 3: Delete Stellar Recovery feature**

Run: `rm -rf lib/features/stellar_recovery`

---

## Task 8: Remove MoneyGram Partner (Part 5: Storybook & Cleanup)

**Files:**
- Modify: `lib/storybook/stories/screens/on_ramp_order_screen.dart` - update default partner
- Modify: `lib/storybook/stories/screens/off_ramp_order_screen.dart` - update default partner
- Modify: `lib/storybook/stories/screens/off_ramp_amount_screen.dart` - update default partner
- Modify: `lib/features/ramp/widgets/on_ramp_deposit_widget.dart` - remove moneygram references if any
- Modify: `lib/features/ramp/widgets/on_ramp_order_details.dart` - remove moneygram references if any

**Step 1: Update OnRampOrderScreen storybook**

Edit `lib/storybook/stories/screens/on_ramp_order_screen.dart`:
- Change `initial: RampPartner.moneygram` to `initial: RampPartner.brijRedirect` (line 21)

**Step 2: Update OffRampOrderScreen storybook**

Edit `lib/storybook/stories/screens/off_ramp_order_screen.dart`:
- Change `initial: RampPartner.moneygram` to `initial: RampPartner.brijRedirect` (line 26)

**Step 3: Update OffRampAmountScreen storybook**

Edit `lib/storybook/stories/screens/off_ramp_amount_screen.dart`:
- Change `initial: RampPartner.kado` to `initial: RampPartner.brijRedirect` (line 17)

**Step 4: Run build_runner to regenerate all code**

Run: `make flutter_build`

**Step 5: Run analyzer to verify no errors**

Run: `make dart_analyze`

**Step 6: Commit**

```bash
git add -A && git commit -m "refactor: remove MoneyGram ramp partner and Stellar integration"
```

---

## Task 9: Final Cleanup - Simplify RampPartner Enum

Now that only brijRedirect remains, simplify the codebase.

**Files:**
- Modify: `lib/features/ramp_partner/models/ramp_partner.dart` - leave only brijRedirect
- Modify: `lib/features/ramp/widgets/partner_config.dart` - simplify to always return brijRedirect
- Evaluate: `lib/features/ramp/screens/ramp_partner_select_screen.dart` - may no longer be needed
- Evaluate: `lib/storybook/stories/screens/ramp_partner_select_screen.dart` - may no longer be needed

**Step 1: Verify RampPartner enum has only brijRedirect**

Edit `lib/features/ramp_partner/models/ramp_partner.dart` and confirm only `brijRedirect` remains.

**Step 2: Simplify partner_config.dart**

Edit `lib/features/ramp/widgets/partner_config.dart`:
- Simplify `getOnRampPartners` to always return `IList([RampPartner.brijRedirect])`
- Simplify `getOffRampPartners` to always return `IList([RampPartner.brijRedirect])`
- Remove all country constants
- Remove FeatureFlagsManager import and DI usage

**Step 3: Run build_runner**

Run: `make flutter_build`

**Step 4: Run analyzer**

Run: `make dart_analyze`

**Step 5: Commit**

```bash
git add -A && git commit -m "refactor: simplify RampPartner to only brijRedirect"
```

---

## Task 10: Remove Unused Dependencies (Optional)

Check for any packages that were only used by removed partners.

**Step 1: Check pubspec.yaml for stellar_flutter_sdk**

If `stellar_flutter_sdk` is no longer used anywhere, remove it from `pubspec.yaml`.

**Step 2: Run flutter pub get**

Run: `flutter pub get`

**Step 3: Run build and tests**

Run: `make flutter_build && make flutter_test`

**Step 4: Commit if changes made**

```bash
git add -A && git commit -m "chore: remove unused stellar_flutter_sdk dependency"
```

---

## Summary

Partners removed in order:
1. **Guardarian** - Widget only, simplest
2. **Kado** - Data, services, widgets
3. **Coinflow** - Data, services, widgets, link listener
4. **MoneyGram** - Data, services, widgets, Stellar integration, feature flags

Each partner removal is a separate commit for easy rollback if needed.
