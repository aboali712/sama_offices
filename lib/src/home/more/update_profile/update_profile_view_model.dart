
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sama_offices/app.dart';
import 'package:sama_offices/src/home/more/update_profile/updat_profile_view.dart';

import '../../../../core/cash/storage.helper.dart';
import '../../../../core/utils/helper_manager.dart';
import '../../../../core/widget/phone_number_widget.dart';
import '../../../../main.dart';
import '../../../auth/auth_model/auth_response.dart';
import '../../../auth/auth_model/user_model.dart';
import '../../home_core.dart';

abstract class UpdateProfileViewModel extends State<UpdateProfile>
    with StorageHelper {
  TextEditingController firstNameControl = TextEditingController();
  TextEditingController secondNameControl = TextEditingController();
  TextEditingController phoneControl = TextEditingController();
  TextEditingController emailControl = TextEditingController();

  bool isValidationFirstName = false;
  String fName = "";
  bool isValidationSecondName = false;
  String sName = "";
  bool isPhone = false;
  String phoneNumber = "";
  final FocusNode focusPhone = FocusNode();

  bool isValidationEmail = false;
  String email = "";

  UserModel? userModel;
  ImagePicker picker = ImagePicker();

  XFile? imageUser;
  bool isLoading = false;

  @override
  void initState() {
    getUser().then((value) => setState(() {
          userModel = value!;
          String phoneCode="";
          firstNameControl.text=userModel!.firstName!;
          secondNameControl.text=userModel!.lastName!;
          emailControl.text=userModel!.email!;
          fName=firstNameControl.value.text.toString();
          sName=secondNameControl.value.text.toString();

          if(userModel!.phone!.startsWith("+2")){
            phoneCode=userModel!.phone!.substring(0,3);
            phoneControl.text=userModel!.phone!.substring(3);
          }
          else  if(userModel!.phone!.startsWith("+9")){
            phoneCode=userModel!.phone!.substring(0,4);
            phoneControl.text=userModel!.phone!.substring(4);

          }
          PhoneNumberSignUpWidgetState.codePhone=phoneCode;

          PhoneNumberSignUpWidgetState.dropdownValue=phoneCode;
        }));

    super.initState();
  }


  bool checkUpdate(){

    if(fName==""){
      toastApp(tr("EnterFirstName"),context);
      return false;
    }
    if(sName==""){
      toastApp(tr("EnterLastName"),context);
      return false;
    }
    return true;
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


     var up= await dio.post("v1/update-profile",data:FormData.fromMap(formData) );
    setState(() {
      isLoading = false;
    });

    if(up.statusCode==200){
      var rs=AuthResponse(up.data!);
      toastAppSuccess(rs.msg!,context);
      await saveUser(rs.data);
      SamaOfficesApp.navKey.currentState!.pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeCore()),
      );


    }
  }
}
