import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/values/colors.dart';
import '../more_view_model_page.dart';
import 'contact_us_view_model.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends ContactUsViewModel {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
            statusBarColor: samaColor,
            /* set Status bar color in Android devices. */
            statusBarIconBrightness: Brightness.light,
            /* set Status bar icons color in Android devices.*/
            statusBarBrightness:
                Brightness.light) /* set Status bar icon color in iOS. */
        );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [
        isLoading
        ? const Center(child: CircularProgressIndicator(),)
        :const SizedBox.shrink(),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Platform.isIOS
                  ? const SizedBox(
                      height: 45,
                    )
                  : const SizedBox(
                      height: 40,
                    ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell( onTap: () {
                    Navigator.pop(context);
                  },
                    child: Row(
                      children: [
                        SizedBox(width: 10,
                          child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(
                                Icons.arrow_back_ios,
                                color: Colors.black,
                              )),
                        ),
                        const SizedBox(width: 10,),

                        SvgPicture.asset(
                          "assets/images/logo.svg",height: 20,width: 20,

                        ),


                      ],
                    ),
                  ),
                  Text(tr("ConnectUs"),
                      style: GoogleFonts.tajawal(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black)),
                  const SizedBox(
                    width: 50,
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: SvgPicture.asset(
                          'assets/images/contact.svg',
                          width: 200,
                          height: 200,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        tr("GetTouch"),
                        style: GoogleFonts.tajawal(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 15),
                      ),
                      Container(
                        width: (size.width),
                        padding: const EdgeInsets.all(10),
                        height: 90,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: (){
                                launchUrl(Uri.parse(
                                    "tel://${MoreViewModelPage.settingsModel!.phone!}"));
                              },
                              child: Container(
                                width: (size.width / 2) - 30,
                                padding: const EdgeInsets.all(5),
                                height: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: const Color(0XFFFFF8E0)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Icon(
                                      Icons.call,
                                      color: Colors.black,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          tr("Phone"),
                                          style: GoogleFonts.tajawal(
                                              color: samaColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          MoreViewModelPage.settingsModel!.phone!??"",
                                          style: GoogleFonts.tajawal(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 10,),
                            InkWell(
                              onTap: (){
                                launchUrl(Uri.parse(
                                    "mailto:${MoreViewModelPage.settingsModel!.email!}"));
                              },
                              child: Container(
                                width: (size.width / 2) -30,
                                padding: const EdgeInsets.all(5),
                                height: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: const Color(0XFFFFF8E0)),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.email_outlined,
                                      color: Colors.black,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,

                                      children: [
                                        Text(
                                          tr("E-mail"),
                                          style: GoogleFonts.tajawal(
                                              color: samaColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          MoreViewModelPage.settingsModel!.email!,
                                          style: GoogleFonts.tajawal(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        tr("OrGetTouch"),
                        style: GoogleFonts.tajawal(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 15),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        tr("Subject"),
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 15),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          fillColor: const Color(0xFFf5f9f9),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(width: 1, color: klightGray),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(width: .7, color: klightGray),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
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
                              borderSide:
                                  BorderSide(width: 0.7, color: accentColor)),
                          focusedErrorBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                              borderSide:
                                  BorderSide(width: 0.7, color: accentColor)),
                          filled: true,
                          hintStyle:
                              const TextStyle(color: textGrayColor, fontSize: 15),
                          hintText: tr("TypeHere"),
                        ),
                        style: const TextStyle(color: Colors.black, fontSize: 15),
                        controller: controllerSubject,
                      ),
                      const SizedBox(
                        height: 13,
                      ),
                      Text(
                        tr("yourInquiry"),
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 15),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        focusNode: focusPhone,
                        minLines: 9,
                        maxLines: 12,
                        decoration: InputDecoration(
                          fillColor: const Color(0xFFf5f9f9),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(width: 1, color: klightGray),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(width: .7, color: klightGray),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
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
                              borderSide:
                                  BorderSide(width: 0.7, color: accentColor)),
                          focusedErrorBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                              borderSide:
                                  BorderSide(width: 0.7, color: accentColor)),
                          filled: true,
                          hintStyle:
                              const TextStyle(color: textGrayColor, fontSize: 15),
                          hintText: tr("TypeHere"),
                        ),
                        style: const TextStyle(color: Colors.black, fontSize: 15),
                        controller: controllerMessage,
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(left: 30, right: 30, bottom: 50,top: 30),
                        child: TextButton(
                          style: TextButton.styleFrom(
                              fixedSize: Size(size.width, 55),
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(color: samaOfficeColor),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              backgroundColor: samaOfficeColor),
                          onPressed: () {
                            getSettingsDataApi();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.send_to_mobile_outlined,
                                color: Colors.black,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                tr("Send"),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }

}
