import 'package:get/get.dart';
import 'package:skycraft/app/models/auth/user_model.dart';

import '../controllers/create_booking_controller.dart';

class CreateBookingBinding extends Bindings {
  final UserModel? user;
  CreateBookingBinding({this.user});
  @override
  void dependencies() {
    Get.lazyPut<CreateBookingController>(
      () => CreateBookingController(
        user: user,
      ),
    );
  }
}
