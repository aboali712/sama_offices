import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/values/colors.dart';
import '../reservation_view_model.dart';
import 'order_details_view_model.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({Key? key}) : super(key: key);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends OrderDetailsViewModel {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
               Align(
                alignment: AlignmentDirectional.centerEnd,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: InkWell(onTap: () {
                    Navigator.pop(context);
                  },
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${tr("orderNumber")} : ${bookingsModelDetails.id} ",
                            style: GoogleFonts.tajawal(
                                fontWeight: FontWeight.bold, fontSize: 13),
                          ),
                          Text(
                            bookingsModelDetails.status!,
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${tr("OrderDate")} : ${DateFormat('MMM d, yyyy ').format(DateFormat('yyyy-mm-dd').parse(bookingsModelDetails.createdAt!))} ",
                            style: GoogleFonts.tajawal(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                              color: const Color(0xff0E1740),
                            ),
                          ),
                          bookingsModelDetails.numOfServices == null
                              ? Row(
                                  children: [
                                    Text(
                                      tr("Service"),
                                      style: GoogleFonts.tajawal(
                                          fontSize: 13, color: Colors.grey),
                                    ),
                                    const SizedBox(width: 4,),
                                    Text(
                                      "0",
                                      style: GoogleFonts.tajawal(
                                          fontSize: 13, color: Colors.grey),
                                    ),
                                  ],
                                )
                              : Row(
                                  children: [
                                    Text(
                                      bookingsModelDetails.numOfServices!,
                                      style: GoogleFonts.tajawal(
                                          fontSize: 13, color: Colors.grey),
                                    ),
                                    const SizedBox(width: 4,),
                                    Text(
                                      tr("Service"),
                                      style: GoogleFonts.tajawal(
                                          fontSize: 13, color: Colors.grey),
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
                    ]),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        select = 1;
                      });
                    },
                    child: Container(
                      height: 40,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: select == 1 ? yellowColor : Colors.white),
                      alignment: AlignmentDirectional.center,
                      child: Text(
                        tr("TheApplicant'sInformation"),
                        style: GoogleFonts.tajawal(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        select = 2;
                      });
                    },
                    child: Container(
                      height: 40,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: select == 2 ? yellowColor : Colors.white),
                      alignment: AlignmentDirectional.center,
                      child: Text(
                        tr("Services"),
                        style: GoogleFonts.tajawal(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                   
                  




                ],
              ),
              select == 1
                  ? Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                "أسم المستخدم : ",
                                style: GoogleFonts.tajawal(
                                    fontSize: 12, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "${bookingsModelDetails.user!.firstName ?? ""} ${bookingsModelDetails.user!.lastName ?? ""}",
                                style: GoogleFonts.tajawal(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                "رقم الجوال : ",
                                style: GoogleFonts.tajawal(
                                    fontSize: 12, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                bookingsModelDetails.user!.phone ?? "",
                                style: GoogleFonts.tajawal(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                style: TextButton.styleFrom(
                                    fixedSize: Size(size.width / 4, 25),
                                    shape: RoundedRectangleBorder(
                                      side:
                                          const BorderSide(color: yellowColor),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    backgroundColor: yellowColor),
                                onPressed: () {},
                                child: Text(
                                  "مراسلة",
                                  style: GoogleFonts.tajawal(
                                      color: samaColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13),
                                ),
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                    fixedSize: Size(size.width / 4, 20),
                                    shape: RoundedRectangleBorder(
                                      side:
                                          const BorderSide(color: Colors.green),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    backgroundColor: Colors.green),
                                onPressed: () {},
                                child: Text(
                                  "أتصال",
                                  style: GoogleFonts.tajawal(
                                      color: samaColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )


                  : Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children:





                          bookingsModelDetails.services!.map((service) => Container(
                            decoration: BoxDecoration(
                              color: const Color(0XFFF5F9F9),
                              borderRadius:
                              BorderRadius.circular(10),),
                            margin: const EdgeInsets.all(5),
                            padding: const EdgeInsets.all(5),
                            child: Column(children: [

                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Container(
                                      height: 25,
                                      width:size.width,
                                      color: const Color(0xFFEFEAF1),
                                      child: Center(
                                        child: Text(
                                          service.serviceId == 1
                                              ? tr("Vises")
                                              : service.serviceId == 2
                                              ? tr("CarRent")
                                              : service.serviceId ==
                                              3
                                              ? tr(
                                              "HotelBookings")
                                              : service.serviceId ==
                                              4
                                              ? tr(
                                              "FlightTickets")
                                              : tr(
                                              "Licenses"),
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontWeight:
                                              FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  service.serviceId == 1
                                      ? Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,
                                    children: [
                                      Text(
                                        "${tr("Nationality")} : ${service
                                            .nationalityTitle!}",
                                        style: const TextStyle(
                                            color:
                                            Colors.black,
                                            fontSize: 14,
                                            fontWeight:
                                            FontWeight
                                                .w500),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "${tr("Country")} : ${service
                                            .countryTitle!}",
                                        style: const TextStyle(
                                            color:
                                            Colors.black,
                                            fontSize: 14,
                                            fontWeight:
                                            FontWeight
                                                .w500),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "${tr("Notes")} : ${service.notes!}",
                                        style: const TextStyle(
                                            color:
                                            Colors.black,
                                            fontSize: 14,
                                            fontWeight:
                                            FontWeight
                                                .w500),
                                      ),
                                      service.attachments!.isNotEmpty
                                          ? SingleChildScrollView(
                                        child: Row(
                                          children: service.attachments!.map((e) => CachedNetworkImage(imageUrl: e,height: 50,width: 50,)).toList(),
                                        ),
                                      )
                                          : const SizedBox.shrink()
                                    ],
                                  )
                                      : service.serviceId == 2
                                      ? Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,
                                    children: [
                                      Text(
                                        "${tr("From")} : ${service
                                            .startPlace!}",
                                        style: const TextStyle(
                                            color:
                                            Colors.black,
                                            fontSize:
                                            13,
                                            fontWeight:
                                            FontWeight
                                                .w500),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "${tr("To")} : ${service
                                            .endPlace!}",
                                        style: const TextStyle(
                                            color:
                                            Colors.black,
                                            fontSize:
                                            13,
                                            fontWeight:
                                            FontWeight
                                                .w500),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "${tr("receivedDate")} : ${service
                                            .startDate!}",
                                        style: const TextStyle(
                                            color:
                                            Colors.black,
                                            fontSize:
                                            13,
                                            fontWeight:
                                            FontWeight
                                                .w500),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "${tr("DeliveryDate")} : ${service
                                            .startDate!}",
                                        style: const TextStyle(
                                            color:
                                            Colors.black,
                                            fontSize:
                                            13,
                                            fontWeight:
                                            FontWeight
                                                .w500),
                                      ),
                                    ],
                                  )
                                      : service.serviceId == 3
                                      ? Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,
                                    children: [
                                      Text(
                                        "${tr("HotelName")} : ${service
                                                .address!}",
                                        style: const TextStyle(
                                            color:
                                            Colors.black,
                                            fontSize:
                                            14,
                                            fontWeight:
                                            FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "${tr("EntryDate")} : ${service
                                                .startDate!}",
                                        style: const TextStyle(
                                            color:
                                            Colors.black,
                                            fontSize:
                                            14,
                                            fontWeight:
                                            FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "${tr("DeliveryDate")} : ${service
                                                .endDate!}",
                                        style: const TextStyle(
                                            color:
                                            Colors.black,
                                            fontSize:
                                            14,
                                            fontWeight:
                                            FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "${tr("Rooms")} : ${service
                                                .rooms!}",
                                        style: const TextStyle(
                                            color:
                                            Colors.black,
                                            fontSize:
                                            14,
                                            fontWeight:
                                            FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "${tr("guests")} : ${service
                                                .guests!}",
                                        style: const TextStyle(
                                            color:
                                            Colors.black,
                                            fontSize:
                                            14,
                                            fontWeight:
                                            FontWeight.w500),
                                      ),
                                    ],
                                  )
                                      : service.serviceId ==
                                      4
                                      ? Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,
                                    children: [
                                      Text(
                                        service.ticketType! ==
                                            "go"
                                            ? "${tr("TicketType")} : ${tr("OneWay")}"
                                            : service.ticketType! == "go_back"
                                            ? "${tr("TicketType")} : ${tr("RoundTrip")}"
                                            : "${tr("TicketType")} : ${tr("MultipleCities")}",
                                        style: const TextStyle(
                                            color:
                                            Colors.black,
                                            fontSize:
                                            14,
                                            fontWeight:
                                            FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        height:
                                        5,
                                      ),
                                      Text(
                                        service.ticketClass! ==
                                            "first"
                                            ? "${tr("TravelClass")} : ${tr("FirstClass")}"
                                            : service.ticketClass == "economy"
                                            ? "${tr("TravelClass")} : ${tr("Economic")}"
                                            : "${tr("TravelClass")} : ${tr("Business")}",
                                        style: const TextStyle(
                                            color:
                                            Colors.black,
                                            fontSize:
                                            14,
                                            fontWeight:
                                            FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        height:
                                        5,
                                      ),
                                      service.ticketType ==
                                          "multi_cities"
                                          ? SizedBox(
                                        height: (80 * double.parse(service.transits!.length.toString())),
                                        child: ListView.builder(
                                          itemBuilder: (BuildContext context, int inex) {
                                            return Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  "${tr("From")} : ${service.transits![inex].startCity!}",
                                                  style: const TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  "${tr("To")} : ${service.transits![inex].endCity!}",
                                                  style: const TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  "${tr("DepartuareDate")} : ${service.transits![inex].startDate!}",
                                                  style: const TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  "${tr("ArrivalDate")} : ${service.transits![inex].endDate!}",
                                                  style: const TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                const DottedLine(
                                                  direction: Axis.horizontal,
                                                )
                                              ],
                                            );
                                          },
                                          itemCount: service.transits!.length,
                                        ),
                                      )
                                          : Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${tr("From")} : ${service.startPlace!}",
                                            style:  GoogleFonts.tajawal(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "${tr("To")} : ${service.endPlace!}",
                                            style: const TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "${tr("DepartuareDate")} : ${service.startDate!}",
                                            style: const TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "${tr("ArrivalDate")} : ${service.endDate!}",
                                            style:  GoogleFonts.tajawal(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          const DottedLine(
                                            direction: Axis.horizontal,
                                          )
                                        ],
                                      )
                                    ],
                                  )
                                      : service.serviceId ==
                                      5
                                      ? Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${tr("LicensesType")} : ${service.licenseType!}",
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        height:
                                        5,
                                      ),
                                      service.notes != null
                                          ? Text(
                                        "${tr("Notes")} : ${service.notes!}",
                                        style: const TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
                                      )
                                          : const SizedBox.shrink(),
                                      service.attachments!.isNotEmpty
                                          ? SingleChildScrollView(
                                        child: Row(
                                          children: service.attachments!.map((e) => CachedNetworkImage(imageUrl: e,height: 90,width: 90,)).toList(),
                                        ),
                                      )
                                          : SizedBox.shrink()
                                    ],
                                  )
                                      : const SizedBox
                                      .shrink()
                                ],
                              ),





                            ],)



                          )).toList(),







                      ),
                    )
            ],
          ),
        ));
  }
}
