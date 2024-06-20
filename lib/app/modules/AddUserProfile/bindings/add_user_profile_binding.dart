import 'package:get/get.dart';

import '../controllers/add_user_profile_controller.dart';

class AddUserProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddUserProfileController>(
      () => AddUserProfileController(),
    );
  }
}
