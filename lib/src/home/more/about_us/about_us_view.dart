import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';


import '../../../../core/values/colors.dart';
import '../more_view_model_page.dart';
import 'about_us_view_model.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends AboutUsViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(children: [
          const SizedBox(
            height: 60,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                  )),
              Text(
                  MoreViewModelPage.typePage == "0"
                      ? tr("AboutUs")
                      : MoreViewModelPage.typePage == "2"

                          ? tr("Privacy")
                  : MoreViewModelPage.typePage == "3"
                  ? tr("UsageInstructions")
                          : tr("UsageInstructions"),
                  style: GoogleFonts.tajawal(
                      fontWeight: FontWeight.bold,  fontSize: Platform.isIOS ? 18 : 15)),
              const SizedBox(
                width: 25,
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Image.asset(
                      MoreViewModelPage.typePage == "0"
                          ? "assets/images/about.png"
                          : MoreViewModelPage.typePage == "2"
                              ? "assets/images/privacy.png"
                     :  MoreViewModelPage.typePage == "3"
                          ? "assets/images/terms.png"
                              : "assets/images/terms.png",
                      width: 200,
                      height: 200,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Align(
                    alignment: AlignmentDirectional.topStart,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Html(
                        data: MoreViewModelPage.typePage == "0"
                            ? MoreViewModelPage.settingsModel!.about!
                            : MoreViewModelPage.typePage == "2"
                                ? MoreViewModelPage.settingsModel!.privacy!
                            : MoreViewModelPage.typePage == "3"
                            ? MoreViewModelPage.settingsModel!.office_terms!
                                : MoreViewModelPage.settingsModel!.terms!,
                        customTextAlign: (_) => TextAlign.start,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
