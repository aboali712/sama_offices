import 'package:flutter/material.dart';

class InputValidators {
  bool passwordValidator({String? password, required BuildContext context}) {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (password == null || password.isEmpty) {
      return false;
    } else if (password.length < 6) {
      return false;
    }
    return true;
  }

  bool emailValidator({String? email, required BuildContext context}) {
    const String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    final RegExp regExp = RegExp(pattern);

    if (email == null || email.isEmpty) {
      // showErrorDialog(
      //   context: context,
      //   errorMessage: 'Please fill the Email',
      // );
      return false;
    } else if (!regExp.hasMatch(email)) {
      //   errorMessage: 'Please enter a valid email.',
      // showErrorDialog(
   //   context: context,
      // );
      return false;
    }
    return true;
  }

  bool signInPasswordValidator(
      {String? password, required BuildContext context}) {
    if (password == null || password.isEmpty) {
      return false;
    } else if (password.length < 8) {
      return false;
    }
    return true;
  }

  bool nameValidator({String? name, required BuildContext context}) {
    if (name == null || name.isEmpty) {
      return false;
    } else if (name.length < 3) {
      return false;
    } else {
      return true;
    }
  }
  bool textValidator({String? name, required BuildContext context}) {
    if (name == null || name.isEmpty) {
      return false;
    } else if (name.isEmpty) {
      return false;
    } else {
      return true;
    }
  }
  bool phoneNumberValidator(
      {String? phoneNumber, required BuildContext context}) {
    if (phoneNumber == null || phoneNumber.isEmpty) {
      // showErrorDialog(
      //     errorMessage: 'Please fill a Phone Number', context: context);
      return false;
    } else if (phoneNumber.length < 7 || phoneNumber.length > 14) {
      // showErrorDialog(
      //   errorMessage: 'Length of phone number must be equal to 10',
      //   context: context,
      // );
      return false;
    } else {
      return true;
    }
  }

}
