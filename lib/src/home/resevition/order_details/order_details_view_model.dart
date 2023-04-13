import 'package:flutter/cupertino.dart';
import 'package:sama_offices/src/home/resevition/model/get_bookings_model.dart';

import 'order_details_view.dart';

abstract class OrderDetailsViewModel extends State<OrderDetails>{

   BookingsModel bookingsModelDetails=BookingsModel();
  static BookingsModel bookingsModel=BookingsModel();
   int select=0;


  @override
  void initState() {
   setState(() {
     bookingsModelDetails=bookingsModel;
   });
    super.initState();
  }



}