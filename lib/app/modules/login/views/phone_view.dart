import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:skycraft/app/constants/decorations.dart';
import 'package:skycraft/app/constants/theme_data.dart';
import 'package:skycraft/app/modules/login/bindings/login_binding.dart';
import 'package:skycraft/app/modules/login/views/email_view.dart';
import 'package:skycraft/app/widgets/buttons/gradient_button.dart';
import 'package:skycraft/app/widgets/screen.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Screen(
      body: Form(
        key: controller.phoneFormKey,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin:
                      EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  padding: const EdgeInsets.all(20),
                  child: Image.asset(
                    'assets/skykraft-White.png',
                    // height: 100,
                    // width: 100,
                  ),
                ),
                const SizedBox(height: 100),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Phone Number',
                          style: TextStyle(
                            // color: kPrimaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          )),
                    ),
                    TextFormField(
                      controller: controller.phoneNumberController,
                      decoration: FieldDecoration(
                        hintText: 'Enter your phone number',
                        prefixIcon: const Padding(
                          padding: EdgeInsets.only(left: 10, top: 14),
                          child: Text(
                            '+91  ',
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ).kInputDecoration,
                      style: const TextStyle(
                        color: kPrimaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      enableSuggestions: true,
                      enableInteractiveSelection: true,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(10),
                      ],
                      validator: (value) {
                        if (value!.isEmpty ||
                            !RegExp(
                              r'^(?:[+0]9)?[0-9]{10}$',
                              multiLine: false,
                            ).hasMatch(value)) {
                          return 'Please enter a valid phone number';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.phone,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                GradientButton(
                  onPressed: () {
                    if (controller.phoneFormKey.currentState!.validate()) {
                      controller.sendOtp();
                    }
                  },
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Send OTP',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      // arrow icon
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // or login with email and password
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'or login with',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 10),
                    TextButton(
                      onPressed: () {
                        Get.off(
                          () => const EmailView(),
                          binding: LoginBinding(),
                        );
                      },
                      child: const Text(
                        'Email and Password',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Terms of Service',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      'and',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Privacy Policy',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
