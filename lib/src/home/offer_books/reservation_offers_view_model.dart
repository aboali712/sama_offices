import 'package:flutter/cupertino.dart';
import 'package:sama_offices/src/home/offer_books/reservation_offers_view.dart';
import 'package:sama_offices/src/home/resevition/model/get_bookings_model.dart';

import '../../../main.dart';
import '../home_core.dart';
import '../resevition/model/bookingreponse_reponse.dart';

abstract class ReservationsOffersViewModel extends State<ReservationOffersPage> {
  List<BookingsModel> reservation = [];

  int selectOrder = 1;
  bool isLoading = false;

  @override
  void initState() {
    getReservationsApi();
    HomeCore.starCountRef!.child("count_offers").set("0");

    super.initState();
  }

  Future<void> getReservationsApi() async {
    Map<String, String> mp = {};
    setState(() {
      isLoading=true;
    });

    mp["type"] = "offer";
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
