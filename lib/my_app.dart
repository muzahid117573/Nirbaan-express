import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_theme.dart';
import 'package:fuodz/services/app.service.dart';
import 'package:fuodz/views/pages/splash.page.dart';
import 'package:fuodz/services/auth.service.dart';
import 'constants/app_strings.dart';
import 'package:fuodz/services/router.service.dart' as router;

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    return AdaptiveTheme(
      light: AppTheme().lightTheme(),
      dark: AppTheme().darkTheme(),
      initial: AdaptiveThemeMode.system,
      builder: (theme, darkTheme) {
        return MaterialApp(
          navigatorKey: AppService().navigatorKey,
          debugShowCheckedModeBanner: false,
          title: AppStrings.appName,
          onGenerateRoute: router.generateRoute,
          home: SplashPage(),
          theme: theme,
          darkTheme: darkTheme,
        );
      },
    );
  }
}
