import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sama_offices/src/auth/signup/signup_view_model.dart';


import '../../../app.dart';
import '../../../core/utils/input_validators.dart';
import '../../../core/values/colors.dart';
import '../../../core/widget/phone_number_widget.dart';
import '../../home/more/about_us/about_us_view.dart';
import '../../home/more/more_view_model_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends SignUpViewModel {
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
      backgroundColor:  Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Stack(
          children: [
            Container(
              color: samaOfficeColor,
              height: 200,
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Platform.isIOS
                      ? const SizedBox(
                          height: 35,
                        )
                      : const SizedBox(
                          height: 25,
                        ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tr("Create a new account"),
                            style: GoogleFonts.tajawal(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            tr("Please enter your information"),
                            style: GoogleFonts.tajawal(
                                color: Colors.white70,
                                fontWeight: FontWeight.w500,
                                fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      SvgPicture.asset(
                        'assets/images/logo.svg',
                        width: 50,
                        color: Colors.white,
                        height: 50,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Container(
                  margin: EdgeInsets.only(
                    top: size.height - (size.height / 1.2),
                  ),
                  height: size.height - (size.height / 6),
                  child: Column(
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: size.width,
                          height: 100,
                          child: Theme(
                            data: ThemeData(
                                fontFamily: "tajawal",
                                canvasColor:  Colors.white,
                                dividerColor: Colors.red,
                                colorScheme: ColorScheme.fromSwatch().copyWith(
                              primary: samaColor,
                              onSurface: Colors.grey,
                            )),
                            child: Stepper(
                              controlsBuilder: (context, _) => currentStep != 3
                                  ? ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          fixedSize: Size(size.width, 50)),
                                      onPressed: () async {
                                        bool isLastStep = (currentStep ==
                                            getSteps().length - 1);
                                        if (isLastStep) {
                                          //Do something with this information
                                        } else {
                                          setState(() {
                                            currentStep += 1;
                                            print(currentStep);
                                          });
                                        }
                                      },
                                      child: Text(
                                        tr("Next"),
                                        style: GoogleFonts.tajawal(fontSize: 15),
                                      ))
                                  : ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: samaOfficeColor,
                                          fixedSize: Size(size.width, 50)),
                                      onPressed: () async {
                                     if(   checkValidationRegister()){
                                       registerCallApi();
                                     }
                                      },
                                      child: Text(
                                        tr("Register"),
                                        style: GoogleFonts.tajawal(fontSize: 15,color: Colors.white),
                                      )),
                              type: StepperType.horizontal,
                              currentStep: currentStep,
                              onStepCancel: () => currentStep == 0
                                  ? null
                                  : setState(() {
                                      currentStep -= 1;
                                    }),
                              onStepContinue: () {},
                              onStepTapped: (step) => setState(() {
                                currentStep = step;
                              }),
                              steps: getSteps(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 1,
              child: Center(
                  child: isLoading == true
                      ? const CircularProgressIndicator()
                      : const SizedBox.shrink()),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 1,
              child: Center(
                  child: imageOffice== "0"
                      ? const CircularProgressIndicator()
                      : const SizedBox.shrink()),
            )
          ],
        ),
      ),
    );
  }

  List<Step> getSteps() {
    return <Step>[
      Step(
        state: currentStep > 0 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 0,
        title: SizedBox(
            width: 51,
            child: Text(
              tr("OfficeInformation"),
              style: GoogleFonts.tajawal(fontSize: 12),
            )),
        content: Flex(direction: Axis.horizontal, children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr("OfficeName"),
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: const TextStyle(fontSize: 15),
                    decoration: InputDecoration(
                      hintText: (tr("OfficeName")),
                      hintStyle: GoogleFonts.tajawal(
                          fontSize: 12,
                          color: const Color.fromRGBO(196, 196, 196, 1)),

                      errorStyle: const TextStyle(color: accentColor),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 17.0, horizontal: 10.0),

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
                    ),
                    onChanged: (value) {
                      if (value.isEmpty ||
                          value == null ||
                          !InputValidators()
                              .nameValidator(name: value, context: context)) {
                        setState(() {
                          isValidationName = true;
                          name = value;
                        });
                      } else {
                        setState(() {
                          isValidationName = false;
                          name = value;
                        });
                      }
                    },
                    onSaved: (value) {
                      name = value ?? "";
                    },
                    validator: (value) {
                      if (value!.isEmpty || value == null) {
                        return tr("EnterTheOfficeName");
                      } else if (InputValidators()
                          .nameValidator(name: value, context: context)) {
                        return null;
                      } else {
                        return null;
                      }
                    },
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.name,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    tr("Phone"),
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 15),
                    textAlign: TextAlign.center,
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
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    tr("E-mail"),
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: const TextStyle(fontSize: 15),
                    decoration: InputDecoration(
                      hintText: tr("E-mail"),
                      hintStyle: GoogleFonts.tajawal(
                          fontSize: 12,
                          color: const Color.fromRGBO(196, 196, 196, 1)),

                      errorStyle: const TextStyle(color: accentColor),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 17.0, horizontal: 10.0),

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
                    ),
                    onChanged: (value) {
                      if (value.isEmpty ||
                          value == null ||
                          !InputValidators()
                              .emailValidator(email: value, context: context)) {
                        setState(() {
                          isValidationEmail = true;
                          email = value;
                        });
                      } else {
                        setState(() {
                          isValidationEmail = false;
                          email = value;
                        });
                      }
                    },
                    onSaved: (value) {
                      email = value ?? "";
                    },
                    validator: (value) {
                      if (value!.isEmpty || value == null) {
                        return tr("EnterEmail");
                      } else if (InputValidators()
                          .emailValidator(email: value, context: context)) {
                        return null;
                      } else {
                        return null;
                      }
                    },
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.emailAddress,
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
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: const TextStyle(fontSize: 15),
                    obscureText: obscureTxt,
                    decoration: InputDecoration(
                      hintText: tr("EnterPassword"),
                      hintStyle: GoogleFonts.tajawal(
                          fontSize: 12,
                          color: const Color.fromRGBO(196, 196, 196, 1)),
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
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
      Step(
        state: currentStep > 1 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 1,
        title: SizedBox(
            width: 40,
            child: Text(tr("officeBranch"),
                style: GoogleFonts.tajawal(fontSize: 12))),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TypeAheadField<String>(

              textFieldConfiguration: TextFieldConfiguration(
                controller: TextEditingController(text: selectedOfficeBranch),
                autofocus: false,
                style: GoogleFonts.tajawal(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: 15),
                decoration: InputDecoration(
                  fillColor: const Color(0xFFf5f9f9),
                  filled: true,
                  hintStyle: GoogleFonts.tajawal(fontSize: 14),
                  hintText: tr('ChooseTheOfficeBranch'),
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
                ),
              ),
              suggestionsCallback: (pattern) async {
                return filterModel!.countries!
                    .map((e) => e.name!)
                    .toList()
                    .where((item) => item
                    .toLowerCase()
                    .startsWith(pattern.toLowerCase()));
              },
              itemBuilder: (context, suggestion) {
                return ListTile(
                  title: Text(suggestion),
                );
              },
              onSuggestionSelected: (suggestion) {
                setState(() {
                  selectedOfficeBranch = suggestion;
                  selectedOfficeBranchID = filterModel!.countries!
                      .firstWhere((element) => element.name == suggestion)
                      .id
                      .toString();
                  countryId=selectedOfficeBranchID!;
                  selectedCityBranch="";
                  getCityDataApi();
                });


              },

            ),

            const SizedBox(
              height: 20,
            ),
            TypeAheadField<String>(

              textFieldConfiguration: TextFieldConfiguration(
                controller: TextEditingController(text: selectedCityBranch),
                autofocus: false,
                style: GoogleFonts.tajawal(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: 15),
                decoration: InputDecoration(
                  fillColor: const Color(0xFFf5f9f9),
                  filled: true,
                  hintStyle: GoogleFonts.tajawal(fontSize: 14),
                  hintText: tr('ChooseTheCity'),
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
                ),
              ),
              suggestionsCallback: (pattern) async {
                return cites
                    .map((e) => e.name!)
                    .toList()
                    .where((item) => item
                    .toLowerCase()
                    .startsWith(pattern.toLowerCase()));
              },
              itemBuilder: (context, suggestion) {
                return ListTile(
                  title: Text(suggestion),
                );
              },
              onSuggestionSelected: (suggestion) {
                setState(() {
                  selectedCityBranch = suggestion;
                  selectedCityBranchID = cites
                      .firstWhere((element) => element.name == suggestion)
                      .id
                      .toString();

                });


              },

            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              style: const TextStyle(fontSize: 15),
              decoration: InputDecoration(
                hintText: tr("Address"),
                hintStyle: GoogleFonts.tajawal(
                    fontSize: 12,
                    color: const Color.fromRGBO(196, 196, 196, 1)),

                errorStyle: const TextStyle(color: accentColor),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 17.0, horizontal: 10.0),

                filled: true,
                //hintText: "Password".tr(),
                fillColor: const Color(0xFFf5f9f9),
                focusedBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(width: 1, color: klightGray),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(width: .7, color: klightGray),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
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
                    borderSide: BorderSide(width: 0.7, color: accentColor)),
                focusedErrorBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(width: 0.7, color: accentColor)),
              ),
              onChanged: (value) {
                if (value.isEmpty ||
                    value == null ||
                    !InputValidators()
                        .nameValidator(name: value, context: context)) {
                  setState(() {
                    isValidationAddressBranch = true;
                    addressBranch = value;
                  });
                } else {
                  setState(() {
                    isValidationAddressBranch = false;
                    addressBranch = value;
                  });
                }
              },
              onSaved: (value) {
                addressBranch = value ?? "";
              },
              validator: (value) {
                if (value!.isEmpty || value == null) {
                  return tr("EnterTheAddress");
                } else if (InputValidators()
                    .nameValidator(name: value, context: context)) {
                  return null;
                } else {
                  return null;
                }
              },
              cursorColor: Colors.black,
              keyboardType: TextInputType.name,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(tr("ChooseAddressFrom"),
                style: GoogleFonts.tajawal(fontSize: 12)),
            const SizedBox(
              height: 5,
            ),
            InkWell(
              onTap: (){
                showPlacePicker();
              },
              child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xFFf5f9f9),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  padding: const EdgeInsets.all(10),
                  alignment: AlignmentDirectional.centerStart,
                  width: MediaQuery.of(context).size.width,
                  child: Text(result!=null ? result!.formattedAddress! : tr("ChooseAddressFrom"),
                      style: GoogleFonts.tajawal(fontSize: 12))),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(mainAxisAlignment:  MainAxisAlignment.spaceBetween,
              children: [
                Text(tr("OfficeOpeningTimes"),style: GoogleFonts.tajawal(fontSize: 15,),),
                const SizedBox(width: 20,),
                SizedBox(height: 45,width: 120,
                  child: TextField(
                    controller: timeInControl,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14,color: Colors.black),
                    decoration: InputDecoration(

                        filled: true,
                        fillColor: Colors.white,

                        disabledBorder: OutlineInputBorder(
                            borderSide:  BorderSide(color: Colors.grey.shade400,width: .4),
                            borderRadius: BorderRadius.circular(10)),
                        enabledBorder:OutlineInputBorder(
                            borderSide:  BorderSide(color: Colors.grey.shade400,width: .4),
                            borderRadius: BorderRadius.circular(10)) ,
                        border: OutlineInputBorder(
                            borderSide:  BorderSide(color: Colors.grey.shade300,width: .4),
                            borderRadius: BorderRadius.circular(10)),

                        focusedErrorBorder:OutlineInputBorder(
                            borderSide:  BorderSide(color: Colors.grey.shade300,width: .4),
                            borderRadius: BorderRadius.circular(10)),
                        errorBorder: OutlineInputBorder(
                            borderSide:  BorderSide(color: Colors.grey.shade300,width: .4),
                            borderRadius: BorderRadius.circular(10))

                      // icon: const Icon(Icons.alarm_add_outlined),
                      // labelText: "Enter Time"
                    ),
                    readOnly: true,

                    onTap: () async {
                      TimeOfDay? pickedTime = await showTimePicker(


                        initialTime: TimeOfDay.now(),
                        context: context,
                      );

                      if (pickedTime != null) {
                        print(pickedTime.format(context));
                        print(pickedTime.format(context));
                        String formattedTime = '${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
                        print("${formattedTime}" );

                        setState(() {
                          timeInControl.text = formattedTime;
                          print(timeInControl.text);


                        });

                        if(timeInControl.text!=""|| timeOutControl.text!=""){
                          setState(() {
                            hourTimeControl.text=
                "${tr("from")} ${timeInControl.text} ${tr("A.M")} ${tr("to")} ${timeOutControl.text} ${tr("P.M")}" ;
                          });
                        }

                      } else {
                        print("Time is not selected");
                      }
                    },
                  ),
                ),

              ],
            ),
            const SizedBox(height: 10,),

            Row(mainAxisAlignment:  MainAxisAlignment.spaceBetween,
              children: [
                Text(tr("OfficeClosingTimes"),style: GoogleFonts.tajawal(fontSize: 15,),),
                const SizedBox(width: 20,),
                SizedBox(height: 45,width: 120,
                  child: TextField(
                    controller: timeOutControl,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14,color: Colors.black),
                    decoration: InputDecoration(

                        filled: true,
                        fillColor: Colors.white,

                        disabledBorder: OutlineInputBorder(
                            borderSide:  BorderSide(color: Colors.grey.shade400,width: .4),
                            borderRadius: BorderRadius.circular(10)),
                        enabledBorder:OutlineInputBorder(
                            borderSide:  BorderSide(color: Colors.grey.shade400,width: .4),
                            borderRadius: BorderRadius.circular(10)) ,
                        border: OutlineInputBorder(
                            borderSide:  BorderSide(color: Colors.grey.shade300,width: .4),
                            borderRadius: BorderRadius.circular(10)),

                        focusedErrorBorder:OutlineInputBorder(
                            borderSide:  BorderSide(color: Colors.grey.shade300,width: .4),
                            borderRadius: BorderRadius.circular(10)),
                        errorBorder: OutlineInputBorder(
                            borderSide:  BorderSide(color: Colors.grey.shade300,width: .4),
                            borderRadius: BorderRadius.circular(10))

                      // icon: const Icon(Icons.alarm_add_outlined),
                      // labelText: "Enter Time"
                    ),
                    readOnly: true,

                    onTap: () async {
                      TimeOfDay? pickedTime = await showTimePicker(


                        initialTime: TimeOfDay.now(),
                        context: context,
                      );

                      if (pickedTime != null) {
                        print(pickedTime.format(context));
                        print(pickedTime.format(context));
                        String formattedTime = '${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
                        print("${formattedTime}" );

                        setState(() {
                          timeOutControl.text = formattedTime;
                          print(timeOutControl.text);
                        });

                        if(timeInControl.text!=""|| timeOutControl.text!=""){
                          setState(() {
                            hourTimeControl.text=
             "${tr("from")} ${timeInControl.text} ${tr("A.M")} ${tr("to")} ${timeOutControl.text} ${tr("P.M")}" ;
                          });
                        }



                      } else {
                        print("Time is not selected");
                      }
                    },
                  ),
                ),

              ],
            ),

            const SizedBox(
              height: 20,
            ),

            TextFormField(
              controller: hourTimeControl,
              readOnly: true,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              style: const TextStyle(fontSize: 14,),
              decoration: InputDecoration(
                hintText: tr("WorkingHours"),
                hintStyle: GoogleFonts.tajawal(
                    fontSize: 12,
                    color: const Color.fromRGBO(196, 196, 196, 1)),

                errorStyle: const TextStyle(color: accentColor),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 17.0, horizontal: 10.0),

                filled: true,
                //hintText: "Password".tr(),
                fillColor: const Color(0xFFf5f9f9),
                focusedBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(width: 1, color: klightGray),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(width: .7, color: klightGray),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
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
                    borderSide: BorderSide(width: 0.7, color: accentColor)),
                focusedErrorBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(width: 0.7, color: accentColor)),
              ),
              onChanged: (value) {
                if (value.isEmpty ||
                    value == null ||
                    !InputValidators()
                        .nameValidator(name: value, context: context)) {
                  setState(() {
                    isValidationTimeBranch = true;
                    timeBranch = value;
                  });
                } else {
                  setState(() {
                    isValidationTimeBranch = false;
                    timeBranch = value;
                  });
                }
              },
              onSaved: (value) {
                timeBranch = value ?? "";
              },
              validator: (value) {
                if (value!.isEmpty || value == null) {
                  return tr("EnterBusinessHours");
                } else if (InputValidators()
                    .nameValidator(name: value, context: context)) {
                  return null;
                } else {
                  return null;
                }
              },
              cursorColor: Colors.black,
              keyboardType: TextInputType.name,
            ),
            const SizedBox(
              height: 20,
            ),








            const SizedBox(
              height: 20,
            ),
            Text(tr("officeLogo"), style: GoogleFonts.tajawal(fontSize: 15)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(150, 35)
                    ),
                    onPressed: () async {
                      imageOffice =
                          (await picker.pickImage(source: ImageSource.gallery)) ;
                      setState(() {

                      });



                    },
                    child: Text(
                      tr("ChooseTheOfficeLogo"),
                      style: GoogleFonts.tajawal(fontSize: 12),
                    )),
                imageOffice == null
                    ? Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            color: const Color(0xFFf5f9f9),
                            borderRadius: BorderRadius.circular(10)),
                        width: 150,
                        height: 100,
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.grey[800],
                        ),
                      )
                    : Image.file(
                        File(imageOffice!.path),
                        height: 100,
                        width: 150,
                        fit: BoxFit.fill,
                      ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(width: 170,
              child: Text(tr("CopyOfTheCommercialRegister"),
                  style: GoogleFonts.tajawal(fontSize: 15)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(150, 35)
                    ),
                    onPressed: () async {
                      imageCommercial =
                          await picker.pickImage(source: ImageSource.gallery);
                      setState(() {});
                    },
                    child: Text(
                      tr("ChooseTheCommercialRegistry"),
                      style: GoogleFonts.tajawal(fontSize: 12),
                    )),
                imageCommercial == null
                    ? Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            color: const Color(0xFFf5f9f9),
                            borderRadius: BorderRadius.circular(10)),
                        width: 150,
                        height: 100,
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.grey[800],
                        ),
                      )
                    : Image.file(
                        File(imageCommercial!.path),
                        height: 100,
                        width: 150,
                        fit: BoxFit.fill,
                      ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
      Step(
        state: currentStep > 2 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 2,
        title: SizedBox(
            width: 50,
            child:
                Text(tr("Services"), style: GoogleFonts.tajawal(fontSize: 12))),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(tr("ChooseServices"),
                style: GoogleFonts.tajawal(
                    fontSize: 15, fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 20,
            ),
            Column(
                children: filterModel != null
                    ? filterModel!.services!
                        .map((e) => Row(
                              children: [
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 30,
                                          height: 40,
                                          child: Checkbox(
                                            activeColor: samaColor,

                                            value: selectServices.contains(e),
                                            onChanged: (newValue) {
                                              setState(() {
                                                if (newValue!) {
                                                  //true => list not contain item
                                                  selectServices.add(e);
                                                } else {
                                                  // false
                                                  selectServices.remove(e);
                                                }
                                                print(selectServices.length
                                                    .toString());
                                              });
                                            },
                                          ),
                                        ),
                                        Text(e.name!,
                                            style: GoogleFonts.tajawal(
                                              fontWeight: FontWeight.w500,
                                                fontSize: 14)),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ],
                            ))
                        .toList()
                    : []),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
      Step(
        state: StepState.indexed,
        isActive: currentStep >= 3,
        title: SizedBox(
            width: 50,
            child: Text(tr("Subscription"),
                style: GoogleFonts.tajawal(fontSize: 12))),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(tr("BankAccountInformation"),
                style: GoogleFonts.tajawal(
                    fontSize: 15, fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              style: const TextStyle(fontSize: 15),
              decoration: InputDecoration(
                hintText: tr("BankName"),
                hintStyle: GoogleFonts.tajawal(
                    fontSize: 12,
                    color: const Color.fromRGBO(196, 196, 196, 1)),

                errorStyle: const TextStyle(color: accentColor),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 17.0, horizontal: 10.0),

                filled: true,
                //hintText: "Password".tr(),
                fillColor: const Color(0xFFf5f9f9),
                focusedBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(width: 1, color: klightGray),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(width: .7, color: klightGray),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
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
                    borderSide: BorderSide(width: 0.7, color: accentColor)),
                focusedErrorBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(width: 0.7, color: accentColor)),
              ),
              onChanged: (value) {
                if (value.isEmpty ||
                    value == null ||
                    !InputValidators()
                        .nameValidator(name: value, context: context)) {
                  setState(() {
                    isValidationBankName = true;
                    bankName = value;
                  });
                } else {
                  setState(() {
                    isValidationBankName = false;
                    bankName = value;
                  });
                }
              },
              onSaved: (value) {
                bankName = value ?? "";
              },
              validator: (value) {
                if (value!.isEmpty || value == null) {
                  return tr("EnterTheNameOfTheBank");
                } else if (InputValidators()
                    .nameValidator(name: value, context: context)) {
                  return null;
                } else {
                  return null;
                }
              },
              cursorColor: Colors.black,
              keyboardType: TextInputType.name,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              style: const TextStyle(fontSize: 15),
              decoration: InputDecoration(
                hintText: tr("accountNumber"),
                hintStyle: GoogleFonts.tajawal(
                    fontSize: 12,
                    color: const Color.fromRGBO(196, 196, 196, 1)),

                errorStyle: const TextStyle(color: accentColor),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 17.0, horizontal: 10.0),

                filled: true,
                //hintText: "Password".tr(),
                fillColor: const Color(0xFFf5f9f9),
                focusedBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(width: 1, color: klightGray),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(width: .7, color: klightGray),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
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
                    borderSide: BorderSide(width: 0.7, color: accentColor)),
                focusedErrorBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(width: 0.7, color: accentColor)),
              ),
              onChanged: (value) {
                if (value.isEmpty ||
                    value == null ||
                    !InputValidators()
                        .nameValidator(name: value, context: context)) {
                  setState(() {
                    isValidationAccountNumber = true;
                    accountNumber = value;
                  });
                } else {
                  setState(() {
                    isValidationAccountNumber = false;
                    accountNumber = value;
                  });
                }
              },
              onSaved: (value) {
                accountNumber = value ?? "";
              },
              validator: (value) {
                if (value!.isEmpty || value == null) {
                  return tr("EnterTheAccountNumber");
                } else if (InputValidators()
                    .nameValidator(name: value, context: context)) {
                  return null;
                } else {
                  return null;
                }
              },
              cursorColor: Colors.black,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              style: const TextStyle(fontSize: 15),
              decoration: InputDecoration(
                hintText: tr("IBANNumber"),
                hintStyle: GoogleFonts.tajawal(
                    fontSize: 12,
                    color: const Color.fromRGBO(196, 196, 196, 1)),

                errorStyle: const TextStyle(color: accentColor),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 17.0, horizontal: 10.0),

                filled: true,
                //hintText: "Password".tr(),
                fillColor: const Color(0xFFf5f9f9),
                focusedBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(width: 1, color: klightGray),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(width: .7, color: klightGray),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
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
                    borderSide: BorderSide(width: 0.7, color: accentColor)),
                focusedErrorBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(width: 0.7, color: accentColor)),
              ),
              onChanged: (value) {
                if (value.isEmpty ||
                    value == null ||
                    !InputValidators()
                        .nameValidator(name: value, context: context)) {
                  setState(() {
                    isValidationIBANNumber = true;
                    iBANNumber = value;
                  });
                } else {
                  setState(() {
                    isValidationIBANNumber = false;
                    iBANNumber = value;
                  });
                }
              },
              onSaved: (value) {
                iBANNumber = value ?? "";
              },
              validator: (value) {
                if (value!.isEmpty || value == null) {
                  return tr("EnterTheIBANNumber");
                } else if (InputValidators()
                    .nameValidator(name: value, context: context)) {
                  return null;
                } else {
                  return null;
                }
              },
              cursorColor: Colors.black,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(
              height: 20,
            ),
            DropdownButtonFormField2(
              decoration: InputDecoration(
                hintText: tr("SubscriptionPlan"),
                hintStyle: GoogleFonts.tajawal(
                    fontSize: 12,
                    color: const Color.fromRGBO(196, 196, 196, 1)),
                errorStyle: const TextStyle(color: accentColor),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 7.0, horizontal: 10.0),
                filled: true,
                fillColor: const Color(0xFFf5f9f9),
                focusedBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(width: 1, color: klightGray),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(width: .7, color: klightGray),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
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
                    borderSide: BorderSide(width: 0.7, color: accentColor)),
                focusedErrorBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(width: 0.7, color: accentColor)),
              ),
              items: filterModel != null
                  ? filterModel!.plans!
                      .map((e) => e.name!)
                      .toList()
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: GoogleFonts.tajawal(
                                  fontSize: 14, color: Colors.black),
                            ),
                          ))
                      .toList()
                  : [],
              value: selectedSubscriptionPlan,
              onChanged: (value) {
                setState(() {
                  selectedSubscriptionPlan = value as String;
                  selectedPlanID = filterModel!.plans!
                      .firstWhere(
                          (element) => element.name == selectedSubscriptionPlan)
                      .id
                      .toString();

                  planPrice = filterModel!.plans!
                      .firstWhere(
                          (element) => element.name == selectedSubscriptionPlan)
                      .price
                      .toString();

                });

                print(selectedPlanID);
                print(planPrice);
              },
              buttonHeight: 40,
              buttonWidth: double.infinity,
              itemHeight: 40,
            ),
            const SizedBox(
              height: 20,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(activeColor: samaColor,
                  value: terms,
                  onChanged: (bool? value) {
                    setState(() {
                      terms = value!;
                    });
                  },
                ),
                const SizedBox(
                  width: 5,
                ),
                 Text(
                  tr("IAgree"),
                  style: const TextStyle(
                    fontFamily: "Tajawal",
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                InkWell(
                  onTap: () {
                    MoreViewModelPage.typePage = "3";

                    SamaOfficesApp.navKey.currentState!.push(
                        MaterialPageRoute(
                            builder: (context) =>
                            const AboutUs()));

                  },
                  child:  Text(
                    tr("Terms and Conditions"),
                    style: const TextStyle(
                        fontFamily: "Tajawal",
                        decoration: TextDecoration.underline,
                        decorationThickness: 20,

                        fontSize:14,
                        fontWeight: FontWeight.bold,
                        color: samaColor),
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 10,
            ),


          ],
        ),
      ),
    ];
  }
}
