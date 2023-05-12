import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama_offices/app.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/values/colors.dart';
import '../../../chat/chat_page.dart';
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
        statusBarColor: Colors.black,
        /* set Status bar color in Android devices. */
        statusBarIconBrightness: Brightness.dark,
        /* set Status bar icons color in Android devices.*/
        statusBarBrightness: Brightness.dark));

    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  color: yellowColor,
                  width: size.width,
                  height: 100,
                  child: Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10, top: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              Icons.arrow_back_ios,
                              size: 20,
                              color: Colors.black,
                            ),
                          ),

                          Text(
                            tr("OrderDetails"),
                            style: GoogleFonts.tajawal(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            width: 50,
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
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
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${tr("orderNumber")} : ${bookingsModelDetails.id} ",
                                      style: GoogleFonts.tajawal(
                                          fontWeight: FontWeight.bold, fontSize: 13),
                                    ),
                                    Text(
                                      bookingsModelDetails.status == "pending"
                                          ? tr("Pending")
                                          : bookingsModelDetails.status == "accepted"
                                          ? tr("Accepted")
                                          : bookingsModelDetails.status ==
                                          "completed"
                                          ? tr("Completed")
                                          : bookingsModelDetails.status ==
                                          "canceled"
                                          ? tr(
                                          "Cancelled")
                                          :   bookingsModelDetails.status ==
                                          "inReview"
                                          ? tr(
                                          "Reviewing")
                                          : "",
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
                                      "${tr("OrderDate")} : ${DateFormat('MMM d, yyyy',"en").format(DateFormat('yyyy-MM-d',"en").parse(bookingsModelDetails.createdAt!))} ",
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
                                              const SizedBox(
                                                width: 4,
                                              ),
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
                                              const SizedBox(
                                                width: 4,
                                              ),
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
                        Container(
                          color: const Color(0xFFf5f9f9),
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    select = 1;
                                  });
                                },
                                child: Container(
                                  height: 40,
                                  width: size.width / 2 - 20,
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: select == 1
                                          ? yellowColor
                                          : const Color(0xFFf5f9f9)),
                                  alignment: AlignmentDirectional.center,
                                  child: Text(
                                    tr("TheApplicant'sInformation"),
                                    style: GoogleFonts.tajawal(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
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
                                  width: size.width / 2 - 20,
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: select == 2
                                          ? yellowColor
                                          : const Color(0xFFf5f9f9)),
                                  alignment: AlignmentDirectional.center,
                                  child: Text(
                                    tr("Services"),
                                    style: GoogleFonts.tajawal(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
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
                        select == 1
                            ? Container(
                                padding: const EdgeInsets.all(10.0),

                                decoration: BoxDecoration(
                                    color: const Color(0xFFf5f9f9),
                                    borderRadius: BorderRadius.circular(15)),
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(10.0),
                                      margin: const EdgeInsets.all(10),

                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(15)),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "${tr("userName")} : ",
                                                style: GoogleFonts.tajawal(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                "${bookingsModelDetails.user!.firstName ?? ""} ${bookingsModelDetails.user!.lastName ?? ""}",
                                                style: GoogleFonts.tajawal(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "${tr("Phone")} : ",
                                                style: GoogleFonts.tajawal(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                bookingsModelDetails.user!.phone ?? "",
                                                style: GoogleFonts.tajawal(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500),
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
                                              bookingsModelDetails.status == "inReview" ||
                                                  bookingsModelDetails.status == "accepted" ||
                                                  bookingsModelDetails.status == "processing"
                                            ?  TextButton(
                                                style: TextButton.styleFrom(
                                                    fixedSize: Size(size.width / 3, 40),
                                                    shape: RoundedRectangleBorder(
                                                      side: const BorderSide(
                                                          color: profile),
                                                      borderRadius:
                                                          BorderRadius.circular(10),
                                                    ),
                                                    backgroundColor: profile),
                                                onPressed: () async {
                                                  var    userModell=(await getUser())!;
                                                  var respnose = await FirebaseDatabase.instance
                                                      .ref("Chats")
                                                      .get();
                                                  for (var item in respnose.children) {


                                                    if ((item.children.first
                                                        .child("user")
                                                        .child("toUserId")
                                                        .value.toString() ==
                                                        bookingsModelDetails.userId.toString() &&
                                                        item.children.first
                                                            .child("user")
                                                            .child("id")
                                                            .value.toString() ==
                                                            userModell.office!.id.toString()) ||
                                                        (item.children.first
                                                            .child("user")
                                                            .child("id")
                                                            .value.toString() ==
                                                            bookingsModelDetails.userId.toString() &&
                                                            item.children.first
                                                                .child("user")
                                                                .child("toUserId")
                                                                .value.toString() ==
                                                                userModell.office!.id.toString())) {
                                                      if( (item.children.first
                                                          .child("user")
                                                          .child("id")
                                                          .value.toString() ==
                                                          bookingsModelDetails.userId.toString() &&
                                                          item.children.first
                                                              .child("user")
                                                              .child("toUserId")
                                                              .value.toString() ==
                                                              userModell.office!.id.toString())){
                                                        ChatPageState.UserToName = item.children.first
                                                            .child("user")
                                                            .child("name")
                                                            .value
                                                            .toString();
                                                        ChatPageState.UserToId = item.children.first
                                                            .child("user")
                                                            .child("id")
                                                            .value
                                                            .toString();
                                                        ChatPageState.UserToLogo = item.children.first
                                                            .child("user")
                                                            .child("photo")
                                                            .value
                                                            .toString();
                                                      }
                                                      else if(item.children.first
                                                          .child("user")
                                                          .child("toUserId")
                                                          .value.toString() ==
                                                          bookingsModelDetails.userId.toString() &&
                                                          item.children.first
                                                              .child("user")
                                                              .child("id")
                                                              .value.toString() ==
                                                              userModell.office!.id.toString()) {

                                                          ChatPageState.UserToName = item.children.first
                                                              .child("user")
                                                              .child("userName")
                                                              .value
                                                              .toString();
                                                          ChatPageState.UserToId = item.children.first
                                                              .child("user")
                                                              .child("toUserId")
                                                              .value
                                                              .toString();
                                                          ChatPageState.UserToLogo = item.children.first
                                                              .child("user")
                                                              .child("userLogo")
                                                              .value
                                                              .toString();

                                                      }

                                                      ChatPageState.groupChatId = item.key.toString();
                                                      SamaOfficesApp.navKey.currentState!
                                                          .push(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                            const ChatPage()),);
                                                      return;
                                                    }

                                                  }
                                                  ChatPageState.UserToName =    "${bookingsModelDetails.user!.firstName!} ${bookingsModelDetails.user!.lastName!}";
                                                  ChatPageState.UserToId =
                                                      bookingsModelDetails.user!.id.toString();
                                                  ChatPageState.UserToLogo =      bookingsModelDetails.user!.image!;
                                                  ChatPageState.groupChatId = DateTime.now()
                                                      .microsecondsSinceEpoch
                                                      .toString();
                                                  SamaOfficesApp.navKey.currentState!
                                                      .push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                        const ChatPage()),);
                                                },
                                                child: Text(
                                                  tr("Message"),
                                                  style: GoogleFonts.tajawal(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 13),
                                                ),
                                              )
                                              : const SizedBox(width: 120,),
                                              TextButton(
                                                style: TextButton.styleFrom(
                                                    fixedSize: Size(size.width / 3, 40),
                                                    shape: RoundedRectangleBorder(
                                                      side: const BorderSide(color: green),
                                                      borderRadius:
                                                          BorderRadius.circular(10),
                                                    ),
                                                    backgroundColor: green),
                                                onPressed: () {
                                                  launchUrl(Uri.parse(
                                                      "tel://${bookingsModelDetails.user!.phone!}"));
                                                },
                                                child: Text(
                                                  tr("Call"),
                                                  style: GoogleFonts.tajawal(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 13),
                                                ),
                                              ),
                                            ],
                                          ),







                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 50,),

                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(15)),
                                      padding: const EdgeInsets.all(10),
                                      margin: const EdgeInsets.all(10),

                                      child: Column(
                                        children: [
                                          const SizedBox(height: 10,),

                                          Text(tr("ChangeStatus"),style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w500),),
                                          const SizedBox(height: 10,),
                                          DropdownButtonFormField2(
                                            decoration: InputDecoration(
                                              hintText: tr("SubscriptionPlan"),
                                              hintStyle: GoogleFonts.tajawal(
                                                  fontSize: 12,
                                                  color: const Color.fromRGBO(196, 196, 196, 1)),
                                              errorStyle: const TextStyle(color: accentColor),
                                              contentPadding:
                                              const EdgeInsets.symmetric(vertical: 7.0, horizontal: 10.0),
                                              filled: true,
                                              fillColor: const Color(0xFFf5f9f9),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius: const BorderRadius.all(Radius.circular(8)),
                                                borderSide: BorderSide(width: 1, color: klightGray),
                                              ),
                                              disabledBorder: OutlineInputBorder(
                                                borderRadius: const BorderRadius.all(Radius.circular(8)),
                                                borderSide: BorderSide(width: .7, color: klightGray),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius: const BorderRadius.all(Radius.circular(8)),
                                                borderSide: BorderSide(
                                                  width: .7,
                                                  color: klightGray,
                                                ),
                                              ),
                                              border: const OutlineInputBorder(
                                                  borderRadius: BorderRadius.all(Radius.circular(8)),
                                                  borderSide: BorderSide(
                                                    width: 1,
                                                  )),
                                              errorBorder: const OutlineInputBorder(
                                                  borderRadius: BorderRadius.all(Radius.circular(8)),
                                                  borderSide: BorderSide(width: 0.7, color: accentColor)),
                                              focusedErrorBorder: const OutlineInputBorder(
                                                  borderRadius: BorderRadius.all(Radius.circular(8)),
                                                  borderSide: BorderSide(width: 0.7, color: accentColor)),
                                            ),
                                            items:
                                            listStatues
                                                .map((e) => e)
                                                .toList()
                                                .map((item) => DropdownMenuItem<String>(
                                              value: item,
                                              child: Text(
                                                item,
                                                style: GoogleFonts.tajawal(
                                                    fontSize: 14, color: Colors.black),
                                              ),
                                            ))
                                                .toList()
                                            ,
                                            value: selectStatus,
                                            onChanged: (value) {
                                              setState(() {
                                                selectStatus = value as String;

                                              });

                                            },
                                            buttonHeight: 40,
                                            buttonWidth: double.infinity,
                                            itemHeight: 40,
                                          ),
                                          const SizedBox(height: 30,),

                                          Center(
                                            child: TextButton(
                                                style: TextButton.styleFrom(
                                                    fixedSize: Size(size.width-100, 55),
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(10.0),
                                                        side: const BorderSide(
                                                            color: samaColor)),
                                                    backgroundColor: samaColor),
                                                onPressed: () {
                                                  changeStatusReservationsApi();
                                                },
                                                child: Text(
                                                  tr("Save"),
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.bold,
                                                      color:Colors.white),
                                                )),
                                          ),
                                          const SizedBox(height: 10,),

                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: bookingsModelDetails.services!
                                      .map((service) => Container(
                                          decoration: BoxDecoration(
                                            color: const Color(0XFFF5F9F9),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          margin: const EdgeInsets.all(5),
                                          padding: const EdgeInsets.all(5),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Center(
                                                      child: Container(
                                                        height: 25,
                                                        width: size.width,
                                                        color:
                                                            const Color(0xFFEFEAF1),
                                                        child: Center(
                                                          child: Text(
                                                            service.serviceId == 1
                                                                ? tr("Vises")
                                                                : service.serviceId ==
                                                                        2
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
                                                                "${tr("Nationality")} : ${service.nationalityTitle!}",
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
                                                                "${tr("Country")} : ${service.countryTitle!}",
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
                                                              service.attachments!
                                                                      .isNotEmpty
                                                                  ? SingleChildScrollView(
                                                                      child: Row(
                                                                        children: service
                                                                            .attachments!
                                                                            .map((e) =>
                                                                                InkWell(
                                                                                  onTap: (){
                                                                                    final imageProvider = Image.network(e).image;
                                                                                    showImageViewer(context, imageProvider, onViewerDismissed: () {

                                                                                    });
                                                                                  },
                                                                                  child: Padding(
                                                                                    padding: const EdgeInsets.all(5.0),
                                                                                    child: CachedNetworkImage(
                                                                                      imageUrl:
                                                                                          e,
                                                                                      height:
                                                                                          50,
                                                                                      width:
                                                                                          50,
                                                                                    ),
                                                                                  ),
                                                                                ))
                                                                            .toList(),
                                                                      ),
                                                                    )
                                                                  : const SizedBox
                                                                      .shrink()
                                                            ],
                                                          )
                                                        : service.serviceId == 2
                                                            ? Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    "${tr("From")} : ${service.startPlace!}",
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize: 13,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                  Text(
                                                                    "${tr("To")} : ${service.endPlace!}",
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize: 13,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                  Text(
                                                                    "${tr("receivedDate")} : ${service.startDate!}",
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize: 13,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                  Text(
                                                                    "${tr("DeliveryDate")} : ${service.startDate!}",
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize: 13,
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
                                                                        "${tr("HotelName")} : ${service.address!}",
                                                                        style: const TextStyle(
                                                                            color: Colors
                                                                                .black,
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight
                                                                                    .w500),
                                                                      ),
                                                                      const SizedBox(
                                                                        height: 5,
                                                                      ),
                                                                      Text(
                                                                        "${tr("EntryDate")} : ${service.startDate!}",
                                                                        style: const TextStyle(
                                                                            color: Colors
                                                                                .black,
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight
                                                                                    .w500),
                                                                      ),
                                                                      const SizedBox(
                                                                        height: 5,
                                                                      ),
                                                                      Text(
                                                                        "${tr("DeliveryDate")} : ${service.endDate!}",
                                                                        style: const TextStyle(
                                                                            color: Colors
                                                                                .black,
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight
                                                                                    .w500),
                                                                      ),
                                                                      const SizedBox(
                                                                        height: 5,
                                                                      ),
                                                                      Text(
                                                                        "${tr("Rooms")} : ${service.rooms!}",
                                                                        style: const TextStyle(
                                                                            color: Colors
                                                                                .black,
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight
                                                                                    .w500),
                                                                      ),
                                                                      const SizedBox(
                                                                        height: 5,
                                                                      ),
                                                                      Text(
                                                                        "${tr("guests")} : ${service.guests!}",
                                                                        style: const TextStyle(
                                                                            color: Colors
                                                                                .black,
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight
                                                                                    .w500),
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
                                                                                color: Colors
                                                                                    .black,
                                                                                fontSize:
                                                                                    14,
                                                                                fontWeight:
                                                                                    FontWeight.w500),
                                                                          ),
                                                                          const SizedBox(
                                                                            height: 5,
                                                                          ),
                                                                          Text(
                                                                            service.ticketClass! ==
                                                                                    "first"
                                                                                ? "${tr("TravelClass")} : ${tr("FirstClass")}"
                                                                                : service.ticketClass == "economy"
                                                                                    ? "${tr("TravelClass")} : ${tr("Economic")}"
                                                                                    : "${tr("TravelClass")} : ${tr("Business")}",
                                                                            style: const TextStyle(
                                                                                color: Colors
                                                                                    .black,
                                                                                fontSize:
                                                                                    14,
                                                                                fontWeight:
                                                                                    FontWeight.w500),
                                                                          ),
                                                                          const SizedBox(
                                                                            height: 5,
                                                                          ),
                                                                          service.ticketType ==
                                                                                  "multi_cities"
                                                                              ? SizedBox(
                                                                                  height:
                                                                                      (80 * double.parse(service.transits!.length.toString())),
                                                                                  child:
                                                                                      ListView.builder(
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
                                                                                  crossAxisAlignment:
                                                                                      CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    Text(
                                                                                      "${tr("From")} : ${service.startPlace!}",
                                                                                      style: GoogleFonts.tajawal(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
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
                                                                                      style: GoogleFonts.tajawal(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
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
                                                                                CrossAxisAlignment
                                                                                    .start,
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
                                                                              service.notes !=
                                                                                      null
                                                                                  ? Text(
                                                                                      "${tr("Notes")} : ${service.notes!}",
                                                                                      style: const TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
                                                                                    )
                                                                                  : const SizedBox.shrink(),
                                                                              service.attachments!.isNotEmpty
                                                                                  ? SingleChildScrollView(
                                                                                      child: Row(
                                                                                        children: service.attachments!
                                                                                            .map((e) =>    InkWell(
                                                                                          onTap: (){
                                                                                            final imageProvider = Image.network(e).image;
                                                                                            showImageViewer(context, imageProvider, onViewerDismissed: () {

                                                                                            });
                                                                                          },
                                                                                              child: Padding(
                                                                                                padding: const EdgeInsets.all(5.0),
                                                                                                child: CachedNetworkImage(
                                                                                                      imageUrl: e,
                                                                                                      height: 90,
                                                                                                      width: 90,
                                                                                                    ),
                                                                                              ),
                                                                                            ))
                                                                                            .toList(),
                                                                                      ),
                                                                                    )
                                                                                  : SizedBox.shrink()
                                                                            ],
                                                                          )
                                                                        : const SizedBox
                                                                            .shrink()
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )))
                                      .toList(),
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            isLoading
            ? const Center(child: CircularProgressIndicator(),)
                : const SizedBox.shrink()
          ],
        ));
  }
}
