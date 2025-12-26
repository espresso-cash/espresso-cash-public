# Android 16KB Page Size Support Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Fix Android 16KB page size compatibility to pass Google Play Store requirements for apps targeting Android 15+ (mandatory from November 1, 2025).

**Architecture:** Update the Android NDK version to r28+ which compiles 16KB-aligned libraries by default, and upgrade Flutter dependencies that ship prebuilt native libraries with 16KB alignment issues.

**Tech Stack:** Flutter 3.38.3, Android Gradle Plugin 8.13.0, NDK r28 (28.2.13676358), Rive 0.14.0, sqlite3_flutter_libs 0.5.41+

---

## Background

Android 15 and ARMv9 devices now support 16KB memory page sizes (replacing the 4KB standard). Starting **November 1, 2025**, Google Play requires all apps targeting Android 15+ to support 16KB page alignment. The current app shows the error: "This app isn't 16 KB compatible. ELF alignment check failed."

### Root Cause Analysis

| Component | Current Version | Required Version | Status |
|-----------|----------------|------------------|--------|
| NDK | 27.0.12077973 | 28.2.13676358 | **Needs update** |
| AGP | 8.13.0 | 8.5.1+ | OK |
| Flutter | 3.38.3 | 3.32.8+ | OK |
| rive | 0.13.20 | 0.14.0+ | **Needs update** |
| sqlite3_flutter_libs | 0.5.40 | 0.5.25+ | OK (but upgrade recommended) |
| sentry_flutter | 9.7.0 | 8.11.0+ | OK |

### Key Issue

The `rive` package version 0.13.x ships prebuilt `librive_text.so` binaries compiled with 4KB page alignment. This cannot be fixed by NDK flags alone - the package must be upgraded to 0.14.0+ which includes 16KB-aligned prebuilt binaries.

---

## Task 1: Update NDK Version

**Files:**
- Modify: `packages/espressocash_app/android/app/build.gradle:44`

**Step 1: Modify build.gradle**

Change the NDK version from:
```groovy
ndkVersion "27.0.12077973"
```

To:
```groovy
ndkVersion "28.2.13676358"
```

**Step 2: Verify the change**

Run: `grep ndkVersion packages/espressocash_app/android/app/build.gradle`
Expected: `ndkVersion "28.2.13676358"`

---

## Task 2: Update Rive Dependency

**Files:**
- Modify: `packages/espressocash_app/pubspec.yaml:67`

**Step 1: Review breaking changes**

The Rive 0.14.0 release may have breaking API changes. Review:
- https://pub.dev/packages/rive/changelog

**Step 2: Update pubspec.yaml**

Change:
```yaml
rive: ^0.13.2
```

To:
```yaml
rive: ^0.14.0
```

**Step 3: Run flutter pub get**

Run: `cd packages/espressocash_app && flutter pub get`
Expected: Dependencies resolved successfully

**Step 4: Check for breaking changes in code**

Run: `cd packages/espressocash_app && flutter analyze`

If there are breaking changes, fix any Rive API usage errors before proceeding.

---

## Task 3: Update sqlite3_flutter_libs (Recommended)

**Files:**
- Modify: `packages/espressocash_app/pubspec.yaml:80`

**Step 1: Update pubspec.yaml**

Change:
```yaml
sqlite3_flutter_libs: ^0.5.18
```

To:
```yaml
sqlite3_flutter_libs: ^0.5.41
```

**Step 2: Run flutter pub get**

Run: `cd packages/espressocash_app && flutter pub get`
Expected: Dependencies resolved successfully

---

## Task 4: Bootstrap and Build

**Step 1: Run melos bootstrap**

Run: `melos bootstrap`
Expected: All packages bootstrapped successfully

**Step 2: Run code generation**

Run: `cd packages/espressocash_app && make flutter_build`
Expected: Code generation completes without errors

**Step 3: Build Android App Bundle**

Run: `cd packages/espressocash_app && flutter build appbundle --release`
Expected: App bundle builds successfully at `build/app/outputs/bundle/release/app-release.aab`

---

## Task 5: Verify 16KB Compatibility

**Step 1: Extract and check ELF alignment**

Run:
```bash
cd packages/espressocash_app
unzip -o build/app/outputs/bundle/release/app-release.aab -d /tmp/aab_extract
find /tmp/aab_extract -name "*.so" -exec sh -c 'echo "=== {} ===" && llvm-objdump -p {} 2>/dev/null | grep -A1 LOAD | head -4' \;
```

Expected: All LOAD segments should show `2**14` (16384) or higher alignment, not `2**12` (4096).

**Step 2: Use zipalign to verify (if building APK)**

If testing with APK:
```bash
cd packages/espressocash_app
flutter build apk --release
zipalign -c -P 16 -v 4 build/app/outputs/flutter-apk/app-release.apk
```

Expected: "Verification successful"

---

## Task 6: Test on 16KB Device/Emulator

**Option A: Android Studio Emulator**

1. Open Android Studio
2. Tools > SDK Manager > SDK Platforms > Show Package Details
3. Download "Google APIs Experimental 16 KB Page Size ARM 64 v8a" system image
4. Create AVD with this system image
5. Install and test the app

**Option B: Physical Device (Pixel 8/9)**

1. Enable Developer Options
2. Settings > System > Developer Options > "Boot with 16KB page size"
3. Reboot device
4. Install and test the app

**Step 1: Install the app**

Run: `flutter install`

**Step 2: Verify app launches and works**

Test these features that use native libraries:
- Rive animations (loading screens, buttons with animations)
- Database operations (saving/loading data)
- Camera scanning functionality

Expected: App runs without crashes or 16KB compatibility warnings.

---

## Task 7: Final Verification in Google Play Console

**Step 1: Upload to Google Play Console**

Upload the app bundle to Google Play Console (internal testing track).

**Step 2: Check App Bundle Explorer**

1. Go to Release > App Bundle Explorer
2. Select the uploaded bundle
3. Check for any 16KB alignment warnings

Expected: No warnings about 16KB native library alignment.

---

## Rollback Plan

If issues occur after deployment:

1. Revert NDK version to `27.0.12077973`
2. Revert rive to `^0.13.2`
3. Revert sqlite3_flutter_libs to `^0.5.18`

---

## References

- [Android 16KB Page Size Support](https://developer.android.com/guide/practices/page-sizes)
- [Flutter Issue #150168 - 16KB Page Sizes Support](https://github.com/flutter/flutter/issues/150168)
- [Flutter Issue #175022 - NDK Version Update](https://github.com/flutter/flutter/issues/175022)
- [Rive Flutter 16KB Fix](https://github.com/rive-app/rive-flutter/issues/524)
- [sqlite3_flutter_libs Changelog](https://pub.dev/packages/sqlite3_flutter_libs/changelog)
