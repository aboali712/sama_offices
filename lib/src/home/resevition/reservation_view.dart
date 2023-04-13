import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama_offices/src/home/resevition/model/get_bookings_model.dart';
import 'package:sama_offices/src/home/resevition/reservation_view_model.dart';

import '../../../app.dart';
import '../../../core/values/colors.dart';
import 'order_details/order_details_view.dart';
import 'order_details/order_details_view_model.dart';

class ReservationPage extends StatefulWidget {
  const ReservationPage({Key? key}) : super(key: key);

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends ReservationsViewModel {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.white,
        /* set Status bar color in Android devices. */
        statusBarIconBrightness: Brightness.dark,
        /* set Status bar icons color in Android devices.*/
        statusBarBrightness: Brightness.dark));
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      selectOrder = 1;
                    });
                  },
                  child: Container(
                    height: 40,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: selectOrder == 1 ? yellowColor : Colors.white),
                    alignment: AlignmentDirectional.center,
                    child: Text(
                      tr("NewOrders"),
                      style: GoogleFonts.tajawal(
                        fontSize:  selectOrder == 1? 13 :12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      selectOrder = 2;
                    });
                  },
                  child: Container(
                    height: 40, padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: selectOrder == 2 ? yellowColor : Colors.white),
                    alignment: AlignmentDirectional.center,

                    child: Text(
                      tr("RequestsAreInProgress"),
                      style: GoogleFonts.tajawal(
                        fontSize:  selectOrder == 2? 12 :12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      selectOrder = 3;
                    });
                  },
                  child: Container(height: 40,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: selectOrder == 3 ? yellowColor : Colors.white),
                    alignment: AlignmentDirectional.center,
                    child: Text(
                      tr("CompletedOrders"),
                      style: GoogleFonts.tajawal(
                        fontSize:  selectOrder == 3? 13 :12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              children: reservation
                  .map((e) => Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(5),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: const Color(0xffF5F9F9)),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${tr("orderNumber")} : ${e.id} ",
                                        style: GoogleFonts.tajawal(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13),
                                      ),


                                      Text(
                                        e.status!,
                                        style: GoogleFonts.tajawal(
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xff53AAA8)),
                                      ),

                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [

                                  Text(
                                  "${tr("OrderDate")} : ${DateFormat('MMM d, yyyy ').format(DateFormat('yyyy-mm-dd').parse(e.createdAt!))} ",
                style: GoogleFonts.tajawal(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: const Color(0xff0E1740),
                ),
              ),


                                      e.numOfServices == null
                                          ? Row(
                                              children: [
                                                Text(
                                                  tr("Service"),
                                                  style: GoogleFonts.tajawal(
                                                      fontSize: 13,
                                                      color: Colors.grey),
                                                ),
                                                const SizedBox(width: 4,),
                                                Text(
                                                  "0",
                                                  style: GoogleFonts.tajawal(
                                                      fontSize: 13,
                                                      color: Colors.grey),
                                                ),
                                              ],
                                            )
                                          : Row(
                                              children: [
                                                Text(
                                                  e.numOfServices!,
                                                  style: GoogleFonts.tajawal(
                                                      fontSize: 13,
                                                      color: Colors.grey),
                                                ),
                                                const SizedBox(width: 4,),
                                                Text(
                                                  tr("Service"),
                                                  style: GoogleFonts.tajawal(
                                                      fontSize: 13,
                                                      color: Colors.grey),
                                                ),

                                              ],
                                            ),

                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  SizedBox(
                                      child: Divider(
                                    thickness: 1,
                                    color: Colors.grey.shade300,
                                  )),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  InkWell(onTap: () {
                                    OrderDetailsViewModel.bookingsModel = e  ;


                                    SamaOfficesApp.navKey.currentState!.push(
                                      MaterialPageRoute(builder: (context) => const OrderDetails()),
                                    );

                                  },
                                    child: Row(mainAxisAlignment: MainAxisAlignment.end,
                                      children: [

                                        Text(
                                          tr("OrderDetails"),
                                          style: GoogleFonts.tajawal(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 13,
                                              color: const Color(0xff5E2D77)),
                                        ),
                                        const Icon(
                                          Icons.arrow_forward_ios,
                                          size: 17,
                                          color: Color(0xff5E2D77),
                                        ),

                                      ],
                                    ),
                                  ),
                                ]),
                          ),
                          const SizedBox(
                            height: 5,
                          )
                        ],
                      ))
                  .toList(),
            )
          ]),
        ),
      ),
    );
  }
}
