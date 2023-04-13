

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sama_offices/app.dart';


import '../../../core/cash/storage.helper.dart';
import '../../../core/network/network_service.dart';
import '../../../core/utils/helper_manager.dart';
import '../../../core/widget/phone_number_widget.dart';
import '../../../main.dart';
import '../../home/home_core.dart';
import '../auth_model/auth_response.dart';
import '../verify_code/verify_code_view.dart';
import '../verify_code/verify_code_view_model.dart';
import 'loginPage.dart';

abstract class LoginViewModel extends State<LoginPage> with StorageHelper{
  bool isLoading = false;
  bool isPhone = false;
  final FocusNode focusPhone = FocusNode();
  String phoneNumber = "";
  var obscureTxt = true;
  String password = "";
  bool isValidationError = false;
  bool phoneValidation = false;
  final Dio dio = NetworkService.instance.dio;



  bool chekValidationLogin(){
    if(phoneNumber==""){
      toastApp(tr("EnterMobile"), context);
      return false;
    }
    if(password==""){
      toastApp(tr("EnterPassword"), context);
      return false;
    }
    return true;
  }
  
  Future<void> checkLogin() async {
    
    if(chekValidationLogin()){
      setState(() {
        isLoading=true;
      });

      var ph = "";
      if (ph.startsWith("0")) {
        ph = phoneNumber.substring(1);
      }

      ph = PhoneNumberSignUpWidgetState.codePhone + phoneNumber;




      var lo=await dio.post("v1/office/login",data: Map.of({"key":ph,"password":password,"device_token":tokenDevice}));
      var response=AuthResponse(lo.data!!);

      if(response.status==200){
        toastAppSuccess(response.msg!, context);
       await saveUser(response.data!) ;
     await saveToken(response.token!);
        SamaOfficesApp.navKey.currentState!.pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeCore()),
        );
        setState(() {
          isLoading=false;
        });
      }else{

          toastApp(response.msg!, context);
          setState(() {
            isLoading=false;
          });

        if (response.status == 201) {
          VerifyCodeViewModel.phone = ph;
          VerifyCodeViewModel.pageType = "0";
          SamaOfficesApp.navKey.currentState!.pushReplacement(
            MaterialPageRoute(builder: (context) => const VrifyCode()),
          );
        }


      }
      
    }
    
  }
  
  


}