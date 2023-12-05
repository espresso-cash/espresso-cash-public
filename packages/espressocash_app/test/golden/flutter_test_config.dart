import 'dart:async';

import 'package:dfunc/dfunc.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

Future<void> testExecutable(Func0<FutureOr<void>> testMain) =>
    GoldenToolkit.runWithConfiguration(
      () async {
        await loadAppFonts();

        return testMain();
      },
      config: GoldenToolkitConfiguration(
        enableRealShadows: true,
        defaultDevices: const [
          Device.phone,
          Device.iphone11,
        ],
      ),
    );
