import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sama_offices/app.dart';

import '../../../core/cash/storage.helper.dart';
import '../../../core/utils/helper_manager.dart';
import '../../../core/widget/phone_number_widget.dart';
import '../../../main.dart';

import '../auth_model/empty_response.dart';
import '../verify_code/verify_code_view.dart';
import '../verify_code/verify_code_view_model.dart';
import 'forget_password_view.dart';

abstract class ForgetPasswordViewModel extends State<ForgetPassword>
    with StorageHelper {
  bool isPhone = false;
  String phoneNumber = "";
  final FocusNode focusPhone = FocusNode();
  bool isloading = false;

  bool checkValidationForgetPassword() {
    print(phoneNumber);
    if (phoneNumber == "") {
      toastApp(tr("EnterMobile"), context);
      return false;
    }

    return true;
  }

  Future<void> checkForgetPassword() async {
    if (checkValidationForgetPassword()) {
      var ph="";
      if (ph.startsWith("0")) {
        ph = phoneNumber.substring(1);
      }

      ph = PhoneNumberSignUpWidgetState.codePhone + phoneNumber;
      setState(() {
        isloading = true;
      });

      var rs =
          await dio.post("v1/office/send-code", data: Map.of({"key": ph}));
      var response = EmptyResponse(rs.data!);

      if (response.status == 201) {
        toastAppSuccess(response.msg!, context);
        VerifyCodeViewModel.pageType = "1";
        VerifyCodeViewModel.phone = ph;

        SamaOfficesApp.navKey.currentState!.pushReplacement(
          MaterialPageRoute(builder: (context) => const VrifyCode()),
        );
        setState(() {
          isloading = false;
        });
      } else {

        toastApp(response.msg!, context);
        setState(() {
          isloading = false;
        });
      }
    }
  }
}
