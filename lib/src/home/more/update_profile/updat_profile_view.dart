import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sama_offices/app.dart';
import 'package:sama_offices/src/home/more/update_profile/update_profile_view_model.dart';

import '../../../../core/utils/input_validators.dart';
import '../../../../core/values/colors.dart';
import '../../../../core/widget/phone_number_widget.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends UpdateProfileViewModel {
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
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child:
              Stack(
                children: [ Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(
                height: 60,
            ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        SamaOfficesApp.navKey.currentState!.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.grey,
                        size: 25,
                      )),
                  Text(
                    tr("MyAccount"),
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.filter_alt_outlined,
                        color: Colors.transparent,
                        size: 30,
                      )),
                ],
              ),
            const SizedBox(
                height: 30,
            ),
            Center(
                child: Stack(children: [
                  InkWell(
                    onTap: () {
                      picker
                          .pickImage(source: ImageSource.gallery)
                          .then((value) => {
                                setState(() {
                                  imageUser = value!;
                                })
                              });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),border: Border.all(color: yellowColor)
                      ),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        backgroundImage: imageUser == null
                            ? CachedNetworkImageProvider(
                                userModel!.image?? "",
                              )
                            : Image.file(File(imageUser!.path)).image,
                      ),
                    ),
                  ),
                  Positioned(
                      right: 10,
                      bottom: 1,
                      child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.grey.shade300),
                          child: const Icon(
                            Icons.linked_camera,
                            color: yellowColor,
                          )))
                ]),
            ),

            const SizedBox(
                height: 50,
            ),
            SizedBox(
              width: size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                          tr("First Name"),
                          style: GoogleFonts.tajawal(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: size.width/2-20,

                        child: TextFormField(
                          controller: firstNameControl,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          style: const TextStyle(fontSize: 15),
                          decoration: InputDecoration(
                            hintText: userModel!.firstName,

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
                            hintStyle: const TextStyle(
                                fontSize: 13, color: Color.fromRGBO(196, 196, 196, 1)),
                          ),
                          onChanged: (value) {
                            if (value.isEmpty ||
                                value == null ||
                                !InputValidators()
                                    .nameValidator(name: value, context: context)) {
                              setState(() {
                                isValidationFirstName = true;
                                fName = value;
                              });
                            } else {
                              setState(() {
                                isValidationFirstName = false;
                                fName = value;
                              });
                            }
                          },
                          onSaved: (value) {
                            fName = value ?? "";
                          },
                          validator: (value) {
                            if (value!.isEmpty || value == null) {
                              return tr("EnterFirstName");
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
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                        tr("Second Name"),
                        style: GoogleFonts.tajawal(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: size.width/2-20,
                        child: TextFormField(
                          controller: secondNameControl,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          style: const TextStyle(fontSize: 15),
                          decoration: InputDecoration(
                            hintText: userModel!.lastName,

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
                            hintStyle: const TextStyle(
                                fontSize: 13, color: Color.fromRGBO(196, 196, 196, 1)),
                          ),
                          onChanged: (value) {
                            if (value.isEmpty ||
                                value == null ||
                                !InputValidators()
                                    .nameValidator(name: value, context: context)) {
                              setState(() {
                                isValidationSecondName = true;
                                sName = value;
                              });
                            } else {
                              setState(() {
                                isValidationSecondName = false;
                                sName = value;
                              });
                            }
                          },
                          onSaved: (value) {
                            sName = value ?? "";
                          },
                          validator: (value) {
                            if (value!.isEmpty || value == null) {
                              return tr("EnterLastName");
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
                      ),
                    ],
                  )
                ],
              ),
            ),



            const SizedBox(
                height: 20,
            ),
            Text(
                tr("Phone"),
                style: GoogleFonts.tajawal(),
            ),
            const SizedBox(
                height: 10,
            ),
            PhoneNumberSignUpWidget(
                controllerPhone: phoneControl,
                isPhone: isPhone,
                focusNode: focusPhone,
                hintText: userModel!.phone,
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
                style: GoogleFonts.tajawal(),
            ),
            const SizedBox(
                height: 10,
            ),
            TextFormField(
                enabled: false,
                controller: emailControl,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                style: const TextStyle(fontSize: 15),
                decoration: InputDecoration(
                  hintText: userModel!.email,

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
                  hintStyle: const TextStyle(
                      fontSize: 13, color: Color.fromRGBO(196, 196, 196, 1)),
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
                height: 30,
            ),
            Container(
                margin: const EdgeInsets.only(left: 20, right: 20, bottom: 50),
                child: TextButton(
                  style: TextButton.styleFrom(
                      fixedSize: Size(size.width, 55),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: yellowColor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: yellowColor),
                  onPressed: () {
                    if(checkUpdate()){
                      updateProfile();
                    }



                  },
                  child:  Text(
                    tr("UpdateProfile"),
                    style: const TextStyle(
                        color: samaColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                ),
            )
          ]),


                  SizedBox(
                    height: MediaQuery.of(context).size.height / 1,
                    child: Center(
                        child:isLoading==true? const CircularProgressIndicator(): const SizedBox.shrink()
                    ),
                  )



              ]),
        ),
      ),
    );
  }
}
