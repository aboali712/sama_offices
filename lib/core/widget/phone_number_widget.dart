import 'package:easy_localization/easy_localization.dart';
import 'package:flag/flag_enum.dart';
import 'package:flag/flag_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:keyboard_actions/keyboard_actions_config.dart';

import '../utils/input_validators.dart';
import '../values/colors.dart';

class PhoneNumberWidget extends StatefulWidget {
  final Function(String?)? onSaved;
  final String? Function(String?)? onChanged;
  final FocusNode? focusNode;
  final String? hintText;
  final String? phoneValue;
  final bool? phoneValidation;
  const PhoneNumberWidget(
      {Key? key,
        required this.onSaved,
        this.onChanged,
        this.focusNode,
        this.hintText,
        this.phoneValidation,
        this.phoneValue})
      : super(key: key);

  @override
  State<PhoneNumberWidget> createState() => _PhoneNumberWidgetState();
}

class _PhoneNumberWidgetState extends State<PhoneNumberWidget> {
  bool? flag;

  int textFieldLength = 11;
  String emptyTextField = "";
  var controller = TextEditingController();

  List<String> list = ['+965', '+20', '+966'];
  String dropdownValue = '+20';

  void checkOnSelectedCountryCode() {
    controller.clear();
    switch (dropdownValue) {
      case "+20":
        textFieldLength = 11;
        break;
      case "+966":
        textFieldLength = 9;
        break;
      case "+965":
        textFieldLength = 9;
        break;
    }
  }

  String getNumberWithoutFirstZero(String number) {
    if (number.isNotEmpty) {
      if (number[0] == '0') {
        return number.substring(1);
      } else {
        return number;
      }
    } else {
      return number;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData().copyWith(
        colorScheme: ThemeData().colorScheme.copyWith(
          primary: primaryColor,
        ),
      ),
      child: Theme(
        data: ThemeData().copyWith(
          colorScheme: ThemeData().colorScheme.copyWith(
            primary: primaryColor,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                height: 150,
                margin: widget.phoneValidation == true
                    ? const EdgeInsets.only(bottom: 19)
                    : const EdgeInsets.all(0),
                padding: const EdgeInsets.symmetric(vertical: 3.1),
                decoration: BoxDecoration(
                    color: /*widget.phoneValue!.isEmpty || widget.phoneValidation == true ? Colors.transparent :*/
                    klightGray,
                    border: /* widget.phoneValue!.isEmpty || widget.phoneValidation == true ? Border.all(
                        color: Color.fromRGBO(199, 199, 199, 1.0),width: .8
                    ) : */
                    Border.all(color: klightGray, width: .8),
                    borderRadius: const BorderRadius.all(Radius.circular(8))),
                alignment: Alignment.center,
                child: DropdownButtonHideUnderline(
                  child: ButtonTheme(
                    alignedDropdown: true,
                    child: DropdownButton<String>(
                      iconSize: 0.0,
                      isExpanded: true,
                      value: dropdownValue,
                      elevation: 16,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: /*dropdownValue == '+966' ?*/ 10),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue ?? "";
                          checkOnSelectedCountryCode();
                        });
                      },
                      items: list.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              value == '+966'
                                  ? SizedBox(
                                  width: 25,
                                  height: 25,
                                  child: Image.asset(
                                    "assets/icons/saudi.png",
                                    fit: BoxFit.fill,
                                  ))
                                  : SizedBox(
                                  width: 25,
                                  height: 25,
                                  child: Image.asset(
                                    "assets/icons/egypt.png",
                                    fit: BoxFit.fill,
                                  )),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(value),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 4,
            ),
            Expanded(
              flex: 5,
              child: Container(
                child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onTap: () {},
                    focusNode: widget.focusNode,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 17.0, horizontal: 10.0),
                      filled: true,
                      fillColor: widget.phoneValue!.isEmpty
                          ? Colors.transparent
                          : widget.phoneValidation == true
                          ? Colors.transparent
                          : klightGray,
                      labelStyle: GoogleFonts.tajawal(
                          color: widget.focusNode!.hasFocus
                              ? accentColor
                              : disabledTextColor),
                      errorStyle: const TextStyle(color: textError),
                      focusedBorder: widget.phoneValue!.isEmpty ||
                          widget.phoneValidation == true
                          ? OutlineInputBorder(
                        borderRadius:
                        const BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(
                          width: 1,
                          color: widget.focusNode!.hasFocus
                              ? accentColor
                              : disabledTextColor,
                        ),
                      )
                          : OutlineInputBorder(
                        borderRadius:
                        const BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(
                          width: 1,
                          color: klightGray,
                        ),
                      ),
                      disabledBorder: widget.phoneValue!.isEmpty ||
                          widget.phoneValidation == true
                          ? const OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(
                            width: .7, color: disabledTextColor),
                      )
                          : OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(8)),
                        borderSide:
                        BorderSide(width: .7, color: klightGray),
                      ),
                      enabledBorder: widget.phoneValue!.isEmpty ||
                          widget.phoneValidation == true
                          ? const OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(
                          width: .7,
                          color: Color.fromRGBO(196, 196, 196, 1),
                        ),
                      )
                          : OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(
                          width: .7,
                          color: klightGray,
                        ),
                      ),
                      border: widget.phoneValue!.isEmpty ||
                          widget.phoneValidation == true
                          ? const OutlineInputBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(
                            width: 1,
                          ))
                          : OutlineInputBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(8)),
                          borderSide:
                          BorderSide(width: 1, color: klightGray)),
                      errorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(width: .7, color: textError)),
                      focusedErrorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(width: .7, color: textError)),
                      //labelText: widget.hintText,
                      hintStyle: GoogleFonts.tajawal(
                          fontSize: 13,
                          color: const Color.fromRGBO(196, 196, 196, 1)),
                    ),
                    onChanged: widget.onChanged,
                    onSaved: (value) {
                      widget.onSaved!(dropdownValue.replaceAll("+", "") +
                          getNumberWithoutFirstZero(value ?? ""));
                    },
                    validator: (value) {
                      if (value!.isEmpty || value == null) {
                        return tr("PLS_FILL_PHONE");
                      } else if (!InputValidators().phoneNumberValidator(
                          phoneNumber: dropdownValue.replaceAll("+", "") +
                              getNumberWithoutFirstZero(value),
                          context: context)) {
                        return tr("INVALID_PHONE");
                      }
                    },
                    //maxLength: textFieldLength,
                    cursorColor: accentColor,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(11),
                      // if (denySpaces == true)
                      //   FilteringTextInputFormatter.deny(RegExp(r'\s'))
                    ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PhoneNumberSignUpWidget extends StatefulWidget {
  final Function(String?)? onSaved;
  final String? Function(String?)? onChanged;
  final FocusNode? focusNode;
  final String? hintText;
  final bool isPhone;
  TextEditingController? controllerPhone = TextEditingController();

  PhoneNumberSignUpWidget(
      {Key? key,
        required this.onSaved,
        this.onChanged,
        this.focusNode,
        this.controllerPhone,
        required this.isPhone,
        this.hintText})
      : super(key: key);

  @override
  State<PhoneNumberSignUpWidget> createState() =>
      PhoneNumberSignUpWidgetState();
}

