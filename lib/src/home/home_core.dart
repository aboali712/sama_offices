import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:sama_offices/src/home/more/more_page_screen.dart';
import 'package:sama_offices/src/home/offer_books/reservation_offers_view.dart';
import 'package:sama_offices/src/home/offers/all/offers_page.dart';
import 'package:sama_offices/src/home/resevition/reservation_view.dart';


import '../../core/values/theme.dart';
import '../../core/widget/bottom_menu.dart';


class HomeCore extends StatefulWidget {
  static var model;
  static String type = "0";
  const HomeCore({Key? key}) : super(key: key);
  static LocationData? locationData;

  static String charityID = "";
  static String typeCate = "0";
  static ValueNotifier<int> counter = ValueNotifier<int>(0);



  @override
  HomeCorePage createState() => HomeCorePage();
}

class HomeCorePage extends State<HomeCore> {
  static int index = 0;
  static var bottomWidgetKey=GlobalKey<State<BottomNavigationBar>>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
            statusBarColor: Colors.white,
            /* set Status bar color in Android devices. */
            statusBarIconBrightness: Brightness.dark,
            /* set Status bar icons color in Android devices.*/
            statusBarBrightness:
                Brightness.dark) /* set Status bar icon color in iOS. */
        );
    Widget child = Container();
    switch (index) {
      case 0:
        child =  const ReservationPage();
        break;
      case 1:
        child =  const ReservationOffersPage();
        break;
      case 3:
        child =   const MorePageScreen();
        break;
      case 2:
        child =   const OffersPage();
        break;
    }
    return MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.of(context),
        home: Scaffold(
          body: AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle.dark, child: child),
          bottomNavigationBar: BottomMenu(
            bottomMenuIndex: index,
            onChanged: (newIndex) => setState(() => index = newIndex),
          ),
        ));
  }
}
