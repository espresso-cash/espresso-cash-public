# Cleanup Unused Dependencies Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Remove unused pub dependencies, assets, localization strings, and config variables left over from partner cleanup.

**Architecture:** Sequential removal of dependencies starting with code changes (main.dart), then pubspec.yaml, then assets and localization strings. Build verification after each major change.

**Tech Stack:** Flutter/Dart, Melos, pubspec.yaml

---

## Summary of Unused Items

### Unused Pub Dependencies
| Package | Reason |
|---------|--------|
| `face_camera` | Only initialized in main.dart, never actually used |
| `camera` | Transitive dependency of face_camera, not directly imported |
| `sliver_tools` | Not imported anywhere in lib/ |
| `dart_jsonwebtoken` | Not imported anywhere in lib/ |
| `http` | Not imported anywhere (dio is used instead) |

### Unused Assets
| Path | Contents |
|------|----------|
| `assets/partners/moneygram/` | style.css (MoneyGram removed) |
| `assets/partners/coinflow/` | index.html, favicon.ico, manifest.json, static/ (Coinflow removed) |

### Unused Localization Strings
- MoneyGram related strings in `lib/l10n/intl_en.arb` (lines 779-866)

### Unused Config Variables (lib/config.dart)
| Variable | Line |
|----------|------|
| `tokenProgramRent` | 30 |
| `rampApiKey` | 56 |
| `playstoreName` | 63 |
| `appstoreId` | 64 |

---

## Task 1: Remove face_camera dependency

**Files:**
- Modify: `lib/main.dart:2,55`
- Modify: `pubspec.yaml:32`

**Step 1: Remove face_camera import and initialization from main.dart**

Remove line 2:
```dart
import 'package:face_camera/face_camera.dart';
```

Remove line 55:
```dart
  await FaceCamera.initialize();
```

**Step 2: Remove face_camera from pubspec.yaml**

Remove line 32:
```yaml
  face_camera: ^0.1.2
```

**Step 3: Commit**

```bash
git add lib/main.dart pubspec.yaml
git commit -m "$(cat <<'EOF'
chore: remove unused face_camera dependency

The face_camera package was only initialized but never actually used.
EOF
)"
```

---

## Task 2: Remove camera dependency

**Files:**
- Modify: `pubspec.yaml:17`

**Step 1: Remove camera from pubspec.yaml**

Remove line 17:
```yaml
  camera: ^0.11.1
```

**Step 2: Commit**

```bash
git add pubspec.yaml
git commit -m "$(cat <<'EOF'
chore: remove unused camera dependency

The camera package was not directly imported anywhere in the codebase.
EOF
)"
```

---

## Task 3: Remove sliver_tools dependency

**Files:**
- Modify: `pubspec.yaml:74`

**Step 1: Remove sliver_tools from pubspec.yaml**

Remove line 74:
```yaml
  sliver_tools: ^0.2.12
```

**Step 2: Commit**

```bash
git add pubspec.yaml
git commit -m "$(cat <<'EOF'
chore: remove unused sliver_tools dependency
EOF
)"
```

---

## Task 4: Remove dart_jsonwebtoken dependency

**Files:**
- Modify: `pubspec.yaml:21`

**Step 1: Remove dart_jsonwebtoken from pubspec.yaml**

Remove line 21:
```yaml
  dart_jsonwebtoken: ^2.14.0
```

**Step 2: Commit**

```bash
git add pubspec.yaml
git commit -m "$(cat <<'EOF'
chore: remove unused dart_jsonwebtoken dependency
EOF
)"
```

---

## Task 5: Remove http dependency

**Files:**
- Modify: `pubspec.yaml:50`

**Step 1: Remove http from pubspec.yaml**

Remove line 50:
```yaml
  http: ^1.1.2
```

**Step 2: Commit**

```bash
git add pubspec.yaml
git commit -m "$(cat <<'EOF'
chore: remove unused http dependency

The app uses dio for HTTP requests, http package was never used.
EOF
)"
```

---

## Task 6: Remove unused partner assets

