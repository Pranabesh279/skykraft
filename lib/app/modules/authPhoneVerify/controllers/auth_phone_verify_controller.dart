import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:skycraft/app/helpers/snackbar.dart';
import 'package:skycraft/app/providers/auth_provider.dart' as auth;
import 'package:skycraft/app/routes/app_pages.dart';

class AuthPhoneVerifyController extends GetxController {
  Rx<String> phone = ''.obs;
  Rx<String?> countryCode = '+91'.obs;
  Rx<String> otp = ''.obs;
  Rx<bool> isVerifing = false.obs;

  RxBool codeSent = RxBool(false);
  RxString verificationCode = RxString('');
  RxBool isSending = RxBool(false);
  Timer? _timer;
  Rx<Duration> duration = Rx<Duration>(const Duration(seconds: 60));

  @override
  void onInit() {
    super.onInit();
    log('AuthPhoneVerifyController onInit');
    // arguments from AuthPhoneController
    log(Get.arguments.toString());
    phone.value = Get.arguments['phone'] as String? ?? "";
    countryCode.value = Get.arguments['countryCode'] ?? "+91";
    String flullPhone = (countryCode.value ?? "") + phone.value;
    verifyPhone(flullPhone);
  }

  _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      duration.value = duration.value - const Duration(seconds: 1);
      if (duration.value.inSeconds == 0) {
        codeSent.value = false;
        duration.value.inMinutes;
        _timer?.cancel();
        duration.value = const Duration(seconds: 60);
      }
    });
  }

  static String twoDigits(num n) => n.toString().padLeft(2, '0');
  String minutes() => twoDigits(duration.value.inMinutes.remainder(60));
  String seconds() => twoDigits(duration.value.inSeconds.remainder(60));

  Future<void> verifyPhone(phoneNo) async {
    isSending.value = true;
    verified(authResult) async {
      snackbar(
        title: 'OTP sent',
        message: 'Send successfully',
        type: SnackbarType.success,
      );
    }

    verificationfailed(Exception authException) {
      snackbar(
          title: 'Try Again',
          message: 'something went wrong',
          type: SnackbarType.error);
    }

    smsSent(String verId, [forceResend]) {
      codeSent.value = true;
      isSending.value = false;
      verificationCode.value = verId;
      _startTimer();
    }

    autoTimeout(String verId) {
      verificationCode.value = verId;
    }

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: const Duration(seconds: 60),
        verificationCompleted: verified,
        verificationFailed: verificationfailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }

  void continueClicked() async {
    isVerifing.value = true;
    try {
      bool isVerifyedResult = await Get.find<auth.AuthProvider>()
          .signInWithOTP(verificationCode.value, otp.value, phone: phone.value);
      if (isVerifyedResult) {
        Get.offAllNamed(Routes.ADD_USER_PROFILE);
      } else {
        snackbar(
            title: 'Verification Error',
            message: 'Please enter valid OTP',
            type: SnackbarType.error);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isVerifing.value = false;
    }
  }
}
