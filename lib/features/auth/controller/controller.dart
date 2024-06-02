import 'package:assignment/utils/colors.dart';
import 'package:assignment/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:assignment/components/snackbar.dart';

class LoginController extends GetxController {
  TextEditingController mobileController = TextEditingController();
  TextEditingController passController = TextEditingController();

  final String validMobile = MyStrings.authNo;
  final String validPassword = MyStrings.authPass;

  void login() {
    String mobile = mobileController.text;
    String password = passController.text;

    if (mobile.isEmpty && password.isEmpty) {
      Components.showSnackBar(
          Get.context!, MyStrings.mobileAndPassReq, MyColors.orange);
    } else if (mobile.isEmpty) {
      Components.showSnackBar(
          Get.context!,MyStrings.entrYourPass, MyColors.orange);
    } else if (password.isEmpty) {
      Components.showSnackBar(
          Get.context!, MyStrings.entrYourPass, MyColors.orange);
    } else if (mobile.length != 10) {
      Components.showSnackBar(
          Get.context!, MyStrings.entrYour10DigitPass, MyColors.orange);
    } else if (mobile == validMobile && password == validPassword) {
      Components.showSnackBar(
          Get.context!, MyStrings.loginSuccessDone, MyColors.green);
      Get.offNamed('/HomeScreen');
    } else {
      Components.showSnackBar(Get.context!, MyStrings.invalidCre, MyColors.red);
    }
  }
}
