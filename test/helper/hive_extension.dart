// ignore_for_file: cascade_invocations

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveInit {
  static Future main(String path) async {
    /// Setup mock channel call for path provider or mac OS
    const channel = MethodChannel(
      'plugins.flutter.io/path_provider_macos',
    );
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      switch (methodCall.method) {
        case 'getApplicationDocumentsDirectory':
          return 'macos/$path';
        default:
      }
    });

    // await Hive.initFlutter();

    // //init db adapters
    // await UserSessionDbAdapter.init();
    // await AppSettingDbAdapter.init();
  }

  static Future dispose() async {
    await Hive.deleteFromDisk();
  }
}
