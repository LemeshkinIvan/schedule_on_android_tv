import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tv_shedule/ui/providers.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';
import 'package:tv_shedule/utils/app_manager.dart';

import 'common/routes/routes.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  FlutterNativeSplash.remove();

  await AppManager.init();
  AppManager.setAppName(isDebug: true);
  await AppManager.initPlatformConfig();
  AppManager.setPreferredLandscapeOrientation();

  runApp(
    MultiProvider(providers: providers, child: const TvSchedule(),)
  );
}

class TvSchedule extends StatelessWidget {
  const TvSchedule({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      designSize: const Size(375, 812),
      builder: (context, child) => MaterialApp.router(
        title: AppManager.appName,
        supportedLocales: const [Locale('en'), Locale('ru')],
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          SfGlobalLocalizations.delegate,
        ],
        theme: ThemeData(
            useMaterial3: false,
            inputDecorationTheme:
            const InputDecorationTheme(border: InputBorder.none),
            brightness: Brightness.light,
            fontFamily: 'Montserrat'
        ),
        routerConfig: NavigationRouter().router,
      )
    );
  }
}