**Files:**
- Delete: `assets/partners/moneygram/` (entire directory)
- Delete: `assets/partners/coinflow/` (entire directory)
- Modify: `pubspec.yaml:124-128` (asset references)

**Step 1: Delete moneygram assets directory**

```bash
rm -rf assets/partners/moneygram/
```

**Step 2: Delete coinflow assets directory**

```bash
rm -rf assets/partners/coinflow/
```

**Step 3: Remove asset references from pubspec.yaml**

Remove lines 124-128:
```yaml
    - assets/partners/moneygram/
    - assets/partners/coinflow/
    - assets/partners/coinflow/static/
    - assets/partners/coinflow/static/js/
    - assets/partners/coinflow/static/css/
```

**Step 4: Commit**

```bash
git add -A
git commit -m "$(cat <<'EOF'
chore: remove unused MoneyGram and Coinflow partner assets

These assets are no longer needed after the partner removal.
EOF
)"
```

---

## Task 7: Remove unused MoneyGram localization strings

**Files:**
- Modify: `lib/l10n/intl_en.arb`

**Step 1: Remove MoneyGram related localization entries**

Remove these entries from intl_en.arb:
- `continueToMoneygram` and `@continueToMoneygram`
- `bridgingText` and `@bridgingText`
- `moneygramInstructionText` and `@moneygramInstructionText`
- `viewMoneygramTransferInstructions` and `@viewMoneygramTransferInstructions`
- `openMoneygramIframeText` and `@openMoneygramIframeText`
- `moneygramCashAvailable` and `@moneygramCashAvailable`
- `moneygramPaymentMethodOnRamp` and `@moneygramPaymentMethodOnRamp`
- `moneygramPaymentMethodOffRamp` and `@moneygramPaymentMethodOffRamp`

**Step 2: Regenerate localization files**

```bash
make flutter_build
```

**Step 3: Commit**

```bash
git add lib/l10n/
git commit -m "$(cat <<'EOF'
chore: remove unused MoneyGram localization strings
EOF
)"
```

---

## Task 8: Remove unused config variables

**Files:**
- Modify: `lib/config.dart:30-39,56,63-64`

**Step 1: Remove tokenProgramRent variable and its comment (lines 30-39)**

Remove:
```dart
/// Currently, the rent cost is fixed at the genesis. However, it's anticipated
/// to be dynamic, reflecting the underlying hardware storage cost at the time.
/// So the price is generally expected to decrease as the hardware cost declines
/// as the technology advances.
///
/// For calculating **max** fee it's ok to use this hard-coded value,
/// since it's not expected to grow.
///
/// It's pre-calculated for `TokenProgram.neededAccountSpace = 165`.
const int tokenProgramRent = 2_039_280;
```

**Step 2: Remove rampApiKey variable (line 56)**

Remove:
```dart
const rampApiKey = String.fromEnvironment('RAMP_API_KEY');
```

**Step 3: Remove playstoreName and appstoreId variables (lines 63-64)**

Remove:
```dart
const playstoreName = 'com.pleasecrypto.flutter';
const appstoreId = '1559625715';
```

**Step 4: Commit**

```bash
git add lib/config.dart
git commit -m "$(cat <<'EOF'
chore: remove unused config variables

Remove tokenProgramRent, rampApiKey, playstoreName, and appstoreId
which are no longer used in the codebase.
EOF
)"
```

---

## Task 9: Run bootstrap and verify build

**Step 1: Run melos bootstrap**

```bash
cd /Users/justinenerio/Developer/ec/ec-public && melos bootstrap
```

**Step 2: Run dart analyze**

```bash
make dart_analyze
```

Expected: No new errors (existing DCM warning in olp_service.dart is pre-existing)

**Step 3: Run flutter build**

```bash
make flutter_build
```

Expected: Build succeeds

**Step 4: Run unused code check**

```bash
make flutter_check_unused_code
```

Expected: No new unused code warnings related to removed items

---

## Task 10: Final verification and commit summary

**Step 1: Review all changes**

```bash
git log --oneline -10
git diff HEAD~9 --stat
```

**Step 2: Verify app still works**

```bash
flutter run --debug
```

Test basic app launch and navigation.
