import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/values/colors.dart';
import 'create_offer_view_model.dart';

class CreateOfferPage extends StatefulWidget {
  const CreateOfferPage({Key? key}) : super(key: key);

  @override
  State<CreateOfferPage> createState() => _CreateOfferPageState();
}

class _CreateOfferPageState extends CreateOfferPageViewModel {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: yellowColor,
        /* set Status bar color in Android devices. */
        statusBarIconBrightness: Brightness.dark,
        /* set Status bar icons color in Android devices.*/
        statusBarBrightness: Brightness.dark));
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [
        Column(
          children: [
            Container(
              color: yellowColor,
              width: size.width,
              height: 100,
              child: Align(
                alignment: AlignmentDirectional.centerEnd,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back_ios,
                          size: 20,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        tr("CreatePackage"),
                        style: GoogleFonts.tajawal(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: size.width - 100,
                        child: TabBar(
                          labelColor: textColor,
                          indicatorColor: Colors.white70,
                          unselectedLabelColor: textGrayColor,
                          tabs: [
                            Tab(
                              child: Text(
                                tr("titleAr"),
                                style: const TextStyle(fontSize: 13),
                              ),
                            ),
                            Tab(
                              child: Text(
                                tr("titleEn"),
                                style: const TextStyle(fontSize: 13),
                              ),
                            ),
                          ],
                          controller: tabControllerTitle,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        width: size.width,
                        height: 50,
                        child: TabBarView(
                          controller: tabControllerTitle,
                          children: [
                            TextField(
                              decoration: InputDecoration(
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
                                  borderSide:
                                      BorderSide(width: .7, color: klightGray),
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
                                filled: true,
                                hintStyle: const TextStyle(
                                    color: textGrayColor, fontSize: 15),
                                hintText: tr("TypeHere"),
                              ),
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 15),
                              controller: titleArController,
                            ),
                            TextField(
                              decoration: InputDecoration(
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
                                  borderSide:
                                      BorderSide(width: .7, color: klightGray),
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
                                filled: true,
                                hintStyle: const TextStyle(
                                    color: textGrayColor, fontSize: 15),
                                hintText: tr("TypeHere"),
                              ),
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 15),
                              controller: titleEnController,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ExpansionTile(
                        collapsedBackgroundColor: const Color(0XFFFFF8E0),
                        backgroundColor: const Color(0XFFFFF8E0),
                        title: Text(
                          tr("DescriptionAr"),
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: textColor,
                              height: 2),
                        ),
                        children: [
                          Container(
                            height: 400,
                            margin: const EdgeInsets.all(10),
                            width: size.width,
                            color: const Color(0xFFf5f9f9),
                            child:

                            HtmlEditor(
                              controller: controllerDetailsAr, //required
                              callbacks: Callbacks(
                                  onBeforeCommand: (String? currentHtml) {},
                                  onChangeContent: (String? changed) {
                                    setState(() {
                                      detailsAr = changed!;
                                    });
                                  }),
                              htmlEditorOptions: HtmlEditorOptions(
                                  hint: tr("TypeHere"), initialText: detailsAr
                                  //initalText: "text content initial, if any",
                                  ),
                              htmlToolbarOptions: const HtmlToolbarOptions(
                                  toolbarPosition:
                                      ToolbarPosition.aboveEditor, //by default
                                  toolbarType: ToolbarType.nativeExpandable),
                              otherOptions: const OtherOptions(
                                height: 400,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ExpansionTile(
                        collapsedBackgroundColor: const Color(0XFFFFF8E0),
                        backgroundColor: const Color(0XFFFFF8E0),
                        title: Text(
                          tr("DescriptionEn"),
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: textColor,
                              height: 2),
                        ),
                        children: [
                          Container(
                            height: 400,
                            margin: const EdgeInsets.all(10),
                            width: size.width,
                            color: Colors.white,
                            child: HtmlEditor(
                              controller: controllerDetailsEn, //required
                              callbacks: Callbacks(
                                  onBeforeCommand: (String? currentHtml) {},
                                  onChangeContent: (String? changed) {
                                    setState(() {
                                      detailsEn = changed!;
                                    });
                                  }),
                              htmlEditorOptions: HtmlEditorOptions(
                                  hint: tr("TypeHere"),
                                  initialText: detailsEn,

                                  //initalText: "text content initial, if any",
                                  ),
                              htmlToolbarOptions: const HtmlToolbarOptions(
                                  toolbarPosition:
                                      ToolbarPosition.aboveEditor, //by default
                                  toolbarType: ToolbarType.nativeExpandable),
                              otherOptions: const OtherOptions(
                                height: 400,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TypeAheadField<String>(
                        textFieldConfiguration: TextFieldConfiguration(
                          controller:
                              TextEditingController(text: selectedOfficeBranch),
                          autofocus: false,
                          style: GoogleFonts.tajawal(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 15),
                          decoration: InputDecoration(
                            fillColor: const Color(0xFFf5f9f9),
                            filled: true,
                            hintStyle: GoogleFonts.tajawal(fontSize: 14),
                            hintText: tr('ChooseCountry'),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8)),
                              borderSide:
                                  BorderSide(width: 1, color: klightGray),
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
                                .firstWhere(
                                    (element) => element.name == suggestion)
                                .id
                                .toString();
                            countryId = selectedOfficeBranchID!;
                            selectedCityBranch = "";
                            selectedCityBranchID="";
                            getCityDataApi();
                          });
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TypeAheadField<String>(
                        textFieldConfiguration: TextFieldConfiguration(
                          controller:
                              TextEditingController(text: selectedCityBranch),
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
                              borderSide:
                                  BorderSide(width: 1, color: klightGray),
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
                          return cites.map((e) => e.name!).toList().where(
                              (item) => item
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
                                .firstWhere(
                                    (element) => element.name == suggestion)
                                .id
                                .toString();
                          });
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        tr("ChoosePackageType"),
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: textColor),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      DropdownButtonFormField2(
                        decoration: InputDecoration(
                          hintText: tr("SubscriptionPlan"),
                          hintStyle: GoogleFonts.tajawal(
                              fontSize: 12,
                              color: const Color.fromRGBO(196, 196, 196, 1)),
                          errorStyle: const TextStyle(color: accentColor),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 7.0, horizontal: 10.0),
                          filled: true,
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
                        ),
                        items: listStatues
                            .map((e) => e)
                            .toList()
                            .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: GoogleFonts.tajawal(
                                        fontSize: 14, color: Colors.black),
                                  ),
                                ))
                            .toList(),
                        value: selectStatus,
                        onChanged: (value) {
                          setState(() {
                            selectStatus = value as String;
                          });
                        },
                        buttonHeight: 40,
                        buttonWidth: double.infinity,
                        itemHeight: 40,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: priceBeforeController,
                        style: const TextStyle(fontSize: 15),
                        decoration: InputDecoration(
                          hintText: tr("PriceBefore"),
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
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.text,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: priceAfterController,
                        style: const TextStyle(fontSize: 15),
                        decoration: InputDecoration(
                          hintText: tr("PriceAfter"),
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
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.text,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        tr('ChooseDate'),
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: samaColor),
                      ),
                      Center(
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.only(top: 10, bottom: 10),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  const Color(0xFFF5F9F9)),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: const BorderSide(
                                    color: samaColor,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                            ),
                            child: Text(
                              startSelectedDate != ''
                                  ? "$startSelectedDate - $endSelectedDate"
                                  : tr('chooseDate'),
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: samaColor),
                            ),
                            onPressed: () {
                              selectDate();
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(tr("MainImage"),
                          style: GoogleFonts.tajawal(fontSize: 15)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: greenBlueIconColor,
                                  fixedSize: const Size(150, 35)),
                              onPressed: () async {
                                imageOffice = (await picker.pickImage(
                                    source: ImageSource.gallery));
                                setState(() {});
                              },
                              child: Text(
                                tr("MainImage"),
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
                        height: 15,
                      ),
                      Text(tr("OtherImages"),
                          style: GoogleFonts.tajawal(fontSize: 15)),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              picker.pickMultiImage().then((value) => {
                                    setState(() {
                                      images = value;
                                    })
                                  });
                            },
                            child: Container(
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                    color: greenBlueIconColor,
                                    border: Border.all(
                                      color: greenBlueIconColor,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10))),
                                child: const Icon(
                                  Icons.cloud_upload_outlined,
                                  color: Colors.white,
                                  size: 35,
                                )),
                          ),
                          images != null
                              ? SizedBox(
                                  height: 70,
                                  width:
                                      MediaQuery.of(context).size.width - 130,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return CircleAvatar(
                                          radius: 40,
                                          backgroundImage: Image.file(
                                                  File(images![index].path))
                                              .image);
                                    },
                                    itemCount: images!.length,
                                  ),
                                )
                              : const SizedBox.shrink()
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        isLoading
        ?const Center(child: CircularProgressIndicator(),)
            :const SizedBox.shrink()
      ]),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(30.0),
        child: TextButton(
            style: TextButton.styleFrom(
                fixedSize: Size(size.width - 100, 55),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: const BorderSide(color: profile)),
                backgroundColor: profile),
            onPressed: () {
              addOfferApiCall();
            },
            child: Text(
              tr("CreatePackage"),
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            )),
      ),
    );
  }
}
