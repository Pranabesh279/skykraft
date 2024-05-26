import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skycraft/app/routes/app_pages.dart';

Widget privacyPolicyLinkAndTermsOfService() {
  return Container(
    alignment: Alignment.center,
    padding: const EdgeInsets.all(10),
    child: Center(
        child: Text.rich(TextSpan(
            text: 'By continuing, you agree to our ',
            style: const TextStyle(fontSize: 16, color: Colors.black),
            children: <TextSpan>[
          TextSpan(
              text: 'Terms of Service',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Get.toNamed(Routes.TERMS_AND_CONDITIONS);
                }),
          TextSpan(
              text: ' and ',
              style: const TextStyle(fontSize: 18, color: Colors.black),
              children: <TextSpan>[
                TextSpan(
                    text: 'Privacy Policy',
                    style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        decoration: TextDecoration.underline),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Get.toNamed(Routes.PRIVACY_POLICY);
                      })
              ])
        ]))),
  );
}
