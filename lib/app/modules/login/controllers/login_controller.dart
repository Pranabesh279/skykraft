import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skycraft/app/modules/login/views/otp_view.dart';
import 'package:skycraft/app/providers/auth_provider.dart';
import 'package:skycraft/app/routes/app_pages.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;
  final AuthProvider _auth = Get.find<AuthProvider>();
  final phoneFormKey = GlobalKey<FormState>();
  final otpFormKey = GlobalKey<FormState>();
  final emailFormKey = GlobalKey<FormState>();

  // final scaffoldKey = GlobalKey<ScaffoldState>();
  FocusNode otpFocusNode = FocusNode();
  final TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController get phoneNumberController => _phoneNumberController;
  String get phoneNumber => _phoneNumberController.text.trim();
  TextEditingController otpController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  RxBool isChecked = RxBool(true);
  RxBool isOtpSent = RxBool(false);

  RxBool isViewSignUp = RxBool(false);

  void sendOtp() {
    isOtpSent.value = true;
    otpFocusNode.requestFocus();
    Get.to(() => const OtpView());
  }

  void verifyOtp() {
    otpFocusNode.unfocus();
    submit();
  }

  void submit() {
    Get.offAllNamed(AppPages.MAIN);
  }

  void signUp() async {
    if (emailFormKey.currentState!.validate()) {
      isLoading.value = true;
      String result = await _auth.signUpUser(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        name: usernameController.text.trim(),
        phone: phoneNumber,
        username: usernameController.text.trim(),
      );
      if (result == 'success') {
        isLoading.value = false;
        Get.offAllNamed(Routes.SET_USER_ROLE);
      } else {
        isLoading.value = false;
        Get.snackbar('Error', result);
      }
    }
  }

  void signIn() async {
    if (emailFormKey.currentState!.validate()) {
      isLoading.value = true;
      String result = await _auth.logInUser(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      if (result == 'success') {
        isLoading.value = false;
        Get.offAllNamed(AppPages.MAIN);
      } else {
        isLoading.value = false;
        Get.snackbar('Error', result);
      }
    }
  }
}
