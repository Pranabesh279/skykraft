import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:skycraft/app/constants/theme_data.dart';
import 'package:skycraft/app/widgets/buttons/gradient_button.dart';

import '../controllers/auth_phone_verify_controller.dart';

class AuthPhoneVerifyView extends GetView<AuthPhoneVerifyController> {
  const AuthPhoneVerifyView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CupertinoNavigationBar(
        middle: Text('Verify Phone'),
      ),
      body: SizedBox(
        width: Get.width,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text(
                'Enter the OTP sent to your phone',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                '${controller.countryCode.value} ${controller.phone.value}',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              PinCodeTextField(
                appContext: context,
                length: 6,
                obscureText: false,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onChanged: (value) {
                  controller.otp.value = value;
                },
                onCompleted: (value) {
                  // controller.signInWithOTP(
                  //     controller.verificationCode.value, controller.otp.value);
                },
                keyboardType: TextInputType.number,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  activeFillColor: Colors.grey[200],
                  inactiveFillColor: Colors.grey[200],
                  selectedFillColor: Colors.grey[200],
                  activeColor: Colors.grey[200],
                  inactiveColor: Colors.grey[200],
                  selectedColor: Colors.grey[200],
                ),
              ),
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Didn\'t get the code?',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    controller.isSending.value
                        ? const SizedBox(
                            height: 16,
                            width: 16,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                kPrimary,
                              ),
                              strokeWidth: 2,
                            ),
                          )
                        : controller.codeSent.value
                            ? Text(
                                '${controller.minutes()}:${controller.seconds()}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            : InkWell(
                                onTap: () {
                                  controller.verifyPhone(
                                    '+91${controller.phone.trim()}',
                                  );
                                },
                                child: const Text(
                                  'Resend',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: kPrimary,
                                  ),
                                ),
                              ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(
                () => controller.isSending.value
                    ? const SizedBox()
                    : controller.isVerifing.value
                        ? const SizedBox(
                            height: 16,
                            width: 16,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                kPrimary,
                              ),
                              strokeWidth: 2,
                            ),
                          )
                        : GradientButton(
                            onPressed: () {
                              log('verify clicked ${controller.codeSent.value}');
                              if (controller.otp.value.length != 6) return;
                              controller.continueClicked();
                            },
                            disable:
                                controller.otp.value.length == 6 ? false : true,
                            child: const Text(
                              'Verify',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
