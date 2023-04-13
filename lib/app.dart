
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sama_offices/src/start/splash/splash.dart';


import '../core/values/theme.dart';

class SamaOfficesApp extends StatefulWidget {
  static final navKey = GlobalKey<NavigatorState>();

  const SamaOfficesApp({Key? key}) : super(key: key);

  @override
  State<SamaOfficesApp> createState() => _SamaOfficesAppState();
}

class _SamaOfficesAppState extends State<SamaOfficesApp> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: SamaOfficesApp.navKey, // GlobalKey()
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.of(context),
        home: const SplashView());
  }

}
