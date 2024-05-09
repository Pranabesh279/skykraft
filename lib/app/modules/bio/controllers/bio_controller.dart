import 'dart:developer';

import 'package:get/get.dart';
import 'package:skycraft/app/models/auth/user_model.dart';
import 'package:skycraft/app/modules/create_booking/bindings/create_booking_binding.dart';
import 'package:skycraft/app/modules/create_booking/views/create_booking_view.dart';
import 'package:skycraft/app/providers/auth_provider.dart';

class BioController extends GetxController {
  UserModel? user;
  BioController({this.user});

  isNotSameUser() {
    return user!.uid != Get.find<AuthProvider>().uid;
  }
}
