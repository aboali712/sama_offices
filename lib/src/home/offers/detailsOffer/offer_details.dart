import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sama_offices/core/utils/helper_manager.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../../app.dart';
import '../../../../core/values/colors.dart';
import '../update/update_offer.dart';
import '../update/update_offer_view_model.dart';
import 'offer_details_view_model.dart';

class OfferDetailsPage extends StatefulWidget {
  const OfferDetailsPage({Key? key}) : super(key: key);

  @override
  State<OfferDetailsPage> createState() => _OfferDetailsPageState();
}

class _OfferDetailsPageState extends OfferDetailsViewModel {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.white,
        /* set Status bar color in Android devices. */
        statusBarIconBrightness: Brightness.dark,
        /* set Status bar icons color in Android devices.*/
        statusBarBrightness: Brightness.dark));

      return   Scaffold(
            backgroundColor: Colors.white,
            body: AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle.dark,
                child: Stack(
                  children: [
                 offerDetailsModel != null
                 ?   Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            CarouselSlider(
                              options: CarouselOptions(
                                  height: 300,
                                  aspectRatio: 16 / 9,
                                  viewportFraction: 1,
                                  initialPage: 0,
                                  enableInfiniteScroll: true,
                                  reverse: false,
                                  autoPlay: true,
                                  autoPlayInterval: const Duration(seconds: 3),
                                  autoPlayAnimationDuration:
                                      Duration(milliseconds: 800),
                                  autoPlayCurve: Curves.fastOutSlowIn,
                                  enlargeCenterPage: true,
                                  enlargeFactor: 0.3,
                                  scrollDirection: Axis.horizontal),
                              items: offerDetailsModel!.offerDetails!.images!
                                  .map((i) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return Container(
                                        height: 300,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: const BoxDecoration(
                                            color: Colors.transparent),
                                        child: FittedBox(
                                          fit: BoxFit.fill,
                                          child: CachedNetworkImage(
                                            imageUrl: i.image!,
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          ),
                                        ));
                                  },
                                );
                              }).toList(),
                            ),
                            Positioned(
                              top: 30,
                              child: Container(
                                width: size.width,
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        SamaOfficesApp.navKey.currentState!
                                            .pop(context);
                                      },
                                      child: Container(
                                          height: 40,
                                          width: 40,
                                          padding: const EdgeInsets.only(
                                              right: 8, left: 5),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: const Center(
                                            child: Icon(
                                              Icons.arrow_back_ios,
                                              color: Colors.black,
                                              size: 22,
                                            ),
                                          )),
                                    ),
                                    const SizedBox(
                                      width: 56,
                                    ),

                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 10,
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                margin: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: yellowColor,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Center(
                                  child: Text(
                                    offerDetailsModel!
                                                .offerDetails!.numOfDays! >
                                            10
                                        ? "${offerDetailsModel!.offerDetails!.numOfDays!} ${tr("Day")}"
                                        : "${offerDetailsModel!.offerDetails!.numOfDays!} ${tr("Days")}",
                                    style: TextStyle(
                                        fontSize: Platform.isIOS ? 18 : 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      padding: const EdgeInsets.all(10),
                                      width: size.width,
                                      decoration: const BoxDecoration(
                                          color: Color(0xFFF5F9F9)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            offerDetailsModel!
                                                .offerDetails!.name!,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  height: 20,
                                                  child: Text(
                                                    "${offerDetailsModel!.offerDetails!.priceAfter!} ${tr("SAR")} ",
                                                    style: const TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.cyan),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 25,
                                                  child: RichText(
                                                      text: TextSpan(
                                                          text: ' ',
                                                          children: <TextSpan>[
                                                        TextSpan(
                                                          text:
                                                              "${offerDetailsModel!.offerDetails!.priceBefore!} ${tr("SAR")} ",
                                                          style:
                                                              const TextStyle(
                                                            color:
                                                                Colors.black54,
                                                            fontSize: 14,
                                                            decoration:
                                                                TextDecoration
                                                                    .lineThrough,
                                                          ),
                                                        )
                                                      ])),
                                                )
                                              ]),
                                          Row(
                                            children: [
                                              Container(
                                                width: 70.0,
                                                height: 70.0,
                                                decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xff7c94b6),
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                        offerDetailsModel!
                                                            .offerDetails!
                                                            .officeImage!),
                                                    fit: BoxFit.cover,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              40.0)),
                                                  border: Border.all(
                                                    color: yellowColor,
                                                    width: 1.0,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    tr("by"),
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 13),
                                                  ),
                                                  Text(
                                                    offerDetailsModel!
                                                        .offerDetails!
                                                        .officeName!,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 14),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ],
                                      )),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  ExpansionTile(
                                    backgroundColor: const Color(0xFFF5F9F9),
                                    collapsedBackgroundColor:
                                        const Color(0xFFF5F9F9),
                                    title: Text(
                                      tr("Details"),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15),
                                    ),
                                    children: [
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional.topStart,
                                        child: SizedBox(
                                          width: size.width,
                                          child: Html(

                                          data:  offerDetailsModel!
                                                .offerDetails!.description!.nonBreaking,
                                            style: {
                                              'div': Style(textAlign: TextAlign.start),
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 100,
                                  ),

                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                    : const Center(child: CircularProgressIndicator(),),
                    Align(
                      alignment: AlignmentDirectional.bottomCenter,
                      child: Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton(
                                style: TextButton.styleFrom(
                                    fixedSize:  Size(size.width/2-20, 55),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10)),
                                    backgroundColor: yellowColor),
                                onPressed: () {
                                  SamaOfficesApp.navKey.currentState!.push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                          const UpdateOfferPage()),).then((value) => getOfferDetailsApi());

                                },
                                child: Text(
                                  tr("EditOffer"),
                                  style: const TextStyle(
                                      color: samaColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                              ),
                              SizedBox(
                                height: 50,
                                child: ToggleSwitch(
                                  minWidth: size.width/3.5-20,
                                  cornerRadius: 10,
                                  activeBgColors: const [[greenBlueIconColor],[errColor]],
                                  activeFgColor: Colors.white,
                                  inactiveBgColor: grayColor,
                                  inactiveFgColor: Colors.black,
                                  initialLabelIndex: index,
                                  totalSwitches: 2,
                                  labels: [tr("Active"), tr("Inactive")],
                                  radiusStyle: true,
                                  onToggle: (index) {

                                    changeOfferApi( offerDetailsModel!.offerDetails!.status=="active" ? "inactive":"active");


                                  },
                                ),
                              ),
                            ],
                          )),
                    ),
                    isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : const SizedBox.shrink()
                  ],
                )));

  }
}
