
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:place_picker/entities/location_result.dart';
import 'package:place_picker/widgets/place_picker.dart';
import 'package:sama_offices/src/auth/signup/all_filter/cities_model.dart';
import 'package:sama_offices/src/auth/signup/all_filter/service_model.dart';
import 'package:sama_offices/src/auth/signup/sinup_view.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../../app.dart';
import '../../../core/network/network_service.dart';
import '../../../core/utils/helper_manager.dart';
import '../../../core/widget/phone_number_widget.dart';
import '../auth_model/empty_response.dart';
import '../verify_code/verify_code_view.dart';
import '../verify_code/verify_code_view_model.dart';
import 'all_filter/city_response.dart';
import 'all_filter/filter_model.dart';
import 'all_filter/filter_response.dart';
import 'package:http/http.dart' as http;

import 'package:http_parser/http_parser.dart';


abstract class SignUpViewModel extends State<SignUpPage>{

  bool isLoading = false;
  bool isPhone = false;
  bool isPassword = false;


  final FocusNode focusPhone = FocusNode();
  final Dio dio = NetworkService.instance.dio;

  String phoneNumber = "";
  var obscureTxt = true;
  String password = "";
  bool isValidationPassword = false;
  bool phoneValidation = false;
  bool isValidationName=false;
  String name="";

  bool isValidationEmail=false;
  String email="";
  bool terms = false;
  int currentStep = 0;



  bool isValidationAddressBranch=false;
  String addressBranch="";
  bool isValidationTimeBranch=false;
  String timeBranch="";
  bool lastField=true;

  bool isValidationBankName=false;
  String bankName="";
  bool isValidationAccountNumber=false;
  String accountNumber="";
  bool isValidationIBANNumber=false;
  String iBANNumber="";
  bool isValidationSubscriptionPlan=false;
  String subscriptionPlan="";





  late List<FilterModel> items = [];

  String? selectedOfficeBranch;
  String? selectedCityBranch;
  String? selectedSubscriptionPlan;

  FilterModel? filterModel;
  SfRangeValues values = const SfRangeValues(40.0, 80.0);

  String countryId="";
  List<CityModel> cites =[];
  late  List<ServiceModel> selectServices = [];
  LocationResult? result;




  String? selectedOfficeBranchID;
  String? selectedCityBranchID;
  String? selectedPlanID;


  ImagePicker picker = ImagePicker();

  XFile? imageOffice;
  XFile? imageCommercial;





  void showPlacePicker() async {

      var re = await Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => PlacePicker("AIzaSyBeAsv9F4ONue2XY9a6redv-o6rKxLuBGc")));
      setState(() {
        result=re;
      print(result);
    });

  }


  @override
  void initState() {
    getFilterDataApi();
    getCityDataApi();
    super.initState();
  }

  bool checkValidationRegister(){

    if(name==""){
      toastApp(tr("EnterTheOfficeName"),context);
      return false;
    }

    if(phoneNumber==""){
      toastApp(tr("PleaseEnterTheMobileNumber"),context);
      return false;
    }
    if(email==""){
      toastApp(tr("EnterEmail"),context);
      return false;
    }

    if(password==""){
      toastApp(tr("EnterPassword"),context);
      return false;
    }
    if(selectedOfficeBranch==null){
      toastApp(tr("ChooseTheOfficeBranch"),context);
      return false;
    }
    if(selectedCityBranch==null){
      toastApp(tr("ChooseTheCity"),context);
      return false;
    }
    if(result==null){
      toastApp(tr("ChooseAddressFrom"),context);
      return false;
    }
    if(addressBranch==""){
      toastApp(tr("EnterTheAddress"),context);
      return false;
    }
    if(timeBranch==""){
      toastApp(tr("EnterBusinessHours"),context);
      return false;
    }
    if(imageOffice==null){
      toastApp(tr("ChooseTheOfficeLogo"),context);
      return false;
    }
    if(imageCommercial==null){
      toastApp(tr("ChooseTheCommercialRegistry"),context);
      return false;
    }
    if(selectServices.length==0){
      toastApp(tr("ChooseServices"),context);
      return false;
    }
    if(bankName==""){
      toastApp(tr("EnterTheNameOfTheBank"),context);
      return false;
    }
    if(accountNumber==""){
      toastApp(tr("EnterTheAccountNumber"),context);
      return false;
    }
    if(iBANNumber==""){
      toastApp(tr("EnterTheIBANNumber"),context);
      return false;
    }
    if(selectedSubscriptionPlan==null){
      toastApp(tr("ChooseTheSubscriptionPlan"),context);
      return false;
    }




    return true;
  }

  
  Future<void> registerCallApi() async {





    var ph="";
    if (ph.startsWith("0")) {
      ph = phoneNumber.substring(1);
    }

    ph = PhoneNumberSignUpWidgetState.codePhone + phoneNumber;

    //+201030025254
    setState(() {
      isLoading=true;
    });



    String imageOfficeName = imageOffice!.path.split('/').last;
    String imageCommercialName = imageCommercial!.path.split('/').last;
    Map<String,dynamic> mp={};
    mp["name"]=name;
    mp["email"]=email;
    mp["phone"]=ph;
    mp["password"]=password;
    mp["country_id"]=countryId;
    mp["city_id"]=selectedCityBranchID.toString();
    mp["plan_id"]=selectedPlanID.toString();
    mp["address"]=addressBranch;
    mp["office_name"]=name;
    mp["lat"]=result!.latLng!.latitude.toString();
    mp["lng"]=result!.latLng!.longitude.toString();
    mp["bank_name"]=bankName;
    mp["bank_account"]=accountNumber;
    mp["iban"]=iBANNumber;
    mp["working_hours"]=timeBranch;




    selectServices.asMap().forEach((index, element)  {mp[ "services[$index]"] =element.id.toString(); });


      mp["image"]=
      await MultipartFile.fromFile(imageOffice!.path, filename:imageOfficeName);

      mp["commercial_registeration_no"]=await MultipartFile.fromFile(imageCommercial!.path, filename:imageCommercialName);








    var rs = await dio.post("v1/office/register",data:FormData.fromMap(mp));
    var response = EmptyResponse(rs.data!!);

    if(response.status==201){
      VerifyCodeViewModel.phone=ph;
      VerifyCodeViewModel.pageType="0";
      toastAppSuccess(response.msg!,context);
      SamaOfficesApp.navKey.currentState!.pushReplacement(
        MaterialPageRoute(builder: (context) => const VrifyCode()),
      );
      setState(() {
        isLoading=false;
      });
    }else{
      toastApp(response.msg!,context);
      setState(() {
        isLoading=false;
      });
    }
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
      mp["country_id"]=countryId;


    final response = await dio.get("v1/cities", queryParameters: mp);

    var rs = CitiesResponse(response.data!);
    if (rs.status == 200) {
      setState(() {

        cites = rs.data!;




      });
    }

  }









}