import 'package:get/get.dart';

import '../controllers/auth_phone_verify_controller.dart';

class AuthPhoneVerifyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthPhoneVerifyController>(
      () => AuthPhoneVerifyController(),
    );
  }
}
