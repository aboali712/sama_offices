
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sama_offices/src/home/offers/create/create_offer.dart';

import '../../../../app.dart';
import '../../../../core/values/colors.dart';
import '../detailsOffer/offer_details.dart';
import '../detailsOffer/offer_details_view_model.dart';
import '../update/update_offer_view_model.dart';
import 'offers_page_view_model.dart';

class OffersPage extends StatefulWidget {
  const OffersPage({Key? key}) : super(key: key);

  @override
  State<OffersPage> createState() => _OffersPageState();
}

class _OffersPageState extends OffersPageViewModel {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: yellowColor,
        /* set Status bar color in Android devices. */
        statusBarIconBrightness: Brightness.dark,
        /* set Status bar icons color in Android devices.*/
        statusBarBrightness: Brightness.dark));
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(children: [
          Column(
            children: [
              Container(
                color: yellowColor,
                height: 100,
                alignment: AlignmentDirectional.topCenter,
                padding: const EdgeInsets.only(top: 60),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  tr("Offers"),
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ),
              offerPageModel!=null
           ?   SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: offerPageModel!
                      .map((offer) => InkWell(
                    onTap: () {
                      UpdateOfferPageViewModel.offerModel = offer;

                      OfferDetailsViewModel.offerId =
                          offer.id.toString();
                      SamaOfficesApp.navKey.currentState!.push(
                        MaterialPageRoute(
                            builder: (context) =>
                            const OfferDetailsPage()),
                     );
                    },
                    child: Card(
                      elevation: .5,
                      child: Container(
                        width: size.width,
                        margin: const EdgeInsets.all(5),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  child: CachedNetworkImage(
                                    imageUrl: offer.image!,
                                    width: size.width,
                                    height: 200,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.all(
                                      4.0),
                                  child: SizedBox(
                                    width:
                                    (size.width) - 10,
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .spaceBetween,
                                      children: [

                                        Container(
                                          padding:
                                          const EdgeInsets
                                              .all(5),
                                          decoration: BoxDecoration(
                                              color:
                                              yellowColor,
                                              borderRadius:
                                              BorderRadius
                                                  .circular(
                                                  8)),
                                          child: Center(
                                            child: Text(
                                              offer.numOfDays! >
                                                  10
                                                  ? "${offer.numOfDays!} ${tr("Day")}"
                                                  : "${offer.numOfDays!} ${tr("Days")}",
                                              style: const TextStyle(
                                                  fontSize:
                                                  13,
                                                  fontWeight:
                                                  FontWeight
                                                      .bold,
                                                  color: Colors
                                                      .black),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Align(
                              alignment:
                              AlignmentDirectional
                                  .topStart,
                              child: Text(
                                offer.name!,
                                style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight:
                                    FontWeight.w600,
                                    color: Colors.black),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceBetween,
                              children: [
                                Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .end,
                                    crossAxisAlignment:
                                    CrossAxisAlignment
                                        .center,
                                    children: [
                                      SizedBox(
                                        height: 20,
                                        child: Text(
                                          "${offer.priceAfter!} ${tr("SAR")} ",
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight:
                                              FontWeight
                                                  .w600,
                                              color: Colors
                                                  .cyan),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 25,
                                        child: RichText(
                                            text: TextSpan(
                                                text: ' ',
                                                children: <
                                                    TextSpan>[
                                                  TextSpan(
                                                    text:
                                                    "${offer.priceBefore!} ${tr("SAR")} ",
                                                    style:
                                                    const TextStyle(
                                                      color: Colors
                                                          .black54,
                                                      fontSize:
                                                      14,
                                                      decoration:
                                                      TextDecoration
                                                          .lineThrough,
                                                    ),
                                                  )
                                                ])),
                                      )
                                    ]),
                                TextButton(
                                  style:
                                  TextButton.styleFrom(
                                      fixedSize:
                                      const Size(
                                          140, 40),
                                      shape:
                                      RoundedRectangleBorder(
                                        side: const BorderSide(
                                            color: Colors
                                                .grey),
                                        borderRadius:
                                        BorderRadius
                                            .circular(
                                            10),
                                      ),
                                      backgroundColor:
                                      Colors
                                          .transparent),
                                  onPressed: () {
                                    UpdateOfferPageViewModel.offerModel = offer;

                                    OfferDetailsViewModel.offerId =
                                        offer.id.toString();
                                    SamaOfficesApp.navKey.currentState!.push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                          const OfferDetailsPage()),
                                    );
                                  },
                                  child: Text(
                                    tr("MoreInfo"),
                                    style: const TextStyle(
                                        color: samaColor,
                                        fontWeight:
                                        FontWeight.bold,
                                        fontSize: 12),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ))
                      .toList(),
                ),
              )
              : const SizedBox.shrink(),
            ],
          ),

        offerPageModel!=null &&  offerPageModel!.isEmpty
          ? Container(
            alignment: AlignmentDirectional.center,
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 5),
            child: Column(
              children: [
                const SizedBox(height: 120,),
                SvgPicture.asset("assets/images/no_offers.svg"),
                const SizedBox(height: 20,),
                Text(tr("NoOffers"),style: const TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                const SizedBox(height: 10,),
                Text(tr("OfficesNoOffer"),style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),


              ],
            ),
          )
          :const SizedBox.shrink(),

          isLoading
          ? const Center(child: CircularProgressIndicator(),)
          :const SizedBox.shrink(),

          Positioned(
           bottom: 50,
            left: 50,
            right: 50,

            child:  Center(
              child: TextButton(
                  style: TextButton.styleFrom(
                      fixedSize: Size(size.width, 55),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(10.0),
                          side: const BorderSide(
                              color: profile)),
                      backgroundColor: profile),
                  onPressed: () {
                    SamaOfficesApp
                        .navKey.currentState!
                        .push(
                      MaterialPageRoute(
                          builder: (context) =>
                          const CreateOfferPage()),
                    );
                  },
                  child: Text(
                    tr("CreatePackage"),
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color:Colors.white),
                  )),
            ),
          )
        ]));
  }
}
