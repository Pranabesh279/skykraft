import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:get/get.dart';
import 'package:skycraft/app/helpers/snackbar.dart';

class AuthPhoneVerifyController extends GetxController {
  Rx<String> phone = ''.obs;
  Rx<String?> countryCode = '+91'.obs;
  Rx<String> otp = ''.obs;
  late Rx<User?> firebaseUser;
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

  Future<void> verifyOTP() async {}
}
