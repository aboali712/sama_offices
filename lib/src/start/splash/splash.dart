import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sama_offices/app.dart';
import 'package:sama_offices/src/home/home_core.dart';

import '../../../core/auth_manager.dart';
import '../../../core/cash/storage.helper.dart';
import '../../../core/network/network_service.dart';
import '../../../core/values/colors.dart';
import '../../../core/values/dimens.dart';
import '../../auth/login/loginPage.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  SplashViewState createState() => SplashViewState();
}

class SplashViewState extends State<SplashView> with StorageHelper {
  final Dio dio = NetworkService.instance.dio;

  ValueNotifier<String> lang = ValueNotifier("ar");

  Future<void> controlToApp() async {
    await readAuthManager.fetchUserIsFirst();
    await Future.delayed(const Duration(seconds: 3));

    if (readAuthManager.isFirst == false) {
      if(readAuthManager.isLogin){
        SamaOfficesApp.navKey.currentState!.pushReplacement(
          MaterialPageRoute(builder: (context) =>  HomeCore()),);
      }else {
        SamaOfficesApp.navKey.currentState!.pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginPage()),);
      }
    } else {
      dilog();
    }
  }

  AuthenticationManager get readAuthManager =>
      context.read<AuthenticationManager>();

  @override
  void initState() {
    controlToApp();
    getLang().then((value) => setState(() {
          lang.value = value ?? "ar";
        }));
    super.initState();
  }

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
      backgroundColor:  const Color(0xFFf5f9f9),
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Center(
              child: SvgPicture.asset(
            'assets/images/login_logo.svg',
            width: size.width * .5,
          )),
          Positioned(
            bottom: 50,
              child: Text(tr("tourismOffices"),style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w500),))
        ],
      ),
    );
  }

  void dilog() {
    showModalBottomSheet(
        enableDrag: false,
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
            height: MediaQuery.of(context).size.height * 0.50,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(children: [
                SvgPicture.asset(
                  "assets/images/color_logo.svg",
                  width: 100,
                  height: 100,
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
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.shade300)),
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
                                    fontWeight: FontWeight.w600, fontSize: 16)),
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
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      lang.value = "en";
                    });
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.shade300)),
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
                                    fontWeight: FontWeight.w600, fontSize: 16)),
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
                        backgroundColor: samaColor,
                        fixedSize: const Size(200, 50),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(color: samaColor),
                          borderRadius: BorderRadius.circular(15),
                        )),
                    onPressed: () async {
                      await context.setLocale(Locale(lang.value));
                      await saveLang(lang.value);
                      await setFirst(false);

                      SamaOfficesApp.navKey.currentState!.pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                      );
                      print(lang.value);
                    },
                    child: Text(
                      tr("tracking"),
                      style: GoogleFonts.tajawal(
                          color: Colors.white,
                          fontSize: fontText,
                          fontWeight: FontWeight.w500),
                    ))
              ]),
            ),
          );
        });
    return null;
  }
}
