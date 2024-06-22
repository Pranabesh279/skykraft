import 'package:get/get.dart';
import 'package:skycraft/app/modules/home/controllers/home_controller.dart';
import 'package:skycraft/app/modules/profile/controllers/profile_controller.dart';

import '../controllers/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(
      () => DashboardController(),
    );
  }
}
