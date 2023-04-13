import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:keyboard_actions/keyboard_actions_config.dart';


import '../../../../core/utils/helper_manager.dart';
import '../../../../main.dart';
import '../../../auth/auth_model/empty_response.dart';
import 'contact_us_view.dart';

abstract class ContactUsViewModel extends State<ContactUs> {
  final FocusNode focusPhone = FocusNode();
  final TextEditingController controllerSubject = TextEditingController();
  final TextEditingController controllerMessage = TextEditingController();

  bool isLoading = false;

  bool checkValidation() {
    if (controllerSubject.value.text == "") {
      toastApp(tr("Subject"), context);
      return false;
    }
    if (controllerMessage.value.text == "") {
      toastApp(tr("yourInquiry"), context);
      return false;
    }
    return true;
  }

  Future<void> getSettingsDataApi() async {
    if (!checkValidation()) {
      return;
    }
    setState(() {
      isLoading = true;
    });
    final response = await dio.post("v1/office/sendContact",
        data: Map.of({
          "subject": controllerSubject.value.text,
          "message": controllerMessage.value.text
        }));

    var rs = EmptyResponse(response.data!);
    setState(() {
      isLoading = false;
    });
    if (rs.status == 200) {
      toastAppSuccess(rs.msg!,context);
      Navigator.pop(context);


    }
  }
}
