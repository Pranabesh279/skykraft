import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:skycraft/app/constants/decorations.dart';
import 'package:skycraft/app/constants/theme_data.dart';
import 'package:skycraft/app/routes/app_pages.dart';
import 'package:skycraft/app/widgets/buttons/gradient_button.dart';
import 'package:skycraft/app/widgets/i_aggred.dart';

import '../controllers/auth_phone_controller.dart';

class AuthPhoneView extends GetView<AuthPhoneController> {
  const AuthPhoneView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Form(
            key: controller.fromKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).padding.top),
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: Image.asset(
                            'assets/skykraft-White.png',
                            color: kPrimaryColor,
                            width: 140,
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    )),
                const SizedBox(
                  height: 40,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Enter Your Phone Number',
                      style: TextStyle(
                        // color: kPrimaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      )),
                ),
                TextFormField(
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    if (value.length < 10) {
                      return 'Please enter valid phone number';
                    }
                    // regExp.hasMatch(value)
                    final regExp = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
                    if (!regExp.hasMatch(value)) {
                      return 'Please enter valid phone number';
                    }
                    return null;
                  },
                  controller: controller.phoneController,
                  style: const TextStyle(fontSize: 12, color: kPrimaryColor),
                  keyboardType: TextInputType.phone,
                  decoration: FieldDecoration(
                    hintText: 'Enter Your Phone Number',
                    prefixIcon: Container(
                      alignment: Alignment.center,
                      width: 50,
                      padding: const EdgeInsets.all(8.0),
                      child: const Text('+91'),
                    ),
                  ).kInputDecoration,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Obx(
                      () => Checkbox(
                        value: controller.isChecked.value,
                        onChanged: (value) {
                          controller.isChecked.value = value!;
                        },
                      ),
                    ),
                    Expanded(child: privacyPolicyLinkAndTermsOfService()),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Obx(() => GradientButton(
                      onPressed: () {
                        controller.continueClicked();
                      },
                      disable: !controller.isChecked.value,
                      child: const Text(
                        'Continue',
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
                const SizedBox(
                  height: 20,
                ),
                // login with email
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Login with Email ?'),
                    TextButton(
                      onPressed: () {
                        Get.toNamed(Routes.LOGIN);
                      },
                      child: const Text('Click Here'),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
