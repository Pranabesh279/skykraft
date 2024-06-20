import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';
import 'package:skycraft/app/constants/decorations.dart';
import 'package:skycraft/app/constants/theme_data.dart';
import 'package:skycraft/app/helpers/image_picker.dart';
import 'package:skycraft/app/modules/AddUserProfile/widgets/profikle_avatar.dart';
import 'package:skycraft/app/widgets/buttons/gradient_button.dart';
import 'package:skycraft/app/widgets/email_field.dart';

import '../controllers/add_user_profile_controller.dart';

class AddUserProfileView extends GetView<AddUserProfileController> {
  const AddUserProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('AddUserProfileView'),
      //   centerTitle: true,
      // ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 20),
        width: double.infinity,
        child: SingleChildScrollView(
          child: Form(
            key: controller.fromKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //  set user role - dron pilot or client
                const Text(
                  'Select Your User Avatar, and Others details Please!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Obx(
                  () => ProfileAvatar(
                    imageFile: controller.imageFile.value,
                    onTap: () {
                      Get.bottomSheet(
                        ImagePickerPopup(
                          onTapCamera: (file) {
                            controller.imageFile.value = file;
                            // controller.update();
                          },
                          onTapGallery: (file) {
                            controller.imageFile.value = file;
                            // controller.update();
                          },
                        ),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        backgroundColor: Colors.white,
                        isScrollControlled: false,
                        ignoreSafeArea: true,
                      );
                    },
                  ),
                ),
                Obx(() => controller.avatarUrlError.value != null
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          controller.avatarUrlError.value!,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
                      )
                    : const SizedBox.shrink()),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text('Username',
                      style: TextStyle(
                        // color: kPrimaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      )),
                ),
                TextFormField(
                  controller: controller.nameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Username is required';
                    }
                    return null;
                  },
                  inputFormatters: [
                    // FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(40),
                  ],
                  style: const TextStyle(fontSize: 12, color: kPrimaryColor),
                  keyboardType: TextInputType.name,
                  decoration: FieldDecoration(
                    hintText: 'Enter Your Username',
                  ).kInputDecoration,
                ),
                const SizedBox(
                  height: 40,
                ),
                GradientButton(
                  onPressed: () {
                    controller.submit();
                  },
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Obx(() => controller.isLoading.value
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text(
                          'Next',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
