import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sama_offices/app.dart';
import 'package:sama_offices/src/home/more/update_profile/updat_profile_view.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../../core/values/colors.dart';

import '../../../core/widget/TextWidget.dart';
import '../../auth/login/loginPage.dart';
import '../home_core.dart';
import '../resevition/reservation_view_model.dart';
import 'about_us/about_us_view.dart';
import 'contact_us/contact_us_view.dart';
import 'more_view_model_page.dart';

class MorePageScreen extends StatefulWidget {
  const MorePageScreen({Key? key}) : super(key: key);

  @override
  State<MorePageScreen> createState() => _MorePageScreenState();
}

class _MorePageScreenState extends MoreViewModelPage {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
            statusBarColor: samaOfficeColor,
            /* set Status bar color in Android devices. */
            statusBarIconBrightness: Brightness.light,
            /* set Status bar icons color in Android devices.*/
            statusBarBrightness:
                Brightness.light) /* set Status bar icon color in iOS. */
        );
    return Scaffold(
        backgroundColor: Colors.white,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.dark,
            child: Column(
              children: [
                Container(
                  color: samaOfficeColor,
                  width: size.width,
                  height: 100,
                  padding: const EdgeInsets.only(top: 60),
                  child:   TextWidget(
                      title: "More".tr(),
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                      textAlign: TextAlign.center),

                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [


                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                                    width: (size.width),
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: const Color(0XFFF5F9F9)),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            InkWell(
                                              onTap: (){
                                                BottomNavigationBar navigationBar =
                                                HomeCorePage.bottomWidgetKey.currentWidget
                                                as BottomNavigationBar;

                                                navigationBar.onTap!(0);
                                              },
                                              child: Container(
                                                width: (size.width / 2) - 50,
                                                padding: const EdgeInsets.all(10),
                                                height: 100,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(15),
                                                    color: const Color(0xFFEFEAF1)),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SvgPicture.asset(
                                                        "assets/images/orderss.svg",
                                                    color: profile,),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    TextWidget(
                                                        title: "ServiceRequests".tr(),
                                                        fontSize: 13,
                                                        fontWeight: FontWeight.bold,
                                                        color: const Color(0XFF2C3341),
                                                        textAlign: TextAlign.center),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: (){
                                                BottomNavigationBar navigationBar =
                                                HomeCorePage.bottomWidgetKey.currentWidget
                                                as BottomNavigationBar;

                                                navigationBar.onTap!(1);
                                              },
                                              child: Container(
                                                width: (size.width / 2) - 50,
                                                padding: const EdgeInsets.all(10),
                                                height: 100,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(15),
                                                    color: const Color(0xFFEFEAF1)),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SvgPicture.asset(
                                                        "assets/images/offd.svg",
                                                    color: profile,),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    TextWidget(
                                                        title: "PackageRequests".tr(),
                                                        fontSize: 13,
                                                        fontWeight: FontWeight.bold,
                                                        color: const Color(0XFF2C3341),
                                                        textAlign: TextAlign.center),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),

                                        ReservationsViewModel.profileModel!=null?
                                        Container(
                                          width: (size.width),
                                          padding: const EdgeInsets.all(10),
                                          height: 40,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(15),
                                              color: Colors.white),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              TextWidget(
                                                  title: "SubscriptionExpiryDate".tr(),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: const Color(0XFF2C3341),
                                                  textAlign: TextAlign.center),

                                              TextWidget(
                                                  title: ReservationsViewModel.profileModel!.office!.subscription_end_date.toString(),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: const Color(0XFF2C3341),
                                                  textAlign: TextAlign.center),
                                            ],
                                          ),
                                        )
                                        : const SizedBox.shrink() ,
                                        const SizedBox(
                                          height: 5,
                                        ),

                                      ],
                                    ),
                                  ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextWidget(
                                title: "SETTINGS".tr(),
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: const Color(0XFF9FA3B2),
                                textAlign: TextAlign.center),

                            InkWell(
                              onTap: (){
                                SamaOfficesApp.navKey.currentState!.push(
                                  MaterialPageRoute(builder: (context) => const UpdateProfile()),
                                );
                              },
                              child: Container(
                                width: (size.width),
                                padding: const EdgeInsets.all(10),
                                height: 55,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: const Color(0XFFF5F9F9)),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                            Icons.person_outline_outlined),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        TextWidget(
                                            title: "accountDetails".tr(),
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0XFF2C3341),
                                            textAlign: TextAlign.center),
                                      ],
                                    ),
                                    const Icon(Icons.arrow_forward_ios)
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(
                              height: 5,
                            ),
                            InkWell(
                              onTap: (){
                                dilog();
                            },
                              child: Container(
                                width: (size.width),
                                padding: const EdgeInsets.all(10),
                                height: 55,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: const Color(0XFFF5F9F9)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.language),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        TextWidget(
                                            title: "Language".tr(),
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0XFF2C3341),
                                            textAlign: TextAlign.center),
                                      ],
                                    ),
                                    const Icon(Icons.arrow_forward_ios)
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextWidget(
                                title: "REACHOUTTOUS".tr(),
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: const Color(0XFF9FA3B2),
                                textAlign: TextAlign.center),
                            const SizedBox(
                              height: 5,
                            ),
                            token != ""
                         ?   InkWell(
                              onTap: (){
                                SamaOfficesApp.navKey.currentState!.push(
                                  MaterialPageRoute(builder: (context) => const ContactUs()),
                                );
                              },
                              child: Container(
                                width: (size.width),
                                padding: const EdgeInsets.all(10),
                                height: 55,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: const Color(0XFFF5F9F9)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.mark_chat_read_outlined),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        TextWidget(
                                            title: "ConnectUs".tr(),
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0XFF2C3341),
                                            textAlign: TextAlign.center),
                                      ],
                                    ),
                                    const Icon(Icons.arrow_forward_ios)
                                  ],
                                ),
                              ),
                            )
                            :const SizedBox.shrink(),
                            const SizedBox(
                              height: 5,
                            ),
                            InkWell(
                              onTap: (){
                                MoreViewModelPage.typePage="0";
                                SamaOfficesApp.navKey.currentState!.push(
                                  MaterialPageRoute(builder: (context) => const AboutUs()),
                                );
                              },
                              child: Container(
                                width: (size.width),
                                padding: const EdgeInsets.all(10),
                                height: 55,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: const Color(0XFFF5F9F9)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.info_outline),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        TextWidget(
                                            title: "AboutUs".tr(),
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0XFF2C3341),
                                            textAlign: TextAlign.center),
                                      ],
                                    ),
                                    const Icon(Icons.arrow_forward_ios)
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            InkWell(
                              onTap: (){
                                MoreViewModelPage.typePage="1";
                                SamaOfficesApp.navKey.currentState!.push(
                                  MaterialPageRoute(builder: (context) => const AboutUs()),
                                );
                              },
                              child: Container(
                                width: (size.width),
                                padding: const EdgeInsets.all(10),
                                height: 55,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: const Color(0XFFF5F9F9)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.perm_device_info),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        TextWidget(
                                            title: "UsageInstructions".tr(),
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0XFF2C3341),
                                            textAlign: TextAlign.center),
                                      ],
                                    ),
                                    const Icon(Icons.arrow_forward_ios)
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            InkWell(
                              onTap: (){
                                MoreViewModelPage.typePage="2";
                                SamaOfficesApp.navKey.currentState!.push(
                                  MaterialPageRoute(builder: (context) => const AboutUs()),
                                );
                              },
                              child: Container(
                                width: (size.width),
                                padding: const EdgeInsets.all(10),
                                height: 55,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: const Color(0XFFF5F9F9)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.privacy_tip_outlined),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        TextWidget(
                                            title: "Privacy".tr(),
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0XFF2C3341),
                                            textAlign: TextAlign.center),
                                      ],
                                    ),
                                    const Icon(Icons.arrow_forward_ios)
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            token != ""
                                ? InkWell(
                              onTap: (){
                                logoutApp();
                              },
                                  child: Container(
                                      width: (size.width),
                                      padding: const EdgeInsets.all(10),
                                      height: 55,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
                                          color: const Color(0XFFF5F9F9)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              const Icon(Icons.delete_outline_outlined),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              TextWidget(
                                                  title: "DeleteAccount".tr(),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.red,
                                                  textAlign: TextAlign.center),
                                            ],
                                          ),
                                          const Icon(Icons.arrow_forward_ios)
                                        ],
                                      ),
                                    ),
                                )
                                : const SizedBox.shrink(),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    launchUrl(Uri.parse("https://wa.me/${MoreViewModelPage.settingsModel!.whats!}?text="));


                                  },
                                  icon:
                                  Image.asset("assets/images/whats.png",height: 23,),
                                ),
                                IconButton(
                                  onPressed: () {
                                    launchUrl(Uri.parse(
                                        MoreViewModelPage.settingsModel!.facebookUrl!));
                                  },
                                  icon:
                                      SvgPicture.asset("assets/images/facebook.svg"),
                                ),
                                IconButton(
                                    onPressed: () {
                                      launchUrl(Uri.parse(
                                          MoreViewModelPage.settingsModel!.snapchatUrl!));
                                    },
                                    icon: const Icon(Icons.snapchat)),
                                IconButton(
                                  onPressed: () {
                                    launchUrl(Uri.parse(
                                        MoreViewModelPage.settingsModel!.twitterUrl!));
                                  },
                                  icon: SvgPicture.asset("assets/images/twitter.svg"),
                                ),
                                IconButton(
                                  onPressed: () {
                                    launchUrl(Uri.parse(
                                        MoreViewModelPage.settingsModel!.instagramUrl!));
                                  },
                                  icon:
                                      SvgPicture.asset("assets/images/instagram.svg"),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            token != ""
                                ? Container(
                                    margin: const EdgeInsets.only(
                                        left: 30, right: 30, bottom: 50),
                                    child: TextButton(
                                      style: TextButton.styleFrom(
                                          fixedSize: Size(size.width, 55),
                                          shape: RoundedRectangleBorder(
                                            side:
                                                const BorderSide(color: samaOfficeColor),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          backgroundColor: samaOfficeColor),
                                      onPressed: () {
                                        logoutApp();
                                      },
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.exit_to_app_outlined,
                                            color: Colors.white,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            tr("Logout"),
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : const SizedBox.shrink()
                          ]),
                    ),
                  ),
                ),
              ],
            )));
  }
}
