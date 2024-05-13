import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:skycraft/app/constants/decorations.dart';
import 'package:skycraft/app/constants/theme_data.dart';
import 'package:skycraft/app/widgets/buttons/gradient_button.dart';
import 'package:skycraft/app/widgets/email_field.dart';
import 'package:skycraft/app/widgets/pass_field.dart';
import 'package:skycraft/app/widgets/screen.dart';

import '../controllers/login_controller.dart';

class EmailView extends GetView<LoginController> {
  const EmailView({super.key});
  @override
  Widget build(BuildContext context) {
    return Screen(
      body: Form(
        key: controller.emailFormKey,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    child: Column(
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
                Obx(() => Row(
                      children: [
                        // sign in view or sign up view selection
                        InkWell(
                          onTap: () {
                            controller.isViewSignUp.value = false;
                          },
                          child: AnimatedContainer(
                            padding: const EdgeInsets.only(
                                bottom: 10, left: 5, right: 5, top: 5),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: !controller.isViewSignUp.value
                                      ? kTitleColor
                                      : Colors.transparent,
                                  width: 2,
                                ),
                              ),
                            ),
                            duration: const Duration(milliseconds: 300),
                            child: Text(
                              'Sign In',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: controller.isViewSignUp.value
                                    ? kTextColor
                                    : kTitleColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        InkWell(
                          onTap: () {
                            controller.isViewSignUp.value = true;
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            padding: const EdgeInsets.only(
                                bottom: 10, left: 5, right: 5, top: 5),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: !controller.isViewSignUp.value
                                      ? Colors.transparent
                                      : kTitleColor,
                                  width: 2,
                                ),
                              ),
                            ),
                            child: Text(
                              'Sign Up',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: controller.isViewSignUp.value
                                    ? kTitleColor
                                    : kTextColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
                const SizedBox(height: 20),
                Obx(() => !controller.isViewSignUp.value
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Email',
                                style: TextStyle(
                                  // color: kPrimaryColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                )),
                          ),
                          SizedBox(
                            height: 50,
                            child: EmailTextField(
                              controller: controller.emailController,
                              name: 'email',
                              onTap: () {},
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Password',
                                style: TextStyle(
                                  // color: kPrimaryColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                )),
                          ),
                          SizedBox(
                            height: 50,
                            child: PassWordField(
                              controller: controller.passwordController,
                              name: 'pass',
                              onTap: () {},
                            ),
                          ),
                          const SizedBox(height: 40),
                          Obx(
                            () => GradientButton(
                                onPressed: () {
                                  controller.signIn();
                                },
                                isLoading: controller.isLoading.value,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: const Text(
                                  'Sign In',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )),
                          ),
                        ],
                      )
                    : Column(
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
                            child: Text('Email',
                                style: TextStyle(
                                  // color: kPrimaryColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                )),
                          ),
                          EmailTextField(
                            controller: controller.emailController,
                            name: 'email',
                            onTap: () {},
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Phone Number',
                                style: TextStyle(
                                  // color: kPrimaryColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                )),
                          ),
                          // phone number field
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
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Password',
                                style: TextStyle(
                                  // color: kPrimaryColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                )),
                          ),
                          PassWordField(
                            controller: controller.passwordController,
                            name: 'pass',
                            onTap: () {},
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Confirm Password',
                                style: TextStyle(
                                  // color: kPrimaryColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                )),
                          ),
                          PassWordField(
                            controller: controller.confirmPasswordController,
                            name: 'pass',
                            onTap: () {},
                            validator: (p0) {
                              if (p0 != controller.passwordController.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                          ),
                          //

                          const SizedBox(height: 40),
                          Obx(
                            () => GradientButton(
                                isLoading: controller.isLoading.value,
                                onPressed: () {
                                  controller.signUp();
                                },
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: const Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )),
                          ),
                        ],
                      )),
                const SizedBox(height: 20),
                // const Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Text(
                //       'Terms of Service',
                //       style: TextStyle(
                //         fontSize: 12,
                //         fontWeight: FontWeight.w500,
                //       ),
                //     ),
                //     SizedBox(width: 10),
                //     Text(
                //       'and',
                //       style: TextStyle(
                //         fontSize: 12,
                //         fontWeight: FontWeight.w500,
                //       ),
                //     ),
                //     SizedBox(width: 10),
                //     Text(
                //       'Privacy Policy',
                //       style: TextStyle(
                //         fontSize: 12,
                //         fontWeight: FontWeight.w500,
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
