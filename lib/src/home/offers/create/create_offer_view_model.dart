import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/dialog/mult_select_dialog.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:sama_offices/app.dart';
import 'package:sama_offices/core/utils/helper_manager.dart';
import 'package:sama_offices/src/auth/auth_model/empty_response.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../core/widget/calender_dialog.dart';
import '../../../../main.dart';
import '../../../auth/signup/all_filter/cities_model.dart';
import '../../../auth/signup/all_filter/city_response.dart';
import '../../../auth/signup/all_filter/country_model.dart';
import '../../../auth/signup/all_filter/filter_model.dart';
import '../../../auth/signup/all_filter/filter_response.dart';
import 'create_offer.dart';

abstract class CreateOfferPageViewModel extends  State<CreateOfferPage>   with SingleTickerProviderStateMixin {

  TabController? tabControllerTitle;

  TextEditingController titleArController=TextEditingController();
  TextEditingController titleEnController=TextEditingController();
  HtmlEditorController controllerDetailsAr = HtmlEditorController();


  TextEditingController priceAfterController=TextEditingController();
  TextEditingController priceBeforeController=TextEditingController();


  HtmlEditorController controllerDetailsEn = HtmlEditorController();

  String? selectedOfficeBranch;
  String? selectedCityBranch;
  String? selectedOfficeBranchID;
  String selectedCityBranchID="";
  String startSelectedDate = '';
  String endSelectedDate = '';

  String countryId="";
  List<CityModel> cites =[];

  List<CountryModel> selectedCountry =[];
  List<String> selectedCountryId =[];
  List<CityModel> selectedCites =[];
  List<String> selectedCitesId =[];

  FilterModel? filterModel;
  List listStatues= [tr("Normal"),tr("Weekend")];
  String selectStatus=tr("Normal");
  bool isLoading=false;

  bool isVIP=false;


  var index=0;
  ImagePicker picker = ImagePicker();


  XFile? imageOffice;
  List<XFile>? images;
  var detailsAr="";
  var detailsEn="";

  int? type;
  String offerType="";
  TextEditingController numOfPersonControl=TextEditingController();
  bool isNumOfPerson=false;
  String numPerson="";

  TextEditingController numOfDaysControl=TextEditingController();
  bool isNumOfDays=false;
  String numDays="";


  TextEditingController numOfNightsControl=TextEditingController();
  bool isNumOfNights=false;
  String numNights="";

  @override
  void initState() {
   tabControllerTitle= TabController(length: 2, vsync: this);
   tabControllerTitle!.index=0;
   setState(() {
     startSelectedDate = DateFormat('yyyy-MM-dd',"en").format(DateTime.now());

     endSelectedDate = DateFormat('yyyy-MM-dd',"en")
         .format(DateTime.now().add(const Duration(days: 1)));
   });
   getFilterDataApi();
    super.initState();
  }
  void onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      startSelectedDate = DateFormat('yyyy-MM-dd',"en").format(args.value.startDate);

      endSelectedDate = DateFormat('yyyy-MM-dd',"en")
          .format(args.value.endDate ?? args.value.startDate);

    });

  }
  void selectDate(){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CalenderDialog(onSelectionChanged);

        });
  }
  Future<void> getFilterDataApi() async {
    Map<String, String> mp = {};



    final response = await dio.get("v1/filter", queryParameters: mp);

    var rs = FilterResponse(response.data!);
    if (rs.status == 200) {
      setState(() {
        filterModel = rs.data;
      });
    }

  }
  Future<void> getCityDataApi() async {
    Map<String, String> mp = {};
    selectedCountryId.asMap().forEach((index, value) =>  mp["countries[$index]"] = value);

      final response = await dio.get("v1/citiesByCountries",queryParameters: mp );

      var rs = CitiesResponse(response.data!);
      if (rs.status == 200) {
        setState(() {
          cites = rs.data!;
        });
      }
  }

  Future<void> addOfferApiCall() async {

    if(await checkData()){
      setState(() {
        isLoading=true;
      });

      Map<String, dynamic> mp = {};
      mp["type"]=selectStatus==tr("Normal")? "normal": "weekend";
      mp["name_ar"]=titleArController.value.text.toString();
      mp["name_en"]=titleEnController.value.text.toString();
      mp["description_ar"]=detailsAr;
      mp["description_en"]=detailsEn;
      mp["country_id"]=countryId;
      mp["is_vip"]= isVIP ? "1":"0";

      mp["city_id"]=selectedCityBranchID;
      mp["price_after"]=priceAfterController.value.text.toString();
      mp["price_before"]=priceBeforeController.value.text.toString();
      mp["start_date"]=startSelectedDate;
      mp["end_date"]=endSelectedDate;
      selectedCountryId.asMap().forEach((index, value) =>  mp["countries[$index]"] = value);
      selectedCitesId.asMap().forEach((index, value) =>  mp["cities[$index]"] = value);

      mp["offer_type"]=offerType;
      mp["num_of_persons"]=offerType=="group"? numOfPersonControl.value.text: 1;
      mp["num_of_days"]=numOfDaysControl.value.text;
      mp["num_of_nights"]=numOfNightsControl.value.text;




      images?.asMap().forEach((index, element) async {
         mp["images[$index]"]=
             await MultipartFile.fromFile(element.path, filename:element.path.split('/').last);
      });
      mp["image"]=
      await MultipartFile.fromFile(imageOffice!.path, filename:imageOffice!.path.split('/').last);


      final response = await dio.post("v1/office/offers", data: FormData.fromMap(mp));

      var rs = EmptyResponse(response.data!);
      setState(() {
        isLoading=false;
      });

      if (rs.status == 200) {
        setState(() {
          toastAppSuccess(rs.msg!, context);
          SamaOfficesApp.navKey.currentState!.pop(context);

        });
      }else{
        toastApp(rs.msg!, context);

      }
    }
  }
    Future<bool> checkData() async {


    if(titleArController.value.text.isEmpty){
      toastApp(tr("titleAr"), context);
      return false;
    }
    else if(titleEnController.value.text.isEmpty){
      toastApp(tr("titleEn"), context);
      return false;
    }
    else if(detailsAr.isEmpty){
      toastApp(tr("DescriptionAr"), context);
      return false;
    }
    else if(detailsEn.isEmpty){
      toastApp(tr("DescriptionEn"), context);
      return false;
    }
    else if(selectedCountryId.isEmpty){
      toastApp(tr("ChooseCountry"), context);
      return false;
    }
    else if(selectedCitesId.isEmpty){
      toastApp(tr("ChooseTheCity"), context);
      return false;
    }
    if(priceAfterController.value.text.isEmpty){
      toastApp(tr("PriceBefore"), context);
      return false;
    }
    if(priceBeforeController.value.text.isEmpty){
      toastApp(tr("PriceAfter"), context);
      return false;
    }

    if(startSelectedDate==''){
      toastApp(tr("ChooseDate"), context);
      return false;
    }
    if(imageOffice==null){
      toastApp(tr("MainImage"), context);
      return false;
    }
    if(images==null){
      toastApp(tr("OtherImages"), context);
      return false;
    }

    if(offerType==""){
      toastApp(tr("ChooseTheOfferType"), context);
      return false;
    }
    if(offerType=="group"){
      if(numOfPersonControl.text==""){
        toastApp(tr("EnterTheNumberOfGroupMembers"), context);
        return false;
      }


    }
    if(numDays==""){
      toastApp(tr("TheNumberOfDays"), context);
      return false;
    }
    if(numNights==""){
      toastApp(tr("TheNumberOfNights"), context);
      return false;
    }



    return true;
  }









}