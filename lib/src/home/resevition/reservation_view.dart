import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
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
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            color: yellowColor,
            height: 100,
            alignment: AlignmentDirectional.topCenter,
            padding: const EdgeInsets.only(top: 60),
            width: MediaQuery.of(context).size.width,
            child: Text(
              tr("ServiceRequests"),
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            height: 50,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      selectOrder = 1;
                    });
                  },
                  child: Container(
                    height: 45,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: selectOrder == 1 ? yellowColor : Colors.white),
                    alignment: AlignmentDirectional.center,
                    child: Text(
                      tr("NewOrders"),
                      style: GoogleFonts.tajawal(
                        fontSize: 15,
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
                    height: 40,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: selectOrder == 2 ? yellowColor : Colors.white),
                    alignment: AlignmentDirectional.center,
                    child: Text(
                      tr("RequestsAreInProgress"),
                      style: GoogleFonts.tajawal(
                        fontSize: 15,
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
                  child: Container(
                    height: 40,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: selectOrder == 3 ? yellowColor : Colors.white),
                    alignment: AlignmentDirectional.center,
                    child: Text(
                      tr("CompletedOrders"),
                      style: GoogleFonts.tajawal(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
            !isLoading
              ? reservation
                      .where((element) => selectOrder == 1
                          ? element.status == "pending"
                          : selectOrder == 2
                              ? (element.status != "completed" &&
                                  element.status != "canceled" &&
                                  element.status != "pending")
                              : (element.status == "completed" ||
                                  element.status == "canceled"))
                      .isNotEmpty
                  ? Column(
                      children: reservation
                          .where((element) => selectOrder == 1
                              ? element.status == "pending"
                              : selectOrder == 2
                                  ? (element.status != "completed" &&
                                      element.status != "canceled" &&
                                      element.status != "pending")
                                  : (element.status == "completed" ||
                                      element.status == "canceled"))
                          .map((e) => Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.all(5),
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: const Color(0xffF5F9F9)),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                e.status == "pending"
                                                    ? tr("Pending")
                                                    : e.status == "accepted"
                                                        ? tr("Accepted")
                                                        : e.status ==
                                                                "completed"
                                                            ? tr("Completed")
                                                            : e.status ==
                                                                    "canceled"
                                                                ? tr(
                                                                    "Cancelled")
                                             :   e.status ==
                                                    "inReview"
                                                    ? tr(
                                                    "Reviewing")
                                                                : "",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 15,
                                                    color: e.status == "pending"
                                                        ? const Color(
                                                            0xFFEA3224)
                                                        : const Color(
                                                            0xFF00AE9F)),
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
                                                "${tr("OrderDate")} : ${DateFormat('MMM d, yyyy ').format(DateFormat('yyyy-MM-dd').parse(e.createdAt!))} ",
                                                style: GoogleFonts.tajawal(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 13,
                                                  color:
                                                      const Color(0xff0E1740),
                                                ),
                                              ),
                                              e.numOfServices == null
                                                  ? Row(
                                                      children: [
                                                        Text(
                                                          tr("Service"),
                                                          style: GoogleFonts
                                                              .tajawal(
                                                                  fontSize: 13,
                                                                  color: Colors
                                                                      .grey),
                                                        ),
                                                        const SizedBox(
                                                          width: 4,
                                                        ),
                                                        Text(
                                                          "0",
                                                          style: GoogleFonts
                                                              .tajawal(
                                                                  fontSize: 13,
                                                                  color: Colors
                                                                      .grey),
                                                        ),
                                                      ],
                                                    )
                                                  : Row(
                                                      children: [
                                                        Text(
                                                          e.numOfServices!,
                                                          style: GoogleFonts
                                                              .tajawal(
                                                                  fontSize: 13,
                                                                  color: Colors
                                                                      .grey),
                                                        ),
                                                        const SizedBox(
                                                          width: 4,
                                                        ),
                                                        Text(
                                                          tr("Service"),
                                                          style: GoogleFonts
                                                              .tajawal(
                                                                  fontSize: 13,
                                                                  color: Colors
                                                                      .grey),
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
                                          InkWell(
                                            onTap: () {
                                              OrderDetailsViewModel
                                                  .bookingsModel = e;

                                              SamaOfficesApp
                                                  .navKey.currentState!
                                                  .push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const OrderDetails()),
                                              );
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  tr("OrderDetails"),
                                                  style: GoogleFonts.tajawal(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 13,
                                                      color: const Color(
                                                          0xff5E2D77)),
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
                  : Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 5),
                      child: Column(
                        children: [
                          SvgPicture.asset("assets/images/empty_orders.svg"),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            tr("no_orders"),
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            tr("NoOrdersDesc"),
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    )
              : const Center(
                  child: CircularProgressIndicator(),
                )
        ]),
      ),
    );
  }
}
