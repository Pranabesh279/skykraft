import 'package:get/get.dart';

import '../controllers/set_user_role_controller.dart';

class SetUserRoleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SetUserRoleController>(
      () => SetUserRoleController(),
    );
  }
}
