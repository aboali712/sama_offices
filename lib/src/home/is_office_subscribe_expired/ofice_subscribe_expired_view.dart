import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sama_offices/app.dart';
import 'package:sama_offices/src/home/is_office_subscribe_expired/subscribtion_page/subscribtion_view_page.dart';

import '../../../../core/values/colors.dart';
import '../resevition/reservation_view_model.dart';
import 'is_office_subscribe_expired_viewmodel.dart';

class OfficeSubscribeView extends StatefulWidget {
  const OfficeSubscribeView({Key? key}) : super(key: key);

  @override
  State<OfficeSubscribeView> createState() => _OfficeSubscribeViewState();
}

class _OfficeSubscribeViewState extends OfficeSubscribeViewModel {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.white,
        /* set Status bar color in Android devices. */
        statusBarIconBrightness: Brightness.dark,
        /* set Status bar icons color in Android devices.*/
        statusBarBrightness:
        Brightness.dark) /* set Status bar icon color in iOS. */
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body:
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [


        const SizedBox(
          height: 40,
        ),

        Row(
          children: [
            ReservationsViewModel.valDate!=false?

            InkWell(onTap: () {
              Navigator.pop(context);
            },
              child: Row(
                children: [
                  InkWell(onTap: () {
                    Navigator.pop(context);

                  },child: const SizedBox(width: 10,
                      child: Icon(Icons.arrow_back_ios,size: 20,))),
                  const SizedBox(width: 10,),
                  SvgPicture.asset(
                    "assets/images/logo.svg",height: 20,width: 20,

                  ),

                ],
              ),
            )
         :    SvgPicture.asset(
             "assets/images/logo.svg",height: 20,width: 20,
         ),

            const SizedBox(width: 20,)

          ],
        ),





            Center(
              child: Column(
                children: [
                  const SizedBox(height: 110,),

                  Center(
                      child: SizedBox(width: 270,height: 250,
                        child: SvgPicture.asset(
                          "assets/images/pana.svg",fit: BoxFit.fill,
                        ),
                      )),
                  const SizedBox(height: 30,),


                  Text(tr(
                      ReservationsViewModel.difference==5?
                      tr("DearCustomer,ThereAre5DaysLeftUntilTheSubscriptionEnds")
                   :   ReservationsViewModel.difference==4?
                      tr("DearCustomer,ThereAre4DaysLeftUntilTheSubscriptionEnds")
                          :   ReservationsViewModel.difference==3?
                      tr("DearCustomer,ThereAre3DaysLeftUntilTheSubscriptionEnds")
                          :   ReservationsViewModel.difference==2?
                      tr("DearCustomer,ThereAre2DaysLeftUntilTheSubscriptionEnds")
                          :   ReservationsViewModel.difference==1?
                      tr("DearCustomer,ThereAre1DaysLeftUntilTheSubscriptionEnds")
                          :   ReservationsViewModel.difference==0?
                      tr("DearCustomer,TodayTheSubscriptionEnds")
                    : "DearCustomer,TheVipSubscriptionPeriodHasExpired"),style: const TextStyle(color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 13),)

                  ,
                  const SizedBox(height: 10,),

                  Text(tr("ToRenew"),style: const TextStyle(color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),),

                  const SizedBox(height: 30,),


              TextButton(
                style: TextButton.styleFrom(
                    fixedSize: const Size(260, 45),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    backgroundColor: samaOfficeColor),
                onPressed:
                     () {
                  SamaOfficesApp.navKey.currentState!.push(MaterialPageRoute(builder:
                      (context) => const SubscriptionPage(),));

                },
                child: Text(
                tr("ReNew"),
                  style:   const TextStyle(
                      color:  Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 15),
                ),
              )



                ],
              ),
            ),





      ]),
    ),);
  }
}
