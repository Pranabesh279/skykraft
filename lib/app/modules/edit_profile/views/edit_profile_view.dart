import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:skycraft/app/constants/decorations.dart';
import 'package:skycraft/app/constants/theme_data.dart';
import 'package:skycraft/app/widgets/buttons/gradient_button.dart';
import 'package:skycraft/app/widgets/email_field.dart';
import 'package:skycraft/app/widgets/profile_image.dart';

import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: CupertinoNavigationBar(
            leading: TextButton.icon(
              icon: Icon(
                CupertinoIcons.back,
                color: Theme.of(context).primaryColor,
                size: 20,
              ),
              onPressed: () {
                Get.back();
              },
              label: Text('Back',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  )),
            ),
            middle: Text('Edit Profile',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                )),
          )),
      body: Obx(() => Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // const SizedBox(height: 10),
                controller.user.value == null
                    ? const CircularProgressIndicator()
                    : ProfileImage(
                        name: controller.user.value?.name ?? '',
                        userRole: controller.user.value?.role ?? '',
                        size: 80,
                      ),
                const SizedBox(height: 10),
                // user Role and name
                Text(
                  'Hi, ${(controller.user.value?.role ?? '').capitalizeFirst}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Divider(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                ),
                Expanded(
                    child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Username',
                            style: TextStyle(
                              // color: kPrimaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            )),
                      ),
                      EmailTextField(
                        controller: controller.usernameController,
                        name: 'email',
                        onTap: () {},
                        validator: (p0) {
                          if (p0!.isEmpty) {
                            return 'Username is required';
                          }
                          return null;
                        },
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Email (Cannot be changed)',
                            style: TextStyle(
                              // color: kPrimaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            )),
                      ),
                      EmailTextField(
                        controller: controller.emailController,
                        name: 'email',
                        enabled: false,
                        onTap: () {},
                      ),
                      // const Padding(
                      //   padding: EdgeInsets.all(8.0),
                      //   child: Text('Phone Number (Cannot be changed)',
                      //       style: TextStyle(
                      //         // color: kPrimaryColor,
                      //         fontSize: 12,
                      //         fontWeight: FontWeight.w500,
                      //       )),
                      // ),
                      // // phone number field
                      // TextFormField(
                      //   controller: controller.phoneNumberController,
                      //   enabled: false,
                      //   decoration: FieldDecoration(
                      //     hintText: 'Enter your phone number',
                      //     prefixIcon: const Padding(
                      //       padding: EdgeInsets.only(left: 10, top: 14),
                      //       child: Text(
                      //         '+91  ',
                      //         style: TextStyle(
                      //           color: kPrimaryColor,
                      //           fontSize: 16,
                      //           fontWeight: FontWeight.w500,
                      //         ),
                      //       ),
                      //     ),
                      //   ).kInputDecoration,
                      //   style: const TextStyle(
                      //     color: kPrimaryColor,
                      //     fontSize: 16,
                      //     fontWeight: FontWeight.w500,
                      //   ),
                      //   enableSuggestions: true,
                      //   enableInteractiveSelection: true,
                      //   inputFormatters: [
                      //     LengthLimitingTextInputFormatter(10),
                      //   ],
                      //   validator: (value) {
                      //     if (value!.isEmpty ||
                      //         !RegExp(
                      //           r'^(?:[+0]9)?[0-9]{10}$',
                      //           multiLine: false,
                      //         ).hasMatch(value)) {
                      //       return 'Please enter a valid phone number';
                      //     }
                      //     return null;
                      //   },
                      //   keyboardType: TextInputType.phone,
                      // ),
                    ],
                  ),
                )),

                const SizedBox(height: 40),
                Obx(
                  () => GradientButton(
                      isLoading: controller.isLoading.value,
                      onPressed: () async {
                        controller.updateUser();
                      },
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Text(
                        'Update Profile',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      )),
                ),
                // delete account button  text with red colors
                const SizedBox(height: 20),
                TextButton.icon(
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 20,
                  ),
                  onPressed: () {
                    Get.dialog(
                      AlertDialog(
                        backgroundColor: kBackgroundColor,
                        title: const Text('Are you sure?'),
                        content:
                            const Text('Do you want to delete your account?'),
                        actions: [
                          TextButton(
                            onPressed: () => Get.back(),
                            child: const Text('No'),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.back();
                              controller.authProvider.deleteUser();
                            },
                            child: const Text('Yes'),
                          ),
                        ],
                      ),
                    );
                  },
                  label: const Text(
                    'Delete Account',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
