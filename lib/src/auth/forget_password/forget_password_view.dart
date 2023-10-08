
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama_offices/app.dart';

import '../../../core/utils/input_validators.dart';
import '../../../core/values/colors.dart';
import '../../../core/widget/phone_number_widget.dart';
import '../login/loginPage.dart';
import 'forget_password_view_model.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends ForgetPasswordViewModel {
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


      body :Stack(
        children: [
          Container(
            width: size.width,
            height: size.height / 4,
            color: samaOfficeColor,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  InkWell(onTap: (){
                    Navigator.pop(context);
                  },
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const SizedBox(height: 10,),

                  Text(
                    tr("ForgotYourPassword"),
                    style: GoogleFonts.tajawal(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    tr("PleaseEnterTheMobileNumber"),
                    style: GoogleFonts.tajawal(
                        color: Colors.white70,
                        fontWeight: FontWeight.w500,
                        fontSize: 15),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            margin: EdgeInsets.only(
                top: size.height - (size.height / 1.2), left: 10, right: 10),
            height: size.height - (size.height / 3),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            child: Flex(direction: Axis.horizontal, children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Center(
                          child: SvgPicture.asset(
                            'assets/images/login_logo.svg',
                            width: 120,
                            height: 120,color: samaOfficeColor,
                          ),
                        ),
                        const SizedBox(height: 50,),

                        Text(
                          tr("Phone"),
                          style:  GoogleFonts.tajawal(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 15),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        PhoneNumberSignUpWidget(
                          isPhone: isPhone,
                          focusNode: focusPhone,
                          hintText: tr("EnterMobile"),
                          onChanged: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                !InputValidators().phoneNumberValidator(
                                    phoneNumber: "20$value", context: context)) {
                              setState(() {
                                // phoneValidation = true;
                                isPhone = false;
                                phoneNumber = value!;
                              });
                            } else {
                              setState(() {
                                // phoneValidation = false;
                                isPhone = true;
                                phoneNumber = value;
                              });
                            }
                          },
                          onSaved: (value) {
                            phoneNumber = value!;
                          },
                        ),
                        const SizedBox(height: 70,),


                        TextButton(
                            style: TextButton.styleFrom(
                                fixedSize: Size(size.width, 55),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: const BorderSide(
                                        color: samaOfficeColor)),
                                backgroundColor:samaOfficeColor),
                            onPressed: () {
                              checkForgetPassword();
                            },
                            child: Text(
                              tr("SubmitVerificationCode"),
                              style: GoogleFonts.tajawal(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                              ),
                            )),

                        const SizedBox(height: 50,),
                        Center(
                          child: Text(
                            tr("You already have an account"),
                            style: GoogleFonts.tajawal(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: TextButton(
                              onPressed: () {

                                SamaOfficesApp.navKey.currentState!.push(
                                    MaterialPageRoute(builder: (context) => const LoginPage()));
                              },
                              child: Text(
                                tr("Login"),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              )),
                        ),



                      ] ),
                ),
              )]),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 1,
            child: Center(
                child:isloading==true? const CircularProgressIndicator(): const SizedBox.shrink()
            ),
          )
        ],
      ),


    );
  }
}
