import 'dart:io';
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:window_manager/window_manager.dart';

class AppManager {
  static late String _appName;
  static late String _buildVersion;
  static late String _appVersion;
  
  static Future<void> init() async {
    var info = await PackageInfo.fromPlatform();

    _buildVersion = info.buildNumber;
    _appVersion = info.version;
  }

  static void setAppName({required bool isDebug}){
    String type = isDebug ? "dev" : "prod";

    _appName = "Приложение просмотра расписания"
        " build $buildVersion $type";
  }

  static String get buildVersion {
    return _buildVersion;
  }

  static String get appVersion {
    return _appVersion;
  }

  static String get appName {
    return _appName;
  }

  static Future<void> initPlatformConfig() async {
    // if (Platform.isAndroid){
    //  later maybe never
    // }

    if (Platform.isWindows){
      await windowManager.ensureInitialized();

      WindowOptions windowOptions = WindowOptions(
        title: appName,
        center: true,
        maximumSize: const Size(1280, 720),
        minimumSize: const Size(1280, 720),
        skipTaskbar: false,
        titleBarStyle: TitleBarStyle.normal,
      );
      windowManager.waitUntilReadyToShow(windowOptions, () async {
        await windowManager.show();
        await windowManager.focus();
      });
    }
  }

  static void setPreferredLandscapeOrientation() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }
}