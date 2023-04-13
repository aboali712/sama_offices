import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sama_offices/src/auth/signup/sinup_view.dart';

import '../../../app.dart';
import '../../../core/utils/input_validators.dart';
import '../../../core/values/colors.dart';
import '../../../core/widget/phone_number_widget.dart';

import '../../home/home_core.dart';
import '../forget_password/forget_password_view.dart';
import 'loginViewModel.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends LoginViewModel {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: samaColor,
        /* set Status bar color in Android devices. */
        statusBarIconBrightness: Brightness.dark,
        /* set Status bar icons color in Android devices.*/
        statusBarBrightness:
        Brightness.dark) /* set Status bar icon color in iOS. */
    );

    return Scaffold(
        backgroundColor: Colors.white,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.dark,
            child: Stack(
              children: [
                Container(
                  height: size.height / 3.5,
                  color: yellowColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Platform.isIOS
                          ? const SizedBox(
                        height: 60,
                      )
                          : const SizedBox(
                        height: 40,
                      ),

                      Center(
                        child: SvgPicture.asset(
                          'assets/images/login_logo.svg',
                          width: size.width * .35,
                          color: samaColor,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),

                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  margin: EdgeInsets.only(
                      top: size.height - (size.height / 1.3),
                      left: 10,
                      right: 10),
                  height: size.height - (size.height / 2.6),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: Flex(direction: Axis.horizontal,
                      children: [ Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Text(
                                tr("Phone"),
                                style: const TextStyle(
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
                                          phoneNumber: "20$value",
                                          context: context)) {
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

                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                tr("Password"),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                                obscureText: obscureTxt,
                                decoration: InputDecoration(
                                  hintText: tr("EnterPassword"),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        obscureTxt = !obscureTxt;
                                      });
                                    },
                                    child: Icon(
                                      obscureTxt
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility_outlined,
                                      color: obscureTxt
                                          ? disabledColor
                                          : grayColor,
                                    ),
                                  ),
                                  errorStyle:
                                  const TextStyle(color: accentColor),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 17.0, horizontal: 10.0),
                                  // prefixIcon: const Icon(
                                  //   Icons.lock_outline,
                                  //   size: 20,
                                  // ),
                                  filled: true,
                                  //hintText: "Password".tr(),
                                  fillColor: const Color(0xFFf5f9f9),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(8)),
                                    borderSide:
                                    BorderSide(width: 1, color: klightGray),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(8)),
                                    borderSide: BorderSide(
                                        width: .7, color: klightGray),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(8)),
                                    borderSide: BorderSide(
                                      width: .7,
                                      color: klightGray,
                                    ),
                                  ),
                                  border: const OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                      borderSide: BorderSide(
                                        width: 1,
                                      )),
                                  errorBorder: const OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                      borderSide: BorderSide(
                                          width: 0.7, color: accentColor)),
                                  focusedErrorBorder: const OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                      borderSide: BorderSide(
                                          width: 0.7, color: accentColor)),
                                  hintStyle: const TextStyle(
                                      fontSize: 13,
                                      color: Color.fromRGBO(196, 196, 196, 1)),
                                ),
                                onChanged: (value) {
                                  if (value.isEmpty ||
                                      value == null ||
                                      !InputValidators().passwordValidator(
                                          password: value, context: context)) {
                                    setState(() {
                                      isValidationError = true;
                                      password = value;
                                    });
                                  } else {
                                    setState(() {
                                      isValidationError = false;
                                      password = value;
                                    });
                                  }
                                },
                                onSaved: (value) {
                                  password = value ?? "";
                                },
                                validator: (value) {
                                  if (value!.isEmpty || value == null) {
                                    return tr("EnterPassword");
                                  } else if (InputValidators()
                                      .passwordValidator(
                                      password: value, context: context)) {
                                    return null;
                                  } else {
                                    return null;
                                  }
                                },
                                cursorColor: Colors.black,
                                keyboardType: TextInputType.text,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Center(
                                child: TextButton(
                                    onPressed: () {
                                      SamaOfficesApp.navKey.currentState!.push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                              const ForgetPassword()));
                                    },
                                    child: Text(
                                      tr("ForgetPassword"),
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    )),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              TextButton(
                                  style: TextButton.styleFrom(
                                      fixedSize: Size(size.width, 55),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(10.0),
                                          side: const BorderSide(
                                              color: yellowColor)),
                                      backgroundColor: yellowColor),
                                  onPressed: () {
                                    checkLogin();
                                  },
                                  child: Text(
                                    tr("Login"),
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color:Colors.black),
                                  )),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(tr("DonHave")),
                                  TextButton(
                                      onPressed: () {
                                        SamaOfficesApp.navKey.currentState!.push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                const SignUpPage()));
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                          bottom:
                                          5, // Space between underline and text
                                        ),
                                        decoration: const BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                  color: Colors.grey,
                                                  width: .5, // Underline thickness
                                                ))),
                                        child: Text(
                                          tr("Register"),
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      )),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                      ]),
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.height / 1,
                  child: Center(
                      child:isLoading==true? const CircularProgressIndicator(): const SizedBox.shrink()
                  ),
                )


              ],
            )));
  }
}
