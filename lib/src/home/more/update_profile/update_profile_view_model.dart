
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:place_picker/entities/location_result.dart';
import 'package:place_picker/place_picker.dart';
import 'package:place_picker/widgets/place_picker.dart';
import 'package:sama_offices/app.dart';
import 'package:sama_offices/src/home/more/update_profile/updat_profile_view.dart';

import '../../../../core/cash/storage.helper.dart';
import '../../../../core/utils/helper_manager.dart';
import '../../../../core/widget/phone_number_widget.dart';
import '../../../../main.dart';
import '../../../auth/auth_model/auth_response.dart';
import '../../../auth/auth_model/user_model.dart';
import '../../../auth/signup/all_filter/cities_model.dart';
import '../../../auth/signup/all_filter/city_response.dart';
import '../../../auth/signup/all_filter/filter_model.dart';
import '../../../auth/signup/all_filter/filter_response.dart';
import '../../home_core.dart';

abstract class UpdateProfileViewModel extends State<UpdateProfile>
    with  SingleTickerProviderStateMixin, StorageHelper {
  TextEditingController firstNameControl = TextEditingController();
  TextEditingController secondNameControl = TextEditingController();
  TextEditingController phoneControl = TextEditingController();
  TextEditingController emailControl = TextEditingController();
  TextEditingController descriptionControl = TextEditingController();
  TextEditingController nameControl = TextEditingController();
  TextEditingController addressControl = TextEditingController();
  TextEditingController workHoursControl = TextEditingController();

  TextEditingController timeInControl = TextEditingController();
  TextEditingController timeOutControl = TextEditingController();
  TextEditingController hourTimeControl = TextEditingController();
  TextEditingController nameEnControl = TextEditingController();
  TextEditingController descriptionEnControl = TextEditingController();
  TextEditingController addressEnControl = TextEditingController();
  TextEditingController workingHoursEnControl = TextEditingController();
  TextEditingController bankNameControl = TextEditingController();
  TextEditingController accountNumberControl = TextEditingController();
  TextEditingController iBANNumberControl = TextEditingController();

  bool isValidationFirstName = false;
  String fName = "";
  bool isValidationSecondName = false;
  String sName = "";
  bool isPhone = false;
  String phoneNumber = "";
  final FocusNode focusPhone = FocusNode();

  bool isValidationEmail = false;
  String email = "";

  bool isDescription = false;
  String description = "";

  bool isName = false;
  String name = "";

  bool isAddress = false;
  String address = "";

  bool isWorkHour = false;
  String workHour = "";

  bool isNameEn = false;
  String nameEn = "";

  bool isDescriptionEn = false;
  String descriptionEn = "";

  bool isAddressEn = false;
  String addressEn = "";

  bool isWorkingHoursEn = false;
  String workingHoursEn = "";

  bool isBankName = false;
  String bankName = "";

  bool isAccountNumber = false;
  String accountNumber = "";

  bool isIBANNumber = false;
  String iBANNumber = "";

  // UserModel? userModel;
  ImagePicker picker = ImagePicker();

  XFile? imageUser;
  bool isLoading = false;
   UserModel? profileModel;
  LocationResult? result;

  String? selectedOfficeBranch;
  String selectedCityBranch="";
  FilterModel? filterModel;

  String? selectedOfficeBranchID;
  String selectedCityBranchID="";
  String countryId="";
  List<CityModel> cites =[];
  late List<FilterModel> items = [];

  TabController? tabController ;



  @override
  void initState() {
    super.initState();
    tabController =  TabController(length: 3, vsync: this, );
    tabController!.index=0;
    getFilterDataApi();
    getProfileDate().then((value) => setState((){
      String phoneCode="";
      firstNameControl.text=profileModel!.firstName.toString();
      secondNameControl.text=profileModel!.lastName.toString();
      emailControl.text=profileModel!.email.toString();


      if(profileModel!.phone!.startsWith("+2")){
        phoneCode=profileModel!.phone!.substring(0,3);
        phoneControl.text=profileModel!.phone!.substring(3);
      }
      else  if(profileModel!.phone!.startsWith("+9")){
        phoneCode=profileModel!.phone!.substring(0,4);
        phoneControl.text=profileModel!.phone!.substring(4);

      }
      PhoneNumberSignUpWidgetState.codePhone=phoneCode;

      PhoneNumberSignUpWidgetState.dropdownValue=phoneCode;

      descriptionControl.text=profileModel!.office!.description.toString();
      nameControl.text=profileModel!.office!.name.toString();
      addressControl.text=profileModel!.office!.address.toString();
      workHoursControl.text=profileModel!.office!.workingHours.toString();
      timeInControl.text=profileModel!.office!.start_work_at.toString();
      timeOutControl.text=profileModel!.office!.end_work_at.toString();
      nameEnControl.text=profileModel!.office!.name_en.toString();
      descriptionEnControl.text=profileModel!.office!.description_en.toString();
      addressEnControl.text=profileModel!.office!.address_en.toString();
      workingHoursEnControl.text=profileModel!.office!.working_hours_en.toString();
      bankNameControl.text=profileModel!.office!.paymentInfo!.bankName!;
      accountNumberControl.text=profileModel!.office!.paymentInfo!.bankAccount!;
      iBANNumberControl.text=profileModel!.office!.paymentInfo!.iban!;


    }));

  }





  Future<void> updateProfile() async {
    setState(() {
      isLoading = true;
    });
    Map<String,dynamic> formData={};
    if(imageUser!=null) {
      String imageUpdateUser = imageUser!
          .path
          .split('/')
          .last;
      formData["image"]=  await MultipartFile.fromFile(imageUser!.path, filename:imageUpdateUser);
    }
    formData["first_name"]=firstNameControl.value.text;
    formData["last_name"]=secondNameControl.value.text;
    formData["name_ar"]=nameControl.value.text;
    formData["description_ar"]=descriptionControl.value.text;
    formData["address_ar"]=addressControl.value.text;
    if(selectedOfficeBranchID==null){
        formData["country_id"]= profileModel!.office!.countryId!.toString();
    }else{
      formData["country_id"]= selectedOfficeBranchID;
    }
    if(selectedCityBranchID==""){
      formData["city_id"]= profileModel!.office!.cityId!.toString();
    }else{
      formData["city_id"]= selectedCityBranchID;
    }

    if(result==null){
      formData["lat"]= profileModel!.office!.lat!.toString();
      formData["lng"]= profileModel!.office!.lng!.toString();
    }else{
      formData["lat"]= result!.latLng!.latitude.toString();
      formData["lng"]=result!.latLng!.longitude.toString();
    }
    formData["start_work_at"]=timeInControl.value.text;
    formData["end_work_at"]=timeOutControl.value.text;
    formData["working_hours_ar"]=workHoursControl.value.text;
    formData["name_en"]=nameEnControl.value.text;
    formData["description_en"]=descriptionEnControl.value.text;
    formData["working_hours_en"]=workingHoursEnControl.value.text;
    formData["address_en"]=addressEnControl.value.text;
    formData["bank_name"]=bankNameControl.value.text;
    formData["bank_account"]=accountNumberControl.value.text;
    formData["iban"]=iBANNumberControl.value.text;

     var up= await dio.post("v1/office/updateProfile",data:formData );
    var rs=AuthResponse(up.data!);
    setState(() {
      isLoading = false;
    });

    if(rs.status==200){

      toastAppSuccess(rs.msg!,context);
      await saveUser(rs.data);
      SamaOfficesApp.navKey.currentState!.pushReplacement(
        MaterialPageRoute(builder: (context) =>  HomeCore()),
      );


    }else{
      toastAppSuccess(rs.msg!,context);

    }
  }


  Future<void> getProfileDate() async {

    final response = await dio.get("/v1/office/profile");
    var rs = AuthResponse(response.data!);

    if (rs.status == 200) {
      setState(() {
        profileModel = rs.data;
      });
    }
  }




  void showPlacePicker() async {

    var re = await Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => PlacePicker("AIzaSyBeAsv9F4ONue2XY9a6redv-o6rKxLuBGc")));
    setState(() {
      result=re;
      print(result);
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
