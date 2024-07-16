import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:skycraft/app/constants/theme_data.dart';
import 'package:skycraft/app/widgets/buttons/gradient_button.dart';
import 'package:skycraft/app/widgets/email_field.dart';
import 'package:skycraft/app/widgets/i_aggred.dart';
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
                            controller.isChecked.value = false;
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
                            controller.isChecked.value = false;
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
                                  // if (!controller.isChecked.value) {
                                  //   Get.snackbar('Hey!',
                                  //       'Please agree to the terms of service and privacy policy');
                                  //   return;
                                  // }
                                  controller.signIn();
                                },
                                disable: !controller.isChecked.value,
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
                                disable: !controller.isChecked.value,
                                onPressed: () {
                                  // if (!controller.isChecked.value) {
                                  //   Get.snackbar('Hey!',
                                  //       'Please agree to the terms of service and privacy policy');
                                  //   return;
                                  // }
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
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 0.8,
                          color: kGreyColor,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'or',
                          style: TextStyle(
                            color: kGreyColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 0.8,
                          color: kGreyColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: SignInButton(
                    shape: ShapeBorder.lerp(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        0.5),
                    Buttons.google,
                    onPressed: () {
                      controller.signInWithGoogle();
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    // Obx(
                    //   () => Checkbox(
                    //     value: controller.isChecked.value,
                    //     onChanged: (value) {
                    //       controller.isChecked.value = value!;
                    //     },
                    //   ),
                    // ),
                    Expanded(child: privacyPolicyLinkAndTermsOfService()),
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
