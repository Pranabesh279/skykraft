import 'package:get/get.dart';
import 'package:skycraft/app/models/auth/user_model.dart';

import '../controllers/bio_controller.dart';

class BioBinding extends Bindings {
  UserModel? user;
  BioBinding({this.user});
  @override
  void dependencies() {
    Get.lazyPut<BioController>(
      () => BioController(user: user),
    );
  }
}
