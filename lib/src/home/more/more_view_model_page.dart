import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../app.dart';
import '../../../core/cash/storage.helper.dart';
import '../../../core/values/colors.dart';
import '../../../core/values/dimens.dart';
import '../../../main.dart';
import '../../start/splash/splash.dart';
import '../home_core.dart';
import 'model/SettingsResponse.dart';
import 'model/setting_model.dart';
import 'more_page_screen.dart';

abstract class MoreViewModelPage extends State<MorePageScreen>
    with StorageHelper {
  String token = "";

  static SettingsModel? settingsModel;
  static String typePage = "0";
  ValueNotifier<String> lang = ValueNotifier("");

  @override
  void initState() {
    getToken().then((value) => setState(() {
          token = value!;
        }));
    getLang().then((value) => setState(() {
          lang.value = value!;
        }));
    getSettingsDataApi();
    super.initState();
  }

  Future<void> logoutApp() async {
    await saveToken("").then((value) async => {
          await saveToken(""),
          await Future.delayed(const Duration(seconds: 1)),
          SamaOfficesApp.navKey.currentState!
              .push(MaterialPageRoute(builder: (context) => const SplashView()))
        });
  }

  Future<void> getSettingsDataApi() async {
    final response = await dio.get("v1/settings");

    var rs = SettingsResponse(response.data!);
    if (rs.status == 200) {
      setState(() {
        settingsModel = rs.data;
      });
    }
  }

  void dilog() {
    showModalBottomSheet(
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30.0),
          ),
        ),
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.45,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/images/rel.svg",
                      width: 75,
                      height: 75,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 40, right: 40),
                      child: Align(
                        alignment: AlignmentDirectional.topStart,
                        child: Text(
                          tr("Select_Preferred_Language"),
                          style: const TextStyle(
                              fontSize: fontTextTitle,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          lang.value = "ar";
                        });
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width - 100,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0XFFF5F9F9),
                            border: Border.all(color: const Color(0XFFF5F9F9))),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.asset(
                                    "assets/images/flag.png",
                                    height: 30,
                                    width: 30,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text("العربية",
                                    style: GoogleFonts.tajawal(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16)),
                              ]),
                              ValueListenableBuilder(
                                valueListenable: lang,
                                builder: (_, v, __) => Container(
                                    height: 25,
                                    width: 25,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: lang.value == "ar"
                                            ? samaColor
                                            : Colors.white),
                                    child: const Icon(
                                      Icons.done,
                                      color: Colors.white,
                                      size: 19,
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          lang.value = "en";
                        });
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width - 100,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0XFFF5F9F9),
                            border: Border.all(color: const Color(0XFFF5F9F9))),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.asset(
                                    "assets/images/flagUsa.png",
                                    height: 30,
                                    width: 30,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text("English",
                                    style: GoogleFonts.tajawal(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16)),
                              ]),
                              ValueListenableBuilder(
                                valueListenable: lang,
                                builder: (_, v, __) => Container(
                                    height: 25,
                                    width: 25,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: lang.value == "en"
                                            ? samaColor
                                            : Colors.white),
                                    child: const Icon(
                                      Icons.done,
                                      color: Colors.white,
                                      size: 19,
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: yellowColor,
                            fixedSize: const Size(300, 50),
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(color: yellowColor),
                              borderRadius: BorderRadius.circular(15),
                            )),
                        onPressed: () async {
                          await context.setLocale(Locale(lang.value));
                          await saveLang(lang.value);
                          SamaOfficesApp.navKey.currentState!.pushReplacement(
                            MaterialPageRoute(builder: (context) => HomeCore()),
                          );
                        },
                        child: Text(
                          "متابعة",
                          style: GoogleFonts.tajawal(
                              color: Colors.black,
                              fontSize: fontText,
                              fontWeight: FontWeight.w500),
                        ))
                  ]),
            ),
          );
        });
  }
}
