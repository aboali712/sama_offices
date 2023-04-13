import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:sama_offices/app.dart';
import 'package:sama_offices/src/auth/verify_code/verify_code_view.dart';


import '../../../core/cash/storage.helper.dart';
import '../../../core/network/network_service.dart';
import '../../../core/utils/helper_manager.dart';
import '../../home/home_core.dart';
import '../auth_model/auth_response.dart';
import '../auth_model/empty_response.dart';
import '../change_password/change_password_view.dart';


abstract class VerifyCodeViewModel extends State<VrifyCode> with StorageHelper {
  TextEditingController pinCodeControl = TextEditingController();
  String? currentText;
  bool isTimeOff = false;
  String pinCode = "";
  bool isLoading = false;
  final Dio dio = NetworkService.instance.dio;
  static String phone = "";
  static String pageType = "0";

  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 30;
  late CountdownTimerController controller =
      CountdownTimerController(endTime: endTime, onEnd: onEnd);

  void onEnd() {
    setState(() {
      isTimeOff = true;
    });
  }

  bool checkPinCode() {
    if (pinCode == "") {
      toastApp(tr("EnterTheVerificationCode"), context);
      return false;
    }
    if (pinCode.length < 4) {
      toastApp(tr("EnterTheValidVerificationCode"), context);
      return false;
    }

    return true;
  }

  Future<void> goToHomePage() async {
    pinCode = pinCodeControl.value.text;
    if (checkPinCode()) {
      verify();
    }
  }

  Future<void> verify() async {
    setState(() {
      isLoading = true;
    });
    var rs = await dio.post("v1/office/verify-code", data: Map.of({"code": pinCode}));
    var response = AuthResponse(rs.data!);


    if (response.status == 200) {
      await saveToken(response.token!);
      setState(() {
        isLoading = false;
      });
      toastAppSuccess(response.msg!, context);

      if (pageType == "0") {
        await saveUser(response.data!);

        SamaOfficesApp.navKey.currentState!.pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeCore()),
        );
      } else {
        SamaOfficesApp.navKey.currentState!.pushReplacement(
          MaterialPageRoute(builder: (context) => const ChangePassword()),
        );
      }
    } else {
      toastApp(response.msg!, context);
      setState(() {
        isLoading = false;
      });



    }
  }

  Future<void> resend() async {
    setState(() {
      isLoading = true;
    });
    var rs = await dio.post("v1/office/send-code", data: Map.of({"key": phone}));
    var response = EmptyResponse(rs.data!);

    if (response.status == 200) {
      toastAppSuccess(response.msg!, context);
      setState(() {
        isLoading = false;
      });
    } else {
      toastApp(response.msg!, context);
      setState(() {
        isLoading = false;
      });
    }
  }
}
