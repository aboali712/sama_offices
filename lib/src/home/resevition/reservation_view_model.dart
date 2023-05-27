import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:sama_offices/src/home/home_core.dart';
import 'package:sama_offices/src/home/resevition/model/get_bookings_model.dart';
import 'package:sama_offices/src/home/resevition/reservation_view.dart';

import '../../../main.dart';
import 'model/bookingreponse_reponse.dart';

abstract class ReservationsViewModel extends State<ReservationPage> {
  List<BookingsModel> reservation = [];

  int selectOrder = 1;
  bool isLoading = false;

  @override
  void initState() {
    getReservationsApi();

    HomeCore.starCountRef!.child("counts").set("0");



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
}
