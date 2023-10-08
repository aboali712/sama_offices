import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:sama_offices/core/cash/storage.helper.dart';
import 'package:sama_offices/core/values/colors.dart';
import 'package:sama_offices/src/home/more/more_page_screen.dart';
import 'package:sama_offices/src/home/offer_books/reservation_offers_view.dart';
import 'package:sama_offices/src/home/offers/all/offers_page.dart';
import 'package:sama_offices/src/home/resevition/reservation_view.dart';
import 'package:upgrader/upgrader.dart';


import '../../core/utils/helper_manager.dart';
import '../../core/values/theme.dart';
import '../../core/widget/bottom_menu.dart';


class HomeCore extends StatefulWidget {
  static var model;
  static String type = "0";
  static LocationData? locationData;
  static DatabaseReference? starCountRef;
  static String count1="0";
  static String count2="0";


  static String charityID = "";
  static String typeCate = "0";
  static ValueNotifier<int> counter = ValueNotifier<int>(0);


  @override
  HomeCorePage createState() => HomeCorePage();
}

class HomeCorePage extends State<HomeCore> with StorageHelper {
  static int index = 0;
  static var bottomWidgetKey=GlobalKey<State<BottomNavigationBar>>();

  @override
  void initState() {
    getUser().then((user) => {
        HomeCore.starCountRef =
    FirebaseDatabase.instance.ref('offices/${user!.office!.id!.toString()}'),
        HomeCore.starCountRef!.onValue.listen((DatabaseEvent event) {
          setState(() {
            HomeCore.count2=event.snapshot.child("count_offers").value.toString();
            HomeCore.count1=event.snapshot.child("counts").value.toString();

          });

      })
    });

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
            statusBarColor: samaOfficeColor,
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
        home:UpgradeAlert(
          upgrader: Upgrader(
              showReleaseNotes: false,
              dialogStyle: Platform.isIOS ? UpgradeDialogStyle.cupertino : UpgradeDialogStyle.material,
              showLater: false,
              showIgnore: false,
              messages: MyUpgraderMessages()),
          child: Scaffold(
            body: AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle.dark, child: child),
            bottomNavigationBar: BottomMenu(
              bottomMenuIndex: index,
              onChanged: (newIndex) => setState(() => index = newIndex),
            ),
          ),
        ));
  }
}
