import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
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
            statusBarColor: Colors.white,
            /* set Status bar color in Android devices. */
            statusBarIconBrightness: Brightness.dark,
            /* set Status bar icons color in Android devices.*/
            statusBarBrightness:
                Brightness.dark) /* set Status bar icon color in iOS. */
        );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [

          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(
        height: 40,
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
            tr("accountDetails"),
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




            profileModel!=null?
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                        child: Container(height: 90,width: 90,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),border: Border.all(color: yellowColor)
                          ),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.white,
                            // child:imageUser==null?
                            // Image.network(profileModel!.office!.image!,fit: BoxFit.fill,)
                            //     : Image.file(File(imageUser!.path))

                            backgroundImage: imageUser == null
                                ? CachedNetworkImageProvider(
                              profileModel!.office!.image?? "",
                            )
                                : Image.file(File(imageUser!.path)).image,
                          ),
                        ),
                      ),
                      Positioned(
                          right: 10,
                          bottom: 1,
                          child: Container(
                              height: 35,
                              width: 35,
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
                    height: 10,
                  ),



                  Container(
                    color: samaOfficeColor,
                    height: 60,
                    child: TabBar(
                      unselectedLabelColor: Colors.white,
                      labelColor: samaColor,
                      indicatorColor: samaColor,
                      tabs: [
                        Text(
                          tr("AboutResponsible"),
                          style: TextStyle(
                              fontSize: Platform.isIOS ? 15 : 13,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          tr("AboutOffice"),
                          style: TextStyle(
                              fontSize: Platform.isIOS ? 15 : 13,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          tr("payment"),
                          style: TextStyle(
                              fontSize: Platform.isIOS ? 15 : 13,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                      controller: tabController,
                      indicatorSize: TabBarIndicatorSize.tab,
                    ),
                  ),

                  Expanded(
                    child: TabBarView(

                        controller: tabController, children: [

                      SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10,right: 10),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20,),

                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                tr("fullName"),
                                style: GoogleFonts.tajawal(),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: nameControl,

                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                style: const TextStyle(fontSize: 15),
                                decoration: InputDecoration(
                                  // hintText: profileModel!.office!.description,

                                  errorStyle: const TextStyle(color: accentColor),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 17.0, horizontal: 10.0),
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
                                  hintStyle: const TextStyle(
                                      fontSize: 13, color: Color.fromRGBO(196, 196, 196, 1)),
                                ),
                                onChanged: (value) {
                                  if (value.isEmpty ||
                                      value == null ||
                                      !InputValidators()
                                          .nameValidator(name: value, context: context)) {
                                    setState(() {
                                      isName = true;
                                      name = value;
                                    });
                                  } else {
                                    setState(() {
                                      isName = false;
                                      name = value;
                                    });
                                  }
                                },
                                onSaved: (value) {
                                  name = value ?? "";
                                },
                                validator: (value) {
                                  if (value!.isEmpty || value == null) {
                                    return tr("fullName");
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
                                height: 10,
                              ),
                              Text(
                                tr("fullNameEn"),
                                style: GoogleFonts.tajawal(),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: nameEnControl,

                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                style: const TextStyle(fontSize: 15),
                                decoration: InputDecoration(
                                  hintText:  tr("fullNameEn"),


                                  errorStyle: const TextStyle(color: accentColor),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 17.0, horizontal: 10.0),
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
                                  hintStyle: const TextStyle(
                                      fontSize: 13, color: Color.fromRGBO(196, 196, 196, 1)),
                                ),
                                onChanged: (value) {
                                  if (value.isEmpty ||
                                      value == null ||
                                      !InputValidators()
                                          .nameValidator(name: value, context: context)) {
                                    setState(() {
                                      isNameEn = true;
                                      nameEn = value;
                                    });
                                  } else {
                                    setState(() {
                                      isNameEn = false;
                                      nameEn = value;
                                    });
                                  }
                                },
                                onSaved: (value) {
                                  nameEn = value ?? "";
                                },
                                validator: (value) {
                                  if (value!.isEmpty || value == null) {
                                    return tr("fullNameEn");
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

                                  errorStyle: const TextStyle(color: accentColor),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 17.0, horizontal: 10.0),

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


                            ],
                          ),
                        ),
                      ),

                      SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10,right: 10),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 20,
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
                                              // hintText: userModel!.firstName,

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
                                              // hintText: userModel!.lastName,

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
                                height: 10,
                              ),
                              Text(
                                tr("description"),
                                style: GoogleFonts.tajawal(),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: descriptionControl,
                                maxLines: 4,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                style: const TextStyle(fontSize: 15),
                                decoration: InputDecoration(
                                  // hintText: profileModel!.office!.description,

                                  errorStyle: const TextStyle(color: accentColor),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 17.0, horizontal: 10.0),
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
                                  hintStyle: const TextStyle(
                                      fontSize: 13, color: Color.fromRGBO(196, 196, 196, 1)),
                                ),
                                onChanged: (value) {
                                  if (value.isEmpty ||
                                      value == null ||
                                      !InputValidators()
                                          .nameValidator(name: value, context: context)) {
                                    setState(() {
                                      isDescription = true;
                                      description = value;
                                    });
                                  } else {
                                    setState(() {
                                      isDescription = false;
                                      description = value;
                                    });
                                  }
                                },
                                onSaved: (value) {
                                  description = value ?? "";
                                },
                                validator: (value) {
                                  if (value!.isEmpty || value == null) {
                                    return tr("description");
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
                                height: 10,
                              ),
                              Text(
                                tr("descriptionEn"),
                                style: GoogleFonts.tajawal(),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: descriptionEnControl,
                                maxLines: 4,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                style: const TextStyle(fontSize: 15),
                                decoration: InputDecoration(
                                  hintText:  tr("descriptionEn"),

                                  errorStyle: const TextStyle(color: accentColor),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 17.0, horizontal: 10.0),
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
                                  hintStyle: const TextStyle(
                                      fontSize: 13, color: Color.fromRGBO(196, 196, 196, 1)),
                                ),
                                onChanged: (value) {
                                  if (value.isEmpty ||
                                      value == null ||
                                      !InputValidators()
                                          .nameValidator(name: value, context: context)) {
                                    setState(() {
                                      isDescriptionEn = true;
                                      descriptionEn = value;
                                    });
                                  } else {
                                    setState(() {
                                      isDescriptionEn = false;
                                      descriptionEn = value;
                                    });
                                  }
                                },
                                onSaved: (value) {
                                  descriptionEn = value ?? "";
                                },
                                validator: (value) {
                                  if (value!.isEmpty || value == null) {
                                    return tr("descriptionEn");
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
                                height: 10,
                              ),
                              Text(
                                tr("Address"),
                                style: GoogleFonts.tajawal(),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: addressControl,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                style: const TextStyle(fontSize: 15),
                                decoration: InputDecoration(
                                  // hintText: profileModel!.office!.description,

                                  errorStyle: const TextStyle(color: accentColor),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 17.0, horizontal: 10.0),
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
                                  hintStyle: const TextStyle(
                                      fontSize: 13, color: Color.fromRGBO(196, 196, 196, 1)),
                                ),
                                onChanged: (value) {
                                  if (value.isEmpty ||
                                      value == null ||
                                      !InputValidators()
                                          .nameValidator(name: value, context: context)) {
                                    setState(() {
                                      isAddress = true;
                                      address = value;
                                    });
                                  } else {
                                    setState(() {
                                      isAddress = false;
                                      address = value;
                                    });
                                  }
                                },
                                onSaved: (value) {
                                  address = value ?? "";
                                },
                                validator: (value) {
                                  if (value!.isEmpty || value == null) {
                                    return tr("Address");
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
                                height: 10,
                              ),
                              Text(
                                tr("AddressEn"),
                                style: GoogleFonts.tajawal(),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: addressEnControl,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                style: const TextStyle(fontSize: 15),
                                decoration: InputDecoration(
                                  hintText: tr("AddressEn"),

                                  errorStyle: const TextStyle(color: accentColor),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 17.0, horizontal: 10.0),
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
                                  hintStyle: const TextStyle(
                                      fontSize: 13, color: Color.fromRGBO(196, 196, 196, 1)),
                                ),
                                onChanged: (value) {
                                  if (value.isEmpty ||
                                      value == null ||
                                      !InputValidators()
                                          .nameValidator(name: value, context: context)) {
                                    setState(() {
                                      isAddress = true;
                                      address = value;
                                    });
                                  } else {
                                    setState(() {
                                      isAddress = false;
                                      address = value;
                                    });
                                  }
                                },
                                onSaved: (value) {
                                  address = value ?? "";
                                },
                                validator: (value) {
                                  if (value!.isEmpty || value == null) {
                                    return tr("AddressEn");
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
                                height: 10,
                              ),
                              Text(tr("ChooseAddressFrom"),
                                  style: GoogleFonts.tajawal()),
                              const SizedBox(
                                height: 10,
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
                                height: 10,
                              ),
                              Text(tr("ChooseTheOfficeBranch"),
                                  style: GoogleFonts.tajawal()),
                              const SizedBox(
                                height: 10,
                              ),


                              Container(height: 50,decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                                child: DropdownButtonFormField2(

                                  decoration: InputDecoration(
                                    hintText: profileModel!.office!.country_name,
                                    floatingLabelBehavior: FloatingLabelBehavior.never,
                                    contentPadding: const EdgeInsets.only(
                                        bottom: 15.0, top: 10, left: 3, right: 8),
                                    filled: true,
                                    fillColor: const Color(0xFFf5f9f9),
                                    labelStyle: GoogleFonts.tajawal(
                                        color: disabledTextColor, fontSize: 13),
                                    floatingLabelStyle: const TextStyle(color: textGrayColor),
                                    errorStyle: const TextStyle(color: textError),
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
                                    // labelText: tr("ChooseTheOfficeBranch"),
                                    hintStyle: GoogleFonts.tajawal(
                                      fontSize: 13,
                                    ),
                                  ),
                                  items: filterModel != null
                                      ?  filterModel!.countries!
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
                                  value: selectedOfficeBranch,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedCityBranch="";
                                      selectedOfficeBranch = value!.toString();
                                      selectedOfficeBranchID = filterModel!.countries!
                                          .firstWhere(
                                              (element) => element.name ==selectedOfficeBranch)
                                          .id
                                          .toString();

                                      countryId=selectedOfficeBranchID!;

                                      getCityDataApi();

                                    });
                                  },

                                ),
                              ),
                              const SizedBox(height: 10,),

                              Text(tr("ChooseTheCity"),
                                  style: GoogleFonts.tajawal()),


                              const SizedBox(
                                height: 10,
                              ),


                              Container(height: 50,decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                                child: DropdownButtonFormField2(
                                  decoration: InputDecoration(
                                    hintText: profileModel!.office!.city_name,
                                    floatingLabelBehavior: FloatingLabelBehavior.never,
                                    contentPadding: const EdgeInsets.only(
                                        bottom: 15.0, top: 10, left: 3, right: 8),
                                    filled: true,
                                    fillColor: const Color(0xFFf5f9f9),
                                    labelStyle: GoogleFonts.tajawal(
                                        color: disabledTextColor, fontSize: 13),
                                    floatingLabelStyle: const TextStyle(color: textGrayColor),
                                    errorStyle: const TextStyle(color: textError),
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
                                    // labelText: tr("ChooseTheCity"),
                                    hintStyle: GoogleFonts.tajawal(
                                      fontSize: 13,
                                    ),
                                  ),
                                  items:
                                  cites
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

                                  ,
                                  value:    selectedCityBranch.isNotEmpty?     selectedCityBranch  : null,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedCityBranch = value!.toString();

                                      selectedCityBranchID = cites
                                          .firstWhere(
                                              (element) => element.name ==selectedCityBranch)
                                          .id
                                          .toString();
                                    });
                                  },

                                ),
                              ),



                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                tr("WorkingHoursInArabic"),
                                style: GoogleFonts.tajawal(),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: workHoursControl,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                style: const TextStyle(fontSize: 15),
                                decoration: InputDecoration(
                                  // hintText: profileModel!.office!.description,

                                  errorStyle: const TextStyle(color: accentColor),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 17.0, horizontal: 10.0),
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
                                  hintStyle: const TextStyle(
                                      fontSize: 13, color: Color.fromRGBO(196, 196, 196, 1)),
                                ),
                                onChanged: (value) {
                                  if (value.isEmpty ||
                                      value == null ||
                                      !InputValidators()
                                          .nameValidator(name: value, context: context)) {
                                    setState(() {
                                      isWorkHour = true;
                                      workHour = value;
                                    });
                                  } else {
                                    setState(() {
                                      isWorkHour = false;
                                      workHour = value;
                                    });
                                  }
                                },
                                onSaved: (value) {
                                  workHour = value ?? "";
                                },
                                validator: (value) {
                                  if (value!.isEmpty || value == null) {
                                    return tr("WorkingHoursInArabic");
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
                                height: 10,
                              ),
                              Text(
                                tr("WorkingHoursInEnglish"),
                                style: GoogleFonts.tajawal(),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: workingHoursEnControl,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                style: const TextStyle(fontSize: 15),
                                decoration: InputDecoration(
                                  hintText:   tr("WorkingHoursInEnglish"),

                                  errorStyle: const TextStyle(color: accentColor),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 17.0, horizontal: 10.0),
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
                                  hintStyle: const TextStyle(
                                      fontSize: 13, color: Color.fromRGBO(196, 196, 196, 1)),
                                ),
                                onChanged: (value) {
                                  if (value.isEmpty ||
                                      value == null ||
                                      !InputValidators()
                                          .nameValidator(name: value, context: context)) {
                                    setState(() {
                                      isWorkingHoursEn = true;
                                      workingHoursEn = value;
                                    });
                                  } else {
                                    setState(() {
                                      isWorkingHoursEn = false;
                                      workingHoursEn = value;
                                    });
                                  }
                                },
                                onSaved: (value) {
                                  workingHoursEn = value ?? "";
                                },
                                validator: (value) {
                                  if (value!.isEmpty || value == null) {
                                    return tr("WorkingHoursInEnglish");
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
                              const SizedBox(height: 100,)



                            ],
                          ),
                        ),
                      ),

                      SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10,right: 10),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20,),
                              Text(tr("BankAccountInformation"),
                                  style: GoogleFonts.tajawal(
                                      fontSize: 15, fontWeight: FontWeight.bold)),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                tr("BankName"),
                                style: GoogleFonts.tajawal(),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: bankNameControl,
                                // autovalidateMode: AutovalidateMode.onUserInteraction,
                                style: const TextStyle(fontSize: 15),
                                decoration: InputDecoration(
                                  // hintText: tr("BankName"),
                                  hintStyle: GoogleFonts.tajawal(
                                      fontSize: 12,
                                      color: const Color.fromRGBO(196, 196, 196, 1)),

                                  errorStyle: const TextStyle(color: accentColor),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 17.0, horizontal: 10.0),

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
                                onChanged: (value) {
                                  if (value.isEmpty ||
                                      value == null ||
                                      !InputValidators()
                                          .nameValidator(name: value, context: context)) {
                                    setState(() {
                                      isBankName = true;
                                      bankName = value;
                                    });
                                  } else {
                                    setState(() {
                                      isBankName = false;
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

                              Text(
                                tr("accountNumber"),
                                style: GoogleFonts.tajawal(),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller:accountNumberControl ,
                                keyboardType: TextInputType.number,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                style: const TextStyle(fontSize: 15),
                                decoration: InputDecoration(
                                  // hintText: tr("accountNumber"),
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
                                      isAccountNumber = true;
                                      accountNumber = value;
                                    });
                                  } else {
                                    setState(() {
                                      isAccountNumber = false;
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

                              Text(
                                tr("IBANNumber"),
                                style: GoogleFonts.tajawal(),
                              ),
                              const SizedBox(
                                height: 10,
                              ),

                              TextFormField(
                                controller: iBANNumberControl,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                style: const TextStyle(fontSize: 15),
                                decoration: InputDecoration(
                                  // hintText: tr("IBANNumber"),
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
                                      isIBANNumber = true;
                                      iBANNumber = value;
                                    });
                                  } else {
                                    setState(() {
                                      isIBANNumber = false;
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
                                height: 100,
                              ),
                            ],
                          ),
                        ),
                      ),

                    ]),
                  ),








              ],),
            )





        :  SizedBox(
              height: MediaQuery.of(context).size.height / 1.5,
              child: const Center(
                  child: CircularProgressIndicator()
              ),
            ),




          ]),

          isLoading==true?
              SizedBox(
                  height: MediaQuery.of(context).size.height/1,
                  child: const Center(child: CircularProgressIndicator()))
          :const SizedBox.shrink(),


          Align(alignment: AlignmentDirectional.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
              child: TextButton(
                style: TextButton.styleFrom(
                    fixedSize: Size(size.width, 55),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: samaOfficeColor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: samaOfficeColor),
                onPressed: () {

                  updateProfile();


                },
                child:  Text(
                  tr("EditAccount"),
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ),
            ),
          )






      ]),
    );
  }
}
