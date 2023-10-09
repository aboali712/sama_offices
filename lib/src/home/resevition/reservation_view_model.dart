import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sama_offices/app.dart';
import 'package:sama_offices/src/auth/auth_model/user_model.dart';
import 'package:sama_offices/src/home/home_core.dart';
import 'package:sama_offices/src/home/resevition/model/get_bookings_model.dart';
import 'package:sama_offices/src/home/resevition/reservation_view.dart';

import '../../../main.dart';
import '../../auth/auth_model/auth_response.dart';
import '../is_office_subscribe_expired/ofice_subscribe_expired_view.dart';
import 'model/bookingreponse_reponse.dart';

abstract class ReservationsViewModel extends State<ReservationPage> {
  List<BookingsModel> reservation = [];

  int selectOrder = 1;
  bool isLoading = false;
  static UserModel? profileModel;

  DateTime date =DateTime.now();
  DateTime? valEnd;
  static bool? valDate;
  static  bool? valDateMinus5Days;

  static int pageVipExpired=0;
  DateTime? minus5Days;
  DateTime? minus4Days;
  DateTime? minus3Days;
  DateTime? minus2Days;
  DateTime? minus1Days;

  DateTime?birthday;
  DateTime? date2;

  static int? difference;

  @override
  void initState() {
    getProfileDate().then((value) => {
      valEnd = DateTime.parse("2023-10-09") ,
       print(profileModel!.office!.subscription_end_date.toString()),
      minus5Days = valEnd!.subtract(const Duration(days: 5)),


setState(() {

    difference = valEnd!.difference(date).inDays ;

    print(difference);

}),

        valDate = date.isBefore(valEnd!),

      valDateMinus5Days = date.isBefore(minus5Days!),


      print(valDateMinus5Days),

      if(valDateMinus5Days==false ){

          if(pageVipExpired==0){

           valDate==false?

             SamaOfficesApp.navKey.currentState!.pushReplacement(MaterialPageRoute(
              builder: (context) => const OfficeSubscribeView(),))

            :SamaOfficesApp.navKey.currentState!.push(MaterialPageRoute(
             builder: (context) => const OfficeSubscribeView(),))
            ,
            setState((){
              ReservationsViewModel.pageVipExpired=1;

            }),
          }


      },

    });


    getReservationsApi();
    // HomeCore.starCountRef!.child("counts").set("0");



    super.initState();
  }


  Future<void> getReservationsApi() async {
    Map<String, String> mp = {};
    setState(() {
      isLoading=true;
    });

    mp["type"] = "service";
    final response =
        await dio.get("v1/office/getReservations", queryParameters: mp);
    setState(() {
      isLoading=false;
    });
    var rs = BookingsResponse(response.data!);
    if (rs.status == 200) {
      setState(() {
        reservation = rs.data!;
      });
    }
  }



  Future<void> getProfileDate() async {
    final response = await dio.get("/v1/office/profile");
    var rs = AuthResponse(response.data!);
    if (rs.status == 200) {
      setState(() {
        profileModel = rs.data;
      });
    }
  }



}
