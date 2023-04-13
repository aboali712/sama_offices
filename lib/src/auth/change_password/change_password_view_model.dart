import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sama_offices/app.dart';


import '../../../core/cash/storage.helper.dart';
import '../../../core/utils/helper_manager.dart';
import '../../../main.dart';
import '../auth_model/auth_response.dart';
import '../login/loginPage.dart';
import 'change_password_view.dart';

abstract class ChangePasswordViewModel extends State<ChangePassword> with StorageHelper{

  String password = "";
  bool isValidationPassword = false;
  var obscureTxt = true;

   String reEnterPassword="";
   bool isValidationReEnterPassword=false;
   bool isloading=false;

   bool validationChangePassword(){
     if(password==""){
       toastApp(tr("EnterPassword"), context);
       return false;
     }
     if(reEnterPassword==""){
       toastApp(tr("PleaseRe-enterYourPassword"), context);
       return false;
     }

     return true;
   }


   Future<void> changePassword() async {

     if(validationChangePassword()){
       setState(() {
         isloading=true;
       });
     var chp=await dio.post("v1/office/change-password",data:
     Map.of({"password":password,"password_confirmation":reEnterPassword}));
     var response = AuthResponse(chp.data!!);

     if(response.status==200){

       await saveToken("");
       toastAppSuccess(response.msg!,context);
       setState(() {
         isloading=false;
       });
       SamaOfficesApp.navKey.currentState!.pushReplacement(
         MaterialPageRoute(builder: (context) => const LoginPage()),

       );
     }

     }

   }




}