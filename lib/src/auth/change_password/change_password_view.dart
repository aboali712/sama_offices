
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/utils/input_validators.dart';
import '../../../core/values/colors.dart';
import 'change_password_view_model.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends ChangePasswordViewModel {
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
            height: size.height / 3,
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
                    tr("ResetYourPassword"),
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
                    tr("EnterNewPassword"),
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
                top: size.height - (size.height / 1.3), left: 10, right: 10),
            height: size.height - (size.height / 2),
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
                            'assets/images/logo.svg',
                            width: 60,
                            height: 60,
                            // color: samaOfficeColor,
                          ),
                        ),
                        const SizedBox(height: 30,),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          style: const TextStyle(fontSize: 15),
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
                                color: obscureTxt ? disabledColor : grayColor,
                              ),
                            ),
                            errorStyle: const TextStyle(color: accentColor),
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
                              borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(width: 1, color: klightGray),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                              borderSide:
                              BorderSide(width: .7, color: klightGray),
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
                                borderRadius:
                                BorderRadius.all(Radius.circular(8)),
                                borderSide: BorderSide(
                                  width: 1,
                                )),
                            errorBorder: const OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(8)),
                                borderSide:
                                BorderSide(width: 0.7, color: accentColor)),
                            focusedErrorBorder: const OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(8)),
                                borderSide:
                                BorderSide(width: 0.7, color: accentColor)),
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
                                isValidationPassword = true;
                                password = value;
                              });
                            } else {
                              setState(() {
                                isValidationPassword = false;
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
                            } else if (InputValidators().passwordValidator(
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
                          height: 20,
                        ),

                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          style: const TextStyle(fontSize: 15),
                          obscureText: obscureTxt,
                          decoration: InputDecoration(
                            hintText: tr("PleaseRe-enterYourPassword"),
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
                                color: obscureTxt ? disabledColor : grayColor,
                              ),
                            ),
                            errorStyle: const TextStyle(color: accentColor),
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
                              borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(width: 1, color: klightGray),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                              borderSide:
                              BorderSide(width: .7, color: klightGray),
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
                                borderRadius:
                                BorderRadius.all(Radius.circular(8)),
                                borderSide: BorderSide(
                                  width: 1,
                                )),
                            errorBorder: const OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(8)),
                                borderSide:
                                BorderSide(width: 0.7, color: accentColor)),
                            focusedErrorBorder: const OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(8)),
                                borderSide:
                                BorderSide(width: 0.7, color: accentColor)),
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
                                isValidationReEnterPassword = true;
                                reEnterPassword = value;
                              });
                            } else {
                              setState(() {
                                isValidationReEnterPassword = false;
                                reEnterPassword = value;
                              });
                            }
                          },
                          onSaved: (value) {
                            reEnterPassword = value ?? "";
                          },
                          validator: (value) {
                            if (value!.isEmpty || value == null) {
                              return tr("PleaseRe-enterYourPassword");
                            } else if (InputValidators().passwordValidator(
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
                          height: 50,
                        ),






                        TextButton(
                            style: TextButton.styleFrom(
                                fixedSize: Size(size.width, 55),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: const BorderSide(
                                        color: samaOfficeColor)),
                                backgroundColor: samaOfficeColor),
                            onPressed: () {
                              changePassword();
                            },
                            child: Text(
                              tr("CheckNow"),
                              style: GoogleFonts.tajawal(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )),

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