class PhoneNumberSignUpWidgetState extends State<PhoneNumberSignUpWidget> {
  bool? flag;

  int textFieldLength = 11;
  String emptyTextField = "";

  List<String> list = ['+966', '+20', '+965'];
  static String dropdownValue = '+966';
  static String codePhone = '+966';

  void checkOnSelectedCountryCode() {
    //  widget.controllerPhone!.clear();
    switch (dropdownValue) {
      case "+20":
        textFieldLength = 11;
        break;
      case "+966":
        textFieldLength = 9;
        break;
      case "+965":
        textFieldLength = 9;
        break;
    }
  }

  String getNumberWithoutFirstZero(String number) {
    if (number.isNotEmpty) {
      if (number[0] == '0') {
        return number.substring(1);
      } else {
        return number;
      }
    } else {
      return number;
    }
  }

  KeyboardActionsConfig buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: Colors.grey[200],
      nextFocus: false,
      defaultDoneWidget: const Text(
        "Done",
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
      ),
      actions: [
        KeyboardActionsItem(
          focusNode: widget.focusNode!,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData().copyWith(
        colorScheme: ThemeData().colorScheme.copyWith(
          primary: primaryColor,
        ),
      ),
      child: Theme(
        data: ThemeData().copyWith(
          colorScheme: ThemeData().colorScheme.copyWith(
            primary: primaryColor,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: const Color(0xFFf5f9f9),
              ),
              alignment: Alignment.topCenter,
              width: (MediaQuery.of(context).size.width * 0.23),
              height: 50,
              child: DropdownButtonHideUnderline(
                child: ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_drop_down),
                    iconSize: 20,
                    elevation: 16,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: dropdownValue == '+966' ? 10 : 12),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue ?? "";
                        codePhone = dropdownValue;
                        checkOnSelectedCountryCode();
                      });
                    },
                    items: list.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                          value: value,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Flag.fromCode(
                                value == "+20"
                                    ? FlagsCode.EG
                                    : value == "+965"
                                    ? FlagsCode.KW
                                    : FlagsCode.SA,
                                height: 20,
                                width: 20,
                                fit: BoxFit.contain,
                              ),
                              Text(value),
                            ],
                          ));
                    }).toList(),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .64,
              height: 50,
              child: KeyboardActions(
                bottomAvoiderScrollPhysics:
                const NeverScrollableScrollPhysics(),
                config: buildConfig(context),
                child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: widget.controllerPhone,
                    onTap: () {},
                    focusNode: widget.focusNode,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      contentPadding: const EdgeInsets.only(
                          bottom: 15.0, top: 15, left: 3, right: 8),
                      filled: true,
                      fillColor: const Color(0xFFf5f9f9),
                      labelStyle: GoogleFonts.tajawal(
                          color: disabledTextColor, fontSize: 13),
                      floatingLabelStyle: const TextStyle(color: textGrayColor),
                      errorStyle: const TextStyle(color: textError),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                        const BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(width: 1, color: klightGray),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius:
                        const BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(width: .7, color: klightGray),
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
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(
                            width: 1,
                          )),
                      errorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide:
                          BorderSide(width: 0.7, color: accentColor)),
                      focusedErrorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide:
                          BorderSide(width: 0.7, color: accentColor)),
                      labelText: widget.hintText,
                      hintStyle: GoogleFonts.tajawal(
                          fontSize: 13,
                          color: const Color.fromRGBO(196, 196, 196, 1)),
                    ),
                    onChanged: widget.onChanged,
                    onSaved: (value) {
                      widget.onSaved!(getNumberWithoutFirstZero(value ?? ""));
                    },
                    validator: (value) {
                      if (value!.isEmpty || value == null) {
                        return tr("PLS_FILL_PHONE");
                      } else if (!InputValidators().phoneNumberValidator(
                          phoneNumber: value, context: context)) {
                        return tr("INVALID_PHONE");
                      }
                    },
                    // maxLength: textFieldLength,
                    cursorColor: accentColor,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(11),
                      // if (denySpaces == true)
                      //   FilteringTextInputFormatter.deny(RegExp(r'\s'))
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
