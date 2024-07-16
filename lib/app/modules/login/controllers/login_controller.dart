import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skycraft/app/helpers/dailog_helper.dart';
import 'package:skycraft/app/models/auth/user_model.dart';
import 'package:skycraft/app/modules/locationPermission/controllers/location_permission_controller.dart';
import 'package:skycraft/app/modules/login/views/otp_view.dart';
import 'package:skycraft/app/providers/auth_provider.dart';
import 'package:skycraft/app/routes/app_pages.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;
  final AuthProvider _auth = Get.find<AuthProvider>();
  final phoneFormKey = GlobalKey<FormState>();
  final otpFormKey = GlobalKey<FormState>();
  final emailFormKey = GlobalKey<FormState>();
  RxBool isAggred = true.obs;

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
        Get.offAllNamed(Routes.ADD_USER_PROFILE);
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
        bool isLocationPermission =
            await LocationService.checkLocationPermission();
        if (isLocationPermission) {
          Get.offAllNamed(AppPages.MAIN);
        } else {
          Get.offAllNamed(Routes.LOCATION_PERMISSION);
        }
      } else {
        isLoading.value = false;
        Get.snackbar('Error', result);
      }
    }
  }

  Future signInWithGoogle() async {
    DialogHelper.showLoading();
    try {
      bool result = await _auth.signInWithGoogle();
      if (result == true) {
        UserModel? userModel = _auth.userModel.value;
        if (userModel?.name == null || userModel?.name == '') {
          Get.offAllNamed(Routes.ADD_USER_PROFILE);
        } else if (userModel?.role == null || userModel?.role == '') {
          Get.offAllNamed(Routes.SET_USER_ROLE);
        } else {
          bool isLocationPermission =
              await LocationService.checkLocationPermission();
          if (isLocationPermission) {
            Get.offAllNamed(AppPages.MAIN);
          } else {
            Get.offAllNamed(Routes.LOCATION_PERMISSION);
          }
        }
      } else {
        isLoading.value = false;
      }
    } finally {
      DialogHelper.hideLoading();
      // Get.offAll(Routes.SPLASH);
    }
  }
}